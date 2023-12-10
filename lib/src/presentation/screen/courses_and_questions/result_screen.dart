import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String nilai = '0';
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      nilai = ModalRoute.of(context)?.settings.arguments as String;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
