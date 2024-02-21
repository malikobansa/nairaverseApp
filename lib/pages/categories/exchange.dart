import 'package:flutter/material.dart';

class Exchange extends StatelessWidget {
  const Exchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exchange')),
      body: Center(
        child: Text('This is the exchange page'),
      ),
    );
  }
}