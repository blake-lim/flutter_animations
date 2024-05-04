import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                onPressed: () {},
                child: const Text('Animated Container'),
              ),
            ],
          ),
        ));
  }
}
