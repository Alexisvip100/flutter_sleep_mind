import 'package:flutter/material.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: const Center(
          child: Text(
            'Sleep Routine',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
