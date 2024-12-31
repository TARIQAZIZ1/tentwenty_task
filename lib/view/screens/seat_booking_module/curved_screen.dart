// Curved Screen (A static screen design at the top)
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class CurvedLine extends StatelessWidget {
  final ScrollController screenScrollController;
  final double screenWidth;

  const CurvedLine({
    super.key,
    required this.screenScrollController,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: screenScrollController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: CustomPaint(
        size: Size(screenWidth, 110),
        painter: const ScreenPainter(),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  const ScreenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Define the paint properties for the curve
    var paint = Paint()
      ..color = AppColors.inputBorderColor // Curve color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Create the path for the curve
    var path = Path()
      ..moveTo(0, size.height * 0.55) // Start slightly below the center
      ..quadraticBezierTo(
        size.width * 0.4, size.height * 0.35, // Control point in the upper-middle
        size.width-55, size.height * 0.55,      // End slightly below the center
      );

    // Draw the shadow under the curve
    canvas.drawShadow(
      path,                     // The path to cast the shadow
      AppColors.inputBorderColor.withOpacity(0.4), // Shadow color matching the curve
      20.0,                      // Small blur radius for a subtle shadow
      false,                    // Shadow without transparency
    );

    // Draw the actual curve
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
