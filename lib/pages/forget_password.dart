import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petlover/components/app_text_form_field.dart';
import 'package:petlover/values/app_colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  static Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('Error sending password reset email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending password reset email: ${e.message}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Make AppBar gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.purple, AppColors.darkPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextFormField(
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                resetPassword(context: context, email: emailController.text);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
