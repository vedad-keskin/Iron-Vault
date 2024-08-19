import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/prisustvo.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/prisustvo_provider.dart';
import 'package:provider/provider.dart';

class PrisustvoListScreen extends StatefulWidget {
  const PrisustvoListScreen({super.key});

  @override
  State<PrisustvoListScreen> createState() => _PrisustvoListScreenState();
}

class _PrisustvoListScreenState extends State<PrisustvoListScreen> {
  late PrisustvoProvider provider;
  SearchResult<Prisustvo>? result;

  @override
  void initState() {
    super.initState();
    provider = context.read<PrisustvoProvider>();
    initForm();
  }

  Future initForm() async {
    var filter = {'korisnikPrisutan': "true"};
    result = await provider.get(filter: filter);
    setState(() {});
  }

  void _refreshData() async {
    var filter = {'korisnikPrisutan': "true"};
    result = await provider.get(filter: filter);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Korisnici u teretani",
      Container(
        child: Column(
          children: [
            _buildResultView(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          padding: const EdgeInsets.all(50),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: result?.result.length ?? 0,
          itemBuilder: (context, index) {
            final e = result!.result[index];
            return CardItem(
              e: e,
              onRemove: () {
                _showConfirmationDialog(context, e);
              },
            );
          },
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Prisustvo e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potvrda'),
          content: const Text('Da li je korisnik napustio teretanu ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ne'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Da'),
              onPressed: () async {
                e.datumVrijemeIzlaska = DateTime.now();

                try {
                  await provider.update(e.prisustvoId!, e);
                  // Update the UI without navigating away
                  setState(() {
                    result?.result.remove(e);
                  });
                  Navigator.of(context).pop(); // Dismiss the dialog
                } on Exception catch (ex) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Greška",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        ex.toString().replaceFirst('Exception: ', ''),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Prisustvo e;
  final VoidCallback onRemove;

  const CardItem({
    super.key,
    required this.e,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.lightGreen[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                e.korisnik?.slika != null
                    ? SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            base64Decode(e.korisnik!.slika!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 160,
                        child: Center(child: Text("No Image")),
                      ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${e.korisnik?.ime} ${e.korisnik?.prezime}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Ulazak : ${DateFormat('hh:mm:ss').format(e.datumVrijemeUlaska!)}",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: const Icon(Icons.cancel_sharp, color: Colors.redAccent),
            onPressed: onRemove,
          ),
        ),
      ],
    );
  }
}
