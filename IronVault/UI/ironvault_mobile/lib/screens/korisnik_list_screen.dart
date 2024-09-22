import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';

class KorisnikListScreen extends StatelessWidget {
  final int id; // Declare id as a final member variable

  const KorisnikListScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Korisnici $id", // Pass the title
      index: 0, // Set the desired index here
      child: Placeholder(), // Replace with actual child widget
      id: id, // Pass the id to MasterScreen
    );
  }

}
