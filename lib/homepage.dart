import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.search, color: Colors.white),
                  Icon(Icons.add, color: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Balance Account',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '£0.00',
                    style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'GBP British Pound',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildIconTextButton(Icons.add, 'Add money'),
                      _buildIconTextButton(Icons.currency_exchange, 'Exchange'),
                      _buildIconTextButton(Icons.receipt_long, 'Statement'),
                      _buildIconTextButton(Icons.info_outline, 'Details'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Everything you send, spend, and receive with this account will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildIconTextButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }