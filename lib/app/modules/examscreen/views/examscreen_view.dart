import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/examscreen_controller.dart';

class ExamscreenView extends GetView<ExamscreenController> {
  const ExamscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExamscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
