import 'package:flutter/material.dart';
import 'package:journal_capture/pages/journal_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set up global error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('🔴 Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // Set up custom error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text('An error occurred: ${details.exception}'),
      ),
    );
  };

  debugPrint('📱 Starting JournalCapture app...');
  runApp(const JournalCaptureApp());
}

class JournalCaptureApp extends StatelessWidget {
  
  const JournalCaptureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JournalCapture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JournalListScreen(),
    );
  }
}

// LEARNING NOTES FOR YOU:
// 
// 1. AnimationController: Not used directly here because PageRouteBuilder 
//    provides the animation object automatically. But it works the same way.
//
// 2. Matrix4.identity(): Creates a 4x4 transformation matrix
//    - setEntry(3, 2, 0.003): Adds perspective (makes far things look smaller)
//    - rotateY(): Rotates around the Y-axis (vertical axis)
//
// 3. The animation value goes from 0 to 1:
//    - At 0: No rotation (page is flat)
//    - At 1: Full rotation (page has turned)
//
// 4. Try changing these values to see the effect:
//    - transitionDuration: Speed of the animation
//    - Curves: Movement feel (easeInOut, bounceOut, etc.)
//    - 0.003 in setEntry: Perspective strength
//    - math.pi / 2: Rotation amount (try math.pi / 3 for less rotation)
//    - alignment: Try Alignment.centerRight for opposite direction
//
// NEXT STEPS:
// 1. Run this code and feel the animation
// 2. Experiment with the values mentioned above
// 3. Try adding a shadow overlay for more depth
// 4. Consider adding a "page curl" effect on the edge