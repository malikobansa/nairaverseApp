import 'package:flutter/material.dart';

class Statement extends StatelessWidget {
  const Statement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statement')),
      body: Center(
        child: Text('This is the statement page'),
      ),
    );
  }
}