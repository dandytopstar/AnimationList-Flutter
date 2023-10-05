import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const AnimatedLoader());
}

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyLoaderScreen(),
    );
  }
}

class MyLoaderScreen extends StatelessWidget {
  const MyLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            size: 75, color: Colors.deepPurple),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
