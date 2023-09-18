import 'package:flutter/material.dart';
import 'package:medium_uz/data/models/user/user_model.dart';
import 'package:medium_uz/presentation/auth/gmail_confirm/gmail_confirm_screen.dart';
import 'package:medium_uz/presentation/tab/web/add_web.dart';
import 'package:medium_uz/presentation/tab/web/web_detail.dart';
import 'auth/register screens/login_screen.dart';
import 'auth/register screens/signup_screen.dart';
import 'splash/splash_screen.dart';
import 'tab/tab_box.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/auth_screen";
  static const String registerScreen = "/register_screen";
  static const String tabBox = "/tab_box";
  static const String confirmGmail = "/confirm_gmail";
  static const String addWebsite = "/add_website";
  static const String detailWebScreen = "/detail_web_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case RouteNames.detailWebScreen:
        return MaterialPageRoute(
          builder: (context) {
            return WebDetailScreen(
              id: settings.arguments as int,
            );
          },
        );
      case RouteNames.registerScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterScreen();
          },
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (context) => const TabBox(),
        );
      case RouteNames.confirmGmail:
        return MaterialPageRoute(
          builder: (context) => GmailConfirmScreen(
            userModel: settings.arguments as UserModel,
          ),
        );
      case RouteNames.addWebsite:
        return MaterialPageRoute(
          builder: (context) => const AddWebsiteScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found !"),
            ),
          ),
        );
    }
  }
}
