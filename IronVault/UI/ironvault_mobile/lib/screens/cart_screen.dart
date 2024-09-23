import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/cart.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/order_provider.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  final int id; // Add this

  const CartScreen(this.id,{Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _orderProvider = context.read<OrderProvider>();
  }

@override
Widget build(BuildContext context) {
  return MasterScreen(
    "Korpa",
    index: 2,
    id: widget.id, // Set the desired index here
    child: Column(
      children: [
        Expanded(child: _buildSuplementCardList()),
        _buildBuyButton()
      ],
    ),
  );
}

  Widget _buildSuplementCardList() {
    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          print("rendering element");
          return _buildSuplementCard(_cartProvider.cart.items[index]);
        },
      ),
    );
  }
  
Widget _buildSuplementCard(CartItem item) {
  return Container(
// Add some margin for spacing
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey), // Set border color and width
 // Optional: Rounded corners
    ),
    child: Stack(
      children: [
        // The main content of the card
        ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: item.suplement.slika == null 
              ? const Placeholder() 
              : imageFromString(item.suplement.slika!),
          title: Text(item.suplement.naziv ?? "",
          style: const TextStyle(
              
              fontWeight: FontWeight.bold,
            ),),
          subtitle: Text(item.suplement.cijena.toString()),
          trailing: Text(
            item.count.toString(),
            style: const TextStyle(
              fontSize: 25, // Make the count text bigger
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // The 'X' button in the top-right corner
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () {
              setState(() {
                _cartProvider.removeFromCart(item.suplement); // Remove item from cart
              });
            },
          ),
        ),
      ],
    ),
  );
}


  
Widget _buildBuyButton() {
  return SizedBox(
    width: double.infinity, // Full width button
    child: TextButton(
      onPressed: () {
        List<Map> items = [];
        _cartProvider.cart.items.forEach((item) {
          items.add({
            "suplementId": item.suplement.suplementId,
            "kolicina": item.count
          });
        });

        var order = {
          "items": items
        };

        //_orderProvider.insert(order)
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.green, // Button background color
        foregroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(vertical: 14), // Padding for height
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // No rounded corners, squared
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
