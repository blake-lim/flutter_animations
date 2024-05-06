import 'dart:math';
import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final Animation<double> _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late Animation<double> _progress =
      Tween(begin: 0.005, end: 1.5).animate(_curve);

  void _animateValues() {
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    setState(() {
      _progress = Tween(begin: _progress.value, end: newEnd).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Apple Watch'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => CustomPaint(
            painter: AppleWatchPainter(progress: _progress.value),
            size: const Size(400, 400),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;
  AppleWatchPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const startingAngle = -0.5 * pi;
    _drawCircle(canvas, center, size.width / 2 * 0.9, Colors.red, progress);
    _drawCircle(canvas, center, size.width / 2 * 0.76, Colors.green, progress);
    _drawCircle(canvas, center, size.width / 2 * 0.62, Colors.blue, progress);
  }

  void _drawCircle(Canvas canvas, Offset center, double radius, Color color,
      double progress) {
    final circlePaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    canvas.drawCircle(center, radius, circlePaint);

    final arcRect = Rect.fromCircle(center: center, radius: radius);
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(arcRect, -0.5 * pi, progress * pi, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
