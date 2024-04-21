import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/auth_models/signup_model.dart';
import 'package:blogs_app/screens/auth_screens/signin_screen.dart';
import 'package:blogs_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassowordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Create your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 1, 105, 91)),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            fillColor: const Color.fromARGB(255, 1, 105, 91)
                                .withOpacity(0.2),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            fillColor: const Color.fromARGB(255, 1, 105, 91)
                                .withOpacity(0.2),
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
                          fillColor: const Color.fromARGB(255, 1, 105, 91)
                              .withOpacity(0.2),
                          filled: true,
                          prefixIcon: const Icon(Icons.key),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPassowordController,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 1, 105, 91)
                              .withOpacity(0.2),
                          filled: true,
                          prefixIcon: const Icon(Icons.key),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          child: ElevatedButton(
                            onPressed: () async {
                              bool isValid = formKey.currentState!.validate();
                              FocusScope.of(context).unfocus();
                              if (!isValid) {
                                return;
                              }
                              formKey.currentState!.save();
                              await formSubmittionAndAuthenticate(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  confirmPassowordController.text,
                                  context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 105, 91),
                            ),
                            child: const Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 1, 105, 91)),
                              ))
                        ],
                      )
                    ],
                  ),
                ))));
  }

  formSubmittionAndAuthenticate(
    String username,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    SignUpModel signUpModel = SignUpModel(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword);
    try {
      BlogsDatabase? blogsDatabase = BlogsDatabase.instance;

      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        blogsDatabase.createUserWhileSignUp(signUpModel);
        Fluttertoast.showToast(
            msg: "Data save successfully ${signUpModel.toMap()}");
        Navigator.pushNamed(context, RouteGenerator.login);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong $e");
    }
  }
}
