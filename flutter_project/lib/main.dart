import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Parent
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyChild(),
      ),
    );
  }
}

// Child
class MyChild extends StatelessWidget {
  const MyChild({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyGrandchild(),
    );
  }
}

// Grandchild
class MyGrandchild extends StatelessWidget {
  const MyGrandchild({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello from the grandchild!');
  }
}
