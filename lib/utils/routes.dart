import 'package:blogs_app/screens/auth_screens/signin_screen.dart';
import 'package:blogs_app/screens/auth_screens/signup_screen.dart';
import 'package:blogs_app/screens/blogs/add_new_blog.dart';
import 'package:blogs_app/screens/blogs_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String blogs = 'blogs';
  static const String addblog = 'addblogs';
  static const String editblog = 'editblogs';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case blogs:
        return MaterialPageRoute(builder: (_) => const BlogScreen());
      case addblog:
        return MaterialPageRoute(
            builder: (_) => const AddNewBlogsScreen(
                  title: 'Add New Blog',
                ));

      default:
        throw 'Route not found';
    }
  }
}
