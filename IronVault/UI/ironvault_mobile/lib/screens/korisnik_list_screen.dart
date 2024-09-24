import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/providers/korisnik_provider.dart';
import 'package:ironvault_mobile/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class KorisnikListScreen extends StatefulWidget {
  static const String routeName = "/korisnik";
  final int id;

  const KorisnikListScreen(this.id, {super.key});

  @override
  State<KorisnikListScreen> createState() => _KorisnikListScreenState();
}

class _KorisnikListScreenState extends State<KorisnikListScreen> {
  KorisnikProvider? _korisnikProvider;
  bool _isLoading = true;
  Korisnik? korisnik;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    loadData();
  }

  Future<void> loadData() async {
    korisnik = await _korisnikProvider?.getbyid(widget.id);
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

Widget _buildProfilePage() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image with border and shadow
          Container(
            width: 100, // Adjust width and height as needed
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background color
              shape: BoxShape.circle, // Circle shape
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 6, // Shadow blur radius
                  spreadRadius: 2, // Shadow spread radius
                  offset: const Offset(0, 3), // Shadow offset
                ),
              ],
            ),
            child: ClipOval(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent, // Keep the background transparent for the CircleAvatar
                backgroundImage: korisnik?.slika != null
                    ? MemoryImage(base64Decode(korisnik!.slika!)) // Display the image if available
                    : null,
                child: korisnik?.slika == null
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 16), // Space between image and text
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                const SizedBox(height: 16),
                Text(
                  '${korisnik?.ime} ${korisnik?.prezime}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Username
                Text(
                  '@${korisnik?.korisnickoIme}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}



  

