import 'package:flutter/material.dart';

class WelcomePageImages {
  // Rutas de las imágenes
  static const String backgroundImage = "assets/images/background.jpeg";
  static const String page3OverlayImage = "assets/images/slap-hands.png";
  static const String page4BackgroundImage = "assets/images/points.png";
  static const String page4OverlayImage = "assets/images/team.png";
  
  // Preload de imágenes para mejor rendimiento
  static Future<void> preloadImages(BuildContext context) async {
    try {
      await precacheImage(const AssetImage(backgroundImage), context);
      await precacheImage(const AssetImage(page3OverlayImage), context);
      await precacheImage(const AssetImage(page4BackgroundImage), context);
      await precacheImage(const AssetImage(page4OverlayImage), context);
    } catch (e) {
      debugPrint('Error preloading images: $e');
    }
  }
  
  // Widget de imagen con manejo de errores
  static Widget buildImageWithFallback({
    required String imagePath,
    required double? width,
    required double? height,
    BoxFit fit = BoxFit.cover,
    Widget? fallback,
  }) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return fallback ?? Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image,
            color: Colors.grey,
          ),
        );
      },
    );
  }
  
}
