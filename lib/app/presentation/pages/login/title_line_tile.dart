import 'package:flutter/material.dart';

class TimelineTile extends StatelessWidget {
  const TimelineTile({super.key, 
    required this.time,
    required this.child,
    this.drawTopLine = true,
    this.drawBottomLine = true,
  });

  final String time;
  final Widget child;
  final bool drawTopLine;
  final bool drawBottomLine;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [     // Columna de la hora
          SizedBox(
            width: 88,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                time.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 28,
            child: SizedBox(
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (drawTopLine)
                    Positioned(
                      top: 0,
                      left: 13,
                      right: 13,
                      child: Container(height: 24, width: 2, color: Colors.white30),
                    ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6E4F0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (drawBottomLine)
                    Positioned(
                      bottom: 0,
                      left: 13,
                      right: 13,
                      child: Container(height: 24, width: 2, color: Colors.white30),
                    ),
                ],
              ),
            ),
          ),

          // Tarjeta
          Expanded(child: child),
        ],
      ),
    );
  }


  
}