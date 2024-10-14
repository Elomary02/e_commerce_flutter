import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:ecommerce_app/views/ui/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User? user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wave_img.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : AssetImage("assets/images/user.png") as ImageProvider,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.email?.split('@').first ?? 'User Name',
                      style: appStyle(25, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.email ?? 'user@example.com',
                      style: appStyle(18, Colors.grey, FontWeight.w600),
                    ),
                    const Divider(height: 32),
                    ListTile(
                      leading: const Icon(
                        Icons.history,
                      ),
                      title: Text(
                        'Order History',
                        style: appStyle(16, Colors.black, FontWeight.w600),
                      ),
                      onTap: () {
                        // Implement navigation to order history
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        style: appStyle(16, Colors.black, FontWeight.w600),
                      ),
                      onTap: () {
                        // Implement navigation to settings
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(
                        'Logout',
                        style: appStyle(16, Colors.black, FontWeight.w600),
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
