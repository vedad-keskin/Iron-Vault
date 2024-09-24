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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            // Card for Additional User Information
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
          ],
        ),
      ),
    );
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
}
