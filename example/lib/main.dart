import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:num_to_word_en_vi/src/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int num = 100222;
    final cur = Currency(number: num, language: 'vi');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text to word example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              cur.textToWord(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue[600]),
            ),
          ),
        ),
      ),
    );
  }
}
