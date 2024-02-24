import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';


class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  String selectedPaymentMethod = 'card';
  final TextEditingController _amountController = TextEditingController();
  final String paystackPublicKey = 'pk_live_c5240f3c34199d9da0832cec2734c2ce138007a4'; // Use your Paystack public key
  final plugin = PaystackPlugin();

  @override
  void initState() {
    initializePaystack();
    super.initState();
  }

  void initializePaystack() {
    plugin.initialize(publicKey: paystackPublicKey);
  }
  
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

  Future<void> _processPaymentWithPaystack() async {
    final String amount = _amountController.text.trim();
    final int amountInKobo = (double.tryParse(amount) ?? 100 * 100).toInt();

    if (amount.isEmpty || amountInKobo <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    var charge = Charge()
      ..amount = amountInKobo // amount in kobo
      ..email = 'customer@example.com'
      ..currency = 'NGN'
      ..reference = _getReference()
      ..putCustomField('Charged From', 'NairaVerse');

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card, // You can customize this
        charge: charge,
      );
      if (response.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment successful: ${response.reference}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${response.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment error: $e')),
      );
    }
  }

  String _getReference() {
    var now = DateTime.now();
    return 'ChargedFromNairaVerse_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}';
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
              onPressed: _processPaymentWithPaystack,
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
