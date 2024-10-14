import 'package:ecommerce_app/views/ui/profile_page.dart';
import 'package:ecommerce_app/views/ui/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/main_screen_provider.dart';
import '../../services/auth/firebase_auth_services.dart';
import '../shared/bottom_navigation_bar.dart';
import 'cart_page.dart';
import 'favorites_page.dart';
import 'home_page.dart';

class MainScreen extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  MainScreen({super.key});

  List<Widget> getPageList(User? user) {
    return [
      const HomePage(),
      SearchPage(),
      const FavoritesPage(),
      CartPage(),
      ProfilePage(user: user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: getPageList(user)[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavigationBarWidget(),
        );
      },
    );
  }
}
