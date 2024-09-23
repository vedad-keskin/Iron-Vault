import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/main.dart';
import 'package:ironvault_mobile/screens/cart_screen.dart';
import 'package:ironvault_mobile/screens/faq_list_screen.dart';
import 'package:ironvault_mobile/screens/korisnik_list_screen.dart';
import 'package:ironvault_mobile/screens/nutricionist_list_screen.dart';
import 'package:ironvault_mobile/screens/suplement_list_screen.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/screens/trener_list_screen.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
  // Set the default value of `index` to 0 (or any other value you prefer)
  const MasterScreen(this.title, {super.key, required this.index, required this.child, required this.id}); // Add id as a required argument

  final String title;
  final int index; // Changed to int and made optional
  final Widget child;
  final int id; // Add this

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  CartProvider? _cartProvider;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedIndex with the provided index
    _selectedIndex = widget.index;
  }




  Widget build(BuildContext context) {
    _cartProvider = context.watch<CartProvider>();

return Scaffold(
  appBar: AppBar(
    title: Text(widget.title),
    automaticallyImplyLeading: false, // Izbacivanje back buttona
  ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(255, 35, 98, 207), // Set the background color to blue
        selectedItemColor: Colors.white, // Color for the selected item
        unselectedItemColor: Colors.white70, // Color for unselected items
        type: BottomNavigationBarType.fixed, // Ensure the background color applies
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_rounded),
            label: 'Suplementi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Korpa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Treneri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Nutricionisti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help ),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Odjava',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add your navigation logic here
    switch (index) {
      case 0:
        // Navigate to Profil screen (replace with actual screen)
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => KorisnikListScreen(widget.id)));
        break;
      case 1:
        // Navigate to Suplementi screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuplementListScreen(widget.id)));
        break;
      case 2:
        // Navigate to Korpa screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CartScreen(widget.id)));
        break;
      case 3:
        // Navigate to Treneri screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TrenerListScreen(widget.id))); // Replace with actual screen
        break;
      case 4:
        // Navigate to Nutricionisti screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NutricionistListScreen(widget.id))); // Replace with actual screen
        break;
      case 5:
        //Navigate to Faq screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FaqListScreen(widget.id))); // Replace with actual screen
        break;
      case 6:
        // Logout action
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
        break;
    }
  }
}
