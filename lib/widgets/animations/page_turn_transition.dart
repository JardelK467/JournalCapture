import 'dart:math' as math;
import 'package:flutter/material.dart';

class PageTurnTransition extends PageRouteBuilder {
  final Widget child;

  PageTurnTransition({
    required this.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          maintainState: true,
          opaque: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final reverse = secondaryAnimation.value > 0;
            
            // Use different curves for forward and reverse animations
            final curve = reverse 
                ? Curves.easeInOutCubic.flipped 
                : Curves.easeInOutCubic;

            final curvedProgress = curve.transform(animation.value);
            
            return Material(
              // Wrap everything in Material widget to ensure proper rendering
              child: Stack(
                children: [
                  // Static background (next/previous page)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white,
                      child: child,
                    ),
                  ),
                  
                  // Animated turning page
                  if (curvedProgress < 0.9) // Only show turning page during animation
                    Positioned.fill(
                      child: Transform(
                        alignment: reverse ? Alignment.centerRight : Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Add perspective
                          ..rotateY((reverse ? 1 : -1) * curvedProgress * math.pi / 2),
                        child: Container(
                          color: Colors.white,
                          child: child,
                        ),
                      ),
                    ),

                  // Page turn shadow
                  if (curvedProgress > 0.0)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: reverse ? Alignment.centerRight : Alignment.centerLeft,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(0.4 * curvedProgress),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
}

class PageCurlShadowPainter extends CustomPainter {
  final double progress;
  final bool reverse;

  PageCurlShadowPainter({
    required this.progress,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final shadowPath = Path();
    final width = size.width;
    final height = size.height;

    if (reverse) {
      // Right to left curl
      final x = width * (1 - progress * 0.5);
      shadowPath.moveTo(x, 0);
      shadowPath.quadraticBezierTo(
        x + (width * 0.1 * progress), height / 2,
        x, height,
      );
    } else {
      // Left to right curl
      final x = width * progress * 0.5;
      shadowPath.moveTo(x, 0);
      shadowPath.quadraticBezierTo(
        x - (width * 0.1 * progress), height / 2,
        x, height,
      );
    }

    paint.color = Colors.black.withOpacity(0.3 * (1 - progress));
    canvas.drawPath(shadowPath, paint);
  }

  @override
  bool shouldRepaint(covariant PageCurlShadowPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.reverse != reverse;
  }
}
