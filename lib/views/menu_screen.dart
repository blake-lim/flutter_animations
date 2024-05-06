import 'package:flutter/material.dart';
import 'package:flutter_animations/views/apple_watch_screen.dart';
import 'package:flutter_animations/views/explicit_animations_screen.dart';
import 'package:flutter_animations/views/implicit_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Animations'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ImplicitAnimationScreen());
                },
                child: const Text('Implicit Animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ExplicitAnimationScreen());
                },
                child: const Text('Explicit Animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const AppleWatchScreen());
                },
                child: const Text('Apple Watch'),
              ),
            ],
          ),
        ));
  }
}
