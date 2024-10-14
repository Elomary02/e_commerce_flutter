import 'package:flutter/material.dart';

import '../models/jackets_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _jacketSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get jacketSizes => _jacketSizes;

  set jacketSizes(List<dynamic> newSizes) {
    _jacketSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _jacketSizes.length; i++) {
      if (i == index) {
        _jacketSizes[i]["isSelected"] = !_jacketSizes[i]["isSelected"];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<Jacket>> men;
  late Future<List<Jacket>> women;
  late Future<List<Jacket>> kids;
  late Future<Jacket> jacket;

  void getMen() {
    men = Helper().getMenJackets();
  }

  void getWomen() {
    women = Helper().getWomenJackets();
  }

  void getKids() {
    kids = Helper().getKidsJackets();
  }

  void getJackets(String id, String category) {
    if (category == "Men's jacket") {
      jacket = Helper().getMenJacketsById(id);
    } else if (category == "Women's jacket") {
      jacket = Helper().getWomenJacketsById(id);
    } else {
      jacket = Helper().getKidsJacketsById(id);
    }
  }

  Future<List<Jacket>> searchProducts(String query) async {
    final menJackets = await Helper().getMenJackets();
    final womenJackets = await Helper().getWomenJackets();
    final kidsJackets = await Helper().getKidsJackets();

    final allJackets = [...menJackets, ...womenJackets, ...kidsJackets];

    if (query.isEmpty) return allJackets;

    return allJackets
        .where((jacket) => jacket.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}