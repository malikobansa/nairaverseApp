import 'package:flutter/material.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Money')),
      body: Center(
        child: Text('This is the Add Money page'),
      ),
    );
  }
}