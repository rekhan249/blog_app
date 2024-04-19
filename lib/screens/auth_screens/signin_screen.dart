import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/auth_models/signin_model.dart';
import 'package:blogs_app/screens/auth_screens/signup_screen.dart';
import 'package:blogs_app/screens/blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Login",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Please enter yours credential here",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 105, 91),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor:
                        const Color.fromARGB(255, 1, 105, 91).withOpacity(0.2),
                    filled: true,
                    prefixIcon: const Icon(Icons.email)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor:
                      const Color.fromARGB(255, 1, 105, 91).withOpacity(0.2),
                  filled: true,
                  prefixIcon: const Icon(Icons.key),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Color.fromARGB(255, 1, 105, 91)),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool isValid = formKey.currentState!.validate();
                    FocusScope.of(context).unfocus();
                    if (!isValid) {
                      return;
                    }
                    formKey.currentState!.save();
                    await formSubmittionAndAuthenticate(
                        emailController.text, passwordController.text, context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromARGB(255, 1, 105, 91),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color.fromARGB(255, 1, 105, 91)),
            ))
      ],
    );
  }

  formSubmittionAndAuthenticate(
    String email,
    String password,
    BuildContext context,
  ) async {
    SignInModel signInModel = SignInModel(email: email, password: password);
    try {
      BlogsDatabase? blogsDatabase = BlogsDatabase.instance;

      if (email.isNotEmpty && password.isNotEmpty) {
        blogsDatabase.createUserWhileSignIn(signInModel);
        Fluttertoast.showToast(
            msg: "Sign-In successfully${signInModel.toMap()}");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BlogScreen()));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong $e");
    }
  }
}
