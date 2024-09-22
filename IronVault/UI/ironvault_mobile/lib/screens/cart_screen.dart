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
    index: 2, // Set the desired index here
    child: Column(
      children: [
        Expanded(child: _buildSuplementCardList()),
        _buildBuyButton()
      ],
    ),
    id: widget.id,
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
  
  ListTile _buildSuplementCard(CartItem item) {

return ListTile(
      leading: item.suplement.slika == null ? Placeholder(): imageFromString(item.suplement.slika!),
      title: Text(item.suplement.naziv ?? ""),
      subtitle: Text(item.suplement.cijena.toString()),
      trailing: Text(item.count.toString()),
    );

  }
  
   Widget _buildBuyButton() {
    return TextButton(onPressed: () {
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

    }, child: Text("Buy"));
  }


 
}
