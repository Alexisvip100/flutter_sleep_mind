import 'package:flutter/material.dart';
import 'package:sleep_mind/app/presentation/pages/login/welcome_page.dart';
import 'package:sleep_mind/app/presentation/pages/login/google_login_screen.dart';
import 'package:sleep_mind/app/presentation/widgets/login/auth_guard.dart';
import 'package:sleep_mind/app/config/router/navbar_app.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    welcome: (context) => const GuestGuard(child: WelcomePage()),
    login: (context) => const GuestGuard(child: LoginPage()),
    home: (context) => const AuthGuard(child: NavBarApp()),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const GuestGuard(child: WelcomePage()));
      case login:
        return MaterialPageRoute(builder: (_) => const GuestGuard(child: LoginPage()));
      case home:
        return MaterialPageRoute(
          builder: (_) => const AuthGuard(child: NavBarApp()),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Página no encontrada'),
            ),
          ),
        );
    }
  }
}
