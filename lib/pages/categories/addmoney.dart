import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwave_standard/flutterwave.dart';


class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  String selectedPaymentMethod = 'applePay';
    final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handlePaymentMethodChange(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  
Future<void> _processPaymentWithFlutterwave() async {
  final String amount = _amountController.text.trim();

  // Validate the amount
  if (amount.isEmpty || double.tryParse(amount) == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid amount')),
    );
    return;
  }

  // Prepare the Flutterwave payment details
  final Flutterwave flutterwave = Flutterwave.forUIPayment(
      amount: amount,
      currency: 'NGN',
      context: this.context,
      publicKey: 'FLWPUBK-xxxxxxxxxxxxxxxxxxxxx-X',
      encryptionKey: 'FLWSECK-xxxxxxxxxxxxxxxxxxxxx-X',
      email: 'customer@example.com',
      fullName: 'Customer Name',
      txRef: DateTime.now().toIso8601String(),
      isDebugMode: true, // Set to false in production
      phoneNumber: '08123456789',
      paymentOptions: 'card, mobilemoney, ussd',
      redirectUrl: 'https://www.your-redirect-url.com/',
  );

  try {
    // Initiate the payment process and await the response
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      // Check if transaction is successful
      if (response.status == FlutterwaveConstants.SUCCESSFUL) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment successful: ${response.transactionId}')),
        );
      } else {
        // Handle unsuccessful transaction
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${response.message}')),
        );
      }
    } else {
      // Handle null response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No response from Flutterwave')),
      );
    }
  } catch (error) {
    // Handle errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment error: $error')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Money to your account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'To get account details, you need to add money to your account. You\'ll be able to use this money once it\'s there.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Add',
                prefixText: '£',
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(CupertinoIcons.creditcard_fill),
              title: const Text('Apple Pay'),
              trailing: Icon(
                selectedPaymentMethod == 'applePay' ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selectedPaymentMethod == 'applePay' ? Colors.blue : null,
              ),
              onTap: () => _handlePaymentMethodChange('applePay'),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit or Debit card'),
              trailing: Icon(
                selectedPaymentMethod == 'card' ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selectedPaymentMethod == 'card' ? Colors.blue : null,
              ),
              onTap: () => _handlePaymentMethodChange('card'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Add £50.00 GBP'),
              onPressed: _processPaymentWithFlutterwave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
