import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:flutter/material.dart';

import '../ui/main_screen.dart';
import '../ui/sign_in_page.dart';

void showAuthResultDialog(BuildContext context, bool isSuccess, bool isSignUp) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Column(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              isSuccess
                  ? (isSignUp ? 'Successfully Signed Up!' : 'Successfully Signed In!')
                  : (isSignUp ? 'Sign Up Failed' : 'Sign In Failed'),
              style: appStyle(20, Colors.black, FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          isSuccess
              ? (isSignUp
              ? 'You have successfully created an account. Please log in to continue.'
              : 'Welcome back!')
              : 'An error occurred. Please try again.',
          textAlign: TextAlign.center,
          style: appStyle(18, Colors.black38, FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                if (isSignUp) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                }
              }
            },
            child: const Text('OK', style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    },
  );
}
