import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/main.dart';
import 'package:ironvault_mobile/screens/cart_screen.dart';
import 'package:ironvault_mobile/screens/korisnik_list_screen.dart';
import 'package:ironvault_mobile/screens/suplement_list_screen.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
  // Set the default value of `index` to 0 (or any other value you prefer)
  MasterScreen(this.title, {this.index = 0, required this.child, super.key});

  final String title;
  final int index; // Changed to int and made optional
  final Widget child;

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
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromRGBO(0, 113, 185, 1), // Set the background color to blue
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => KorisnikListScreen()));
        break;
      case 1:
        // Navigate to Suplementi screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuplementListScreen()));
        break;
      case 2:
        // Navigate to Korpa screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CartScreen()));
        break;
      case 3:
        // Navigate to Treneri screen (replace with actual screen)
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Placeholder())); // Replace with actual screen
        break;
      case 4:
        // Navigate to Nutricionisti screen (replace with actual screen)
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Placeholder())); // Replace with actual screen
        break;
      case 5:
        // Logout action
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
        break;
    }
  }
}
