import 'package:ecommerce_app/controllers/cart_provider.dart';
import 'package:ecommerce_app/controllers/favorites_provider.dart';
import 'package:ecommerce_app/controllers/main_screen_provider.dart';
import 'package:ecommerce_app/controllers/product_provider.dart';
import 'package:ecommerce_app/views/ui/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox("cart_box");
  await Hive.openBox("fav_box");
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
      ChangeNotifierProvider(create: (context) => ProductNotifier()),
      ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
      ChangeNotifierProvider(create: (context) => CartNotifier()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Jackets e-Store",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignInPage(),
    );
  }
}
