import 'package:flutter/material.dart';


class StripeScreen extends StatefulWidget {
  final List<Map> items; // To receive items from CartScreen

  const StripeScreen({Key? key, required this.items}) : super(key: key);

  @override
  _StripeScreenState createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize Stripe
    // StripePayment.setOptions(StripeOptions(
    //   publishableKey: "YOUR_PUBLISHABLE_KEY",
    //   merchantId: "Test", // Optional
    //   androidPayMode: 'test', // Use 'production' for live mode
    // ));
  }

  void _pay() async {
    // Implement your payment logic here
    // Use Stripe API to create a payment intent and then confirm the payment
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: _pay,
          child: const Text('Pay'),
        ),
      ),
    );
  }
}
