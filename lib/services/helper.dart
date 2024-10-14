import 'package:ecommerce_app/models/jackets_model.dart';
import 'package:flutter/services.dart' as the_bundle;

class Helper {
  // Fetch List of men
  Future<List<Jacket>> getMenJackets() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/men_jackets.json");
    final menList = jacketFromJson(data);
    return menList;
  }

  // Fetch List of women
  Future<List<Jacket>> getWomenJackets() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/women_jackets.json");
    final womenList = jacketFromJson(data);
    return womenList;
  }

  // Fetch List of kids
  Future<List<Jacket>> getKidsJackets() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_jackets.json");
    final kidsList = jacketFromJson(data);
    return kidsList;
  }

  // Fetch Single man
  Future<Jacket> getMenJacketsById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/men_jackets.json");
    final menList = jacketFromJson(data);
    final jacket = menList.firstWhere((elem) => elem.id == id);
    return jacket;
  }

  // Fetch Single woman
  Future<Jacket> getWomenJacketsById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/women_jackets.json");
    final womenList = jacketFromJson(data);
    final jacket = womenList.firstWhere((elem) => elem.id == id);
    return jacket;
  }

  // Fetch Single kid
  Future<Jacket> getKidsJacketsById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_jackets.json");
    final kidsLis = jacketFromJson(data);
    final jacket = kidsLis.firstWhere((elem) => elem.id == id);
    return jacket;
  }
}