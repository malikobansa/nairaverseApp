import 'package:flutter/material.dart';
import 'package:nairaverse/pages/categories/addmoney.dart';
import 'package:nairaverse/pages/categories/exchange.dart';
import 'package:nairaverse/pages/categories/statement.dart';
import 'package:nairaverse/pages/categories/details.dart';

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
                      _buildIconTextButton(context, Icons.add, 'Add money', () {
                        // Handle tap for Add money
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddMoney()),
                        );
                      }),
                      _buildIconTextButton(context, Icons.currency_exchange, 'Exchange', () {
                        // Handle tap for Exchange
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Exchange()),
                        );
                      }),
                      _buildIconTextButton(context, Icons.receipt_long, 'Statement', () {
                        // Handle tap for Statement
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Statement()),
                        );
                      }),
                      _buildIconTextButton(context, Icons.info_outline, 'Details', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Details()),
                        );
                      }),
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

  Widget _buildIconTextButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

