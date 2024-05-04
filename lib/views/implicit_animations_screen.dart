import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _visible = true;
  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ColorChangingImage(),
            const SizedBox(height: 50),
            // RotatingContainer(size: size, visible: _visible),
            // const SizedBox(height: 50),
            GoButton(onPressed: _toggleVisibility),
          ],
        ),
      ),
    );
  }
}

class ColorChangingImage extends StatelessWidget {
  const ColorChangingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(
        begin: Colors.yellow,
        end: Colors.blue,
      ),
      curve: Curves.bounceInOut,
      duration: const Duration(seconds: 5),
      builder: (context, Color? color, child) {
        return Image.network(
          'https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png',
          color: color,
          colorBlendMode: BlendMode.colorBurn,
        );
      },
    );
  }
}

class RotatingContainer extends StatelessWidget {
  final Size size;
  final bool visible;

  const RotatingContainer({
    super.key,
    required this.size,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.elasticOut,
      duration: const Duration(seconds: 2),
      width: size.width * 0.8,
      height: size.width * 0.8,
      transform: Matrix4.rotationZ(visible ? 1 : 0),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: visible ? Colors.red : Colors.amber,
        borderRadius: BorderRadius.circular(visible ? 100 : 0),
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Go'),
    );
  }
}
