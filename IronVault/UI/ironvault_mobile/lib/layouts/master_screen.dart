import 'package:flutter/material.dart';
import 'package:ironvault_mobile/main.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/screens/cart_screen.dart';
import 'package:ironvault_mobile/screens/korisnik_list_screen.dart';
import 'package:ironvault_mobile/screens/suplement_list_screen.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, {super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
   CartProvider? _cartProvider;

  @override
  Widget build(BuildContext context) {
   _cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Nazad"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("U korpi ${_cartProvider?.cart.items.length}"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              title: Text("Suplementi"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SuplementListScreen()));
              },
            ),
            ListTile(
              title: Text("Odjavi se"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
