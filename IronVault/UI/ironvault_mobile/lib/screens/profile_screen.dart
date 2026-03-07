import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/korisnik_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/screens/loading_screen.dart';
import 'package:ironvault_mobile/screens/no_data_found.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/korisnik";
  final int id;

  const ProfileScreen(this.id, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  KorisnikProvider? _korisnikProvider;
  SuplementProvider? _recommenderProvider;
  CartProvider? _cartProvider;
  bool _isLoading = true;
  Korisnik? korisnik;
  List<Suplement>? data;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _recommenderProvider = context.read<SuplementProvider>();
    _cartProvider = context.read<CartProvider>();
    loadData();
  }

  Future<void> loadData() async {
    korisnik = await _korisnikProvider?.getbyid(widget.id);
    data =  await _recommenderProvider?.Recommend(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Profil",
      index: 0,
      id: widget.id,
      child: _isLoading ? LoadingScreen() : _buildProfilePage(),
    );
  }

@override
Widget _buildProfilePage() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Details Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image with border and shadow
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: korisnik?.slika != null
                        ? MemoryImage(base64Decode(korisnik!.slika!))
                        : null,
                    child: korisnik?.slika == null
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${korisnik?.ime} ${korisnik?.prezime}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@${korisnik?.korisnickoIme}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Progress Indicator for Level
                    _buildUserLevelProgress(
                        korisnik?.razina, korisnik?.satiUteretani),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Add spacing between sections

          // Additional User Information Section
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timelapse_sharp, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Trenirano: ${korisnik?.vrijemeUteretani != null ? "${korisnik!.vrijemeUteretani}" : "Vrijeme nije evidentirano"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Email: ${korisnik?.email ?? "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Broj telefona: ${korisnik?.brojTelefona ?? "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.height, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Visina: ${korisnik?.visina != null ? "${korisnik!.visina} cm" : "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.fitness_center, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Težina: ${korisnik?.tezina != null ? "${korisnik!.tezina} kg" : "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16), // Add spacing between sections

          // Recommended Supplements Section
          Text(
            "Preporuka za vas",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Display the supplement cards
          ..._buildSuplementCardList(),
        ],
      ),
    ),
  );
}

List<Widget> _buildSuplementCardList() {
  if (data == null || data!.isEmpty) {
    return [noDataFound("Suplementi nisu pronađeni")];
  }

  List<Widget> list = data!
      .map((x) => Container(
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.fromLTRB(2, 8, 8, 8), // Adjusted margin for horizontal alignment
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 6,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Rectangular image on card
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: x.slika == null
                      ? const Icon(Icons.image, size: 50, color: Colors.grey)
                      : imageFromString(x.slika!),
                ),
                const SizedBox(height: 10),
                Text(
                  x.naziv ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                addToCartButton(() {
                  _cartProvider?.addToCart(x);
                  _showAddToCartSnackBar(x.naziv!); // Show SnackBar on add to cart
                }),
              ],
            ),
          ))
      .cast<Widget>()
      .toList();

  // Wrap the list of widgets in a Row
  return [
    SingleChildScrollView( // Add scrolling if necessary
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    )
  ];
}




// Method to create a progress indicator for the user level
  // Method to create a progress indicator for the user level
  Widget _buildUserLevelProgress(int? razina, int? satiUTeretani) {
    if (razina == null || satiUTeretani == null) {
      return const Text('No Level Info', style: TextStyle(color: Colors.grey));
    }

    // Calculate required progress based on level
    int required = razina * 10; // 10 hours per level
    double progress = (satiUTeretani % 10) / 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Level: ${korisnik?.razina!}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
        const SizedBox(height: 4),
        Text('${satiUTeretani} / ${required} h',
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }




Widget addToCartButton(VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Background color
      foregroundColor: Colors.white, // Text and icon color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding
       elevation: 10, // Shadow effect
        shadowColor: Colors.black.withOpacity(0.5),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.shopping_cart,
          size: 20, // Icon size
        ),
        SizedBox(width: 8), // Space between icon and text
        Text(
          'Dodaj u korpu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}


// Function to show the SnackBar
void _showAddToCartSnackBar(String suplement) {
  final snackBar = SnackBar(
    content: Text('$suplement je dodan u korpu!'),
    duration: const Duration(seconds: 1), // Duration before the SnackBar disappears
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}




}
