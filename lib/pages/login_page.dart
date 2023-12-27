import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petlover/values/app_routes.dart';
import '../components/app_text_form_field.dart';
import '../utils/extensions.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static Future<User?> loginUsingEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged In!'),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
        // Navigate to the HomeScreen
        //Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
        AppRoutes.homeScreen.pushName();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for that email."),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong password provided for that user."),
          ),
        );
      }
    }
    return user;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffe413ff),
                      Color(0xff8d14b2),
                      Color(0xff521a65),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(13),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink,
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'lib/assets/paw.png',
                          height: 80,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: size.width * 0.5,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Welcome back!',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFormField(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please enter Email Address'
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : 'Invalid Email Address';
                      },
                      controller: emailController,
                    ),
                    AppTextFormField(
                      labelText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please enter Password'
                            : AppConstants.passwordRegex.hasMatch(value)
                                ? null
                                : 'Invalid Password';
                      },
                      controller: passwordController,
                      obscureText: isObscure,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(48, 48),
                            ),
                          ),
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AppRoutes.forgotPasswordScreen.pushName();
                      },
                      style: Theme.of(context).textButtonTheme.style,
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FilledButton(
                      onPressed:
                          _formKey.currentState?.validate() ?? false
                              ? () async {
                                 User? user = await loginUsingEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                  if(user!= null){
                                    AppRoutes.homeScreen.pushName();
                                  }else if(user == null){
                                    setState(() {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Wrong email or password!"),
                                        ),
                                      );
                                    });
                                  }
                                }
                              : null,
                      style: const ButtonStyle().copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          _formKey.currentState?.validate() ?? false
                              ? null
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.pink.shade200,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.pink.shade200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => AppRoutes.registerScreen.pushName(),
                      style: Theme.of(context).textButtonTheme.style,
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
