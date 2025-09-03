import 'package:flutter/material.dart';
import 'package:sleep_mind/core/utils/animation_slow/relaxed_fadeRoute.dart';
import 'package:sleep_mind/features/authentication/presentation/screens/auth/screen/google_login_screen.dart';
import 'welcome_page.dart';

class WelcomePageRoutes {
  static Route<dynamic> navigateToWelcomePage(BuildContext context) {
    return RelaxedFaderoute().relaxedFadeRoute(const WelcomePage());
  }
  
  static void navigateToWelcomePageAndReplace(BuildContext context) {
    Navigator.of(context).pushReplacement(
      RelaxedFaderoute().relaxedFadeRoute(const WelcomePage()),
    );
  }
  
  static void navigateToWelcomePageAndClearStack(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      RelaxedFaderoute().relaxedFadeRoute(const WelcomePage()),
      (route) => false,
    );
  }
  static Route navigateToLoginPage(BuildContext context) {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}
