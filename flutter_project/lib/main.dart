import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Reusable TextStyle constant — like a CSS class
const grandchildLabelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
  letterSpacing: 1.2,
);

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
class MyChild extends StatefulWidget {
  const MyChild({super.key});

  @override
  State<MyChild> createState() => _MyChildState();
}

class _MyChildState extends State<MyChild> {
  String _weatherData = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=40.71&longitude=-74.01&current_weather=true'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _weatherData = data.toString();
      });
    } else {
      setState(() {
        _weatherData = 'Failed to fetch weather';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyGrandchild(weatherData: _weatherData),
    );
  }
}

// Grandchild
class MyGrandchild extends StatefulWidget {
  final String weatherData;

  const MyGrandchild({super.key, required this.weatherData});

  @override
  State<MyGrandchild> createState() => _MyGrandchildState();
}

class _MyGrandchildState extends State<MyGrandchild> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyGreatGrandChild(typed: _controller.text, weatherData: widget.weatherData),
        // Way 1: inline TextStyle
        const Text(
          'Hello from the grandchild!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter something...',
          ),
        ),
      ],
    );
  }
}

// Great Grandchild
class MyGreatGrandChild extends StatelessWidget {
  final String typed;
  final String weatherData;

  const MyGreatGrandChild({super.key, required this.typed, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Typed: $typed', style: grandchildLabelStyle),
          const SizedBox(height: 8),
          Text(weatherData, style: grandchildLabelStyle),
        ],
      ),
    );
  }
}
