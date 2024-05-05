import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..addListener(() => _updateAnimationValue());

  late final Animation<Decoration> _animation = _buildDecorationAnimation();
  late final Animation<double> _rotation = _buildRotationAnimation();
  late final Animation<double> _scale = _buildScaleAnimation();
  late final Animation<Offset> _offset = _buildOffsetAnimation();
  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);

  bool _looping = false;

  final ValueNotifier<double> _value = ValueNotifier(0.0);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateAnimationValue() {
    _value.value = _animationController.value;
  }

  Animation<Decoration> _buildDecorationAnimation() {
    return DecorationTween(
      begin: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      end: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(100)),
    ).animate(_curve);
  }

  Animation<double> _buildRotationAnimation() =>
      Tween<double>(begin: 0, end: 0.5).animate(_curve);
  Animation<double> _buildScaleAnimation() =>
      Tween<double>(begin: 1, end: 1.1).animate(_curve);
  Animation<Offset> _buildOffsetAnimation() =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.5))
          .animate(_curve);

  void _toggleLooping() {
    setState(() {
      _looping = !_looping;
      _looping
          ? _animationController.repeat(reverse: true)
          : _animationController.stop();
    });
  }

  void _onSliderChanged(double value) {
    _value.value = value;
    _animationController.value = value;
  }

  Widget _buildAnimationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: _animationController.forward, child: const Text('Play')),
        ElevatedButton(
            onPressed: _animationController.stop, child: const Text('Pause')),
        ElevatedButton(
            onPressed: _animationController.reverse,
            child: const Text('Rewind')),
        ElevatedButton(
            onPressed: _toggleLooping,
            child: Text(_looping ? 'Stop' : 'Start')),
      ],
    );
  }

  Widget _buildSlider() {
    return ValueListenableBuilder<double>(
      valueListenable: _value,
      builder: (context, value, _) {
        return Slider(value: value, onChanged: _onSliderChanged);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedWidget(),
            const SizedBox(height: 50),
            _buildAnimationControls(),
            const SizedBox(height: 25),
            _buildSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWidget() {
    return SlideTransition(
      position: _offset,
      child: ScaleTransition(
        scale: _scale,
        child: RotationTransition(
          turns: _rotation,
          child: DecoratedBoxTransition(
            decoration: _animation,
            child: const SizedBox(width: 300, height: 300),
          ),
        ),
      ),
    );
  }
}
