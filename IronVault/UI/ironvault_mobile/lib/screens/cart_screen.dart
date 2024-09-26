import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/cart.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/order_provider.dart';
import 'package:ironvault_mobile/screens/stripe_screen.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  final int id; // Add this

  const CartScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _orderProvider = context.read<OrderProvider>();
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _cartProvider.cart.items) {
      totalPrice += item.suplement.cijena! * item.count;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Korpa",
      index: 3,
      id: widget.id, // Set the desired index here
      child: Column(
        children: [
          Expanded(child: _buildSuplementCardList()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _buildTotalPriceLabel(),
          ),
          _buildBuyButton(),
        ],
      ),
    );
  }

  Widget _buildSuplementCardList() {
    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          return _buildSuplementCard(_cartProvider.cart.items[index]);
        },
      ),
    );
  }

  Widget _buildSuplementCard(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Set border color and width
      ),
      child: Stack(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: item.suplement.slika == null
                ? const Placeholder()
                : imageFromString(item.suplement.slika!),
            title: Text(
              item.suplement.naziv ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("${item.suplement.cijena} KM"),
            trailing: Text(
              item.count.toString(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                setState(() {
                  _cartProvider.removeFromCart(item.suplement);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

Widget _buildTotalPriceLabel() {
  double totalPrice = _calculateTotalPrice();
  return Padding(
    padding: const EdgeInsets.only(right: 10.0), // Add right padding
    child: Align(
      alignment: Alignment.centerRight, // Align to the right
      child: Text(
        "Ukupno za uplatiti ${totalPrice.toStringAsFixed(2)} KM",
        textAlign: TextAlign.end, // Ensure text is aligned to the right
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.grey, // Set text color to gray
        ),
      ),
    ),
  );
}

Widget _buildBuyButton() {
  return SizedBox(
    width: double.infinity,
    child: TextButton(
      onPressed: () {
        // Check if the cart is empty
        if (_cartProvider.cart.items.isEmpty) {
          // Show a styled red Snackbar if the cart is empty
          final snackBar = SnackBar(
            content: const Text(
              "Korpa je prazna! Dodajte proizvode prije kupovine.",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2), // Duration before the SnackBar disappears
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red, // Set background color to red
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return; // Prevent navigation
        }

        List<Map> items = [];
        _cartProvider.cart.items.forEach((item) {
          items.add({
            "suplementId": item.suplement.suplementId,
            "kolicina": item.count,
          });
        });

        // Calculate total price
        double totalPrice = _calculateTotalPrice();

        // Navigate to StripeScreen and pass the order items and total price
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StripeScreen(
              items: items,
              totalPrice: totalPrice, // Pass the total price
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: const Text(
        "Kupi",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

}
