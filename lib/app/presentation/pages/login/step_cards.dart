
import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  const StepCard({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _leadingIconFor(text),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 17.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leadingIconFor(String t) {
    final lower = t.toLowerCase();
    IconData icon = Icons.bedtime; // por defecto
    if (lower.contains('roncar') || lower.contains('ronc')) icon = Icons.nightlight_round;
    if (lower.contains('despert')) icon = Icons.wb_sunny_outlined;
    if (lower.contains('hablaste') || lower.contains('hablar')) icon = Icons.bolt_outlined;
    if (lower.contains('iniciaste') || lower.contains('etapa')) icon = Icons.bedtime;
    return Icon(icon, color: Colors.black87, size: 22);
  }
}
