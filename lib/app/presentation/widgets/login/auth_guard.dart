import 'package:flutter/material.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final String redirectRoute;

  const AuthGuard({
    super.key,
    required this.child,
    this.redirectRoute = '/login',
  });

  @override
  Widget build(BuildContext context) {
    final authStateChanges = sl<AuthStateChanges>();

    return StreamBuilder<AuthUser?>(
      stream: authStateChanges(),
      builder: (context, snapshot) {
        // Mostrar loading mientras se verifica la autenticación
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay un usuario autenticado, mostrar el contenido
        if (snapshot.hasData && snapshot.data != null) {
          return child;
        }

        // Si no hay usuario, redirigir al login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed(redirectRoute);
          }
        });

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class GuestGuard extends StatelessWidget {
  final Widget child;
  final String redirectRoute;

  const GuestGuard({
    super.key,
    required this.child,
    this.redirectRoute = '/home',
  });

  @override
  Widget build(BuildContext context) {
    final authStateChanges = sl<AuthStateChanges>();

    return StreamBuilder<AuthUser?>(
      stream: authStateChanges(),
      builder: (context, snapshot) {
        // Mostrar loading mientras se verifica la autenticación
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay un usuario autenticado, redirigir al home
        if (snapshot.hasData && snapshot.data != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed(redirectRoute);
            }
          });

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si no hay usuario, mostrar el contenido (login/welcome)
        return child;
      },
    );
  }
}
