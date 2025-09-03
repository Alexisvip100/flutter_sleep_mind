import 'package:flutter/material.dart';

class RelaxedFaderoute {
  // Ruta con transición suave tipo fade para navegar
  PageRouteBuilder relaxedFadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: child,
        );
      },
    );
  }
}
