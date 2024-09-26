import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/korisnik_clanarina.dart';
import 'package:ironvault_mobile/models/korisnik_nutricionist.dart';
import 'package:ironvault_mobile/models/korisnik_trener.dart';
import 'package:ironvault_mobile/models/recenzija.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/korisnik_clanarina_provider.dart';
import 'package:ironvault_mobile/providers/recenzija_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_mobile/providers/korisnik_nutricionist_provider.dart';
import 'package:ironvault_mobile/providers/korisnik_trener_provider.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import 'no_data_found.dart';

class UplateListScreen extends StatefulWidget {
  static const String routeName = "/uplate";
  final int id;

  const UplateListScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<UplateListScreen> createState() => _UplateListScreenState();
}

class _UplateListScreenState extends State<UplateListScreen> {
  KorisnikClanarinaProvider? _korisnikClanarinaProvider;
  KorisnikTrenerProvider? _korisnikTrenerProvider;
  KorisnikNutricionistProvider? _korisnikNutricionistProvider;
  SuplementProvider? _suplementProvider;
  RecenzijaProvider? _recenzijaProvider;

  SearchResult<KorisnikClanarina>? _korisnikClanarina;
  SearchResult<KorisnikTrener>? _korisnikTrener;
  SearchResult<KorisnikNutricionist>? _korisnikNutricionist;
  SearchResult<Recenzija>? _recenzijeKorisnika;
  List<Suplement>? _kupljeniSuplementi;

  bool _isLoading = true; // Loading flag

  // Track selected button
  int _selectedButton = 1;

  @override
  void initState() {
    super.initState();
    _korisnikClanarinaProvider = context.read<KorisnikClanarinaProvider>();
    _korisnikTrenerProvider = context.read<KorisnikTrenerProvider>();
    _suplementProvider = context.read<SuplementProvider>();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    _korisnikNutricionistProvider =
        context.read<KorisnikNutricionistProvider>();
    loadData();
  }

  Future loadData() async {
    try {
      var filter = {
        'korisnikId': widget.id,
      };
      _korisnikClanarina =
          await _korisnikClanarinaProvider?.get(filter: filter);
      _korisnikTrener = await _korisnikTrenerProvider?.get(filter: filter);
      _korisnikNutricionist =
          await _korisnikNutricionistProvider?.get(filter: filter);
      _kupljeniSuplementi =
          await _suplementProvider?.GetDistinctBought(widget.id);
      _recenzijeKorisnika = await _recenzijaProvider?.get(filter: filter);
    } catch (e) {
      // Handle error here
      print("Error loading data: $e");
      // Optionally, display an error message to the user
    } finally {
      setState(() {
        _isLoading = false; // Ensure loading state is reset
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Uplate",
      index: 1,
      id: widget.id,
      child: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Buttons in a 2x2 grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSizedIconButton(
                        icon: Icons.payment,
                        label: "Uplaćene članarine",
                        buttonNumber: 1,
                      ),
                      _buildSizedIconButton(
                        icon: Icons.star,
                        label: "Recenzije suplemenata",
                        buttonNumber: 4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Space between rows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSizedIconButton(
                        icon: Icons.date_range_outlined,
                        label: "Termini kod trenera",
                        buttonNumber: 2,
                      ),
                      _buildSizedIconButton(
                        icon: Icons.date_range_outlined,
                        label: "Termini kod nutricionista",
                        buttonNumber: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Display data based on the selected button
                  _buildSelectedData(),
                ],
              ),
            ),
    );
  }

// Function to create rectangular button with fixed width and height
  Widget _buildSizedIconButton({
    required IconData icon,
    required String label,
    required int buttonNumber,
    double width = 150, // Set the desired button width here
    double height = 70, // Set the desired button height here
  }) {
    return SizedBox(
      width: width,
      height: height, // Setting fixed height
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            _selectedButton = buttonNumber; // Update selected button
          });
          // You can add additional actions here
          switch (buttonNumber) {
            case 1:
              // Navigate to Članarine screen or perform related action
              break;
            case 2:
              // Navigate to Termini Trener screen or perform related action
              break;
            case 3:
              // Navigate to Termini Nutricionist screen or perform related action
              break;
            case 4:
              // Handle Button 4 action
              break;
          }
        },
        icon: Icon(
          icon,
          color: _selectedButton == buttonNumber ? Colors.blue : Colors.grey,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: _selectedButton == buttonNumber ? Colors.blue : Colors.grey,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: _selectedButton == buttonNumber ? Colors.blue : Colors.grey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  // Widget to display data based on the selected button
  Widget _buildSelectedData() {
    switch (_selectedButton) {
      case 1:
        return _buildKorisnikClanarinaTable();
      case 2:
        return _buildKorisnikTrenerTable();
      case 3:
        return _buildKorisnikNutricionistTable();
      case 4:
        return _buildKupljeniSuplementiTable(); // New case for purchased supplements
      default:
        return Container(); // Default empty container
    }
  }

// Function to build the table for purchased supplements
  // Function to build the table for purchased supplements
  Widget _buildKupljeniSuplementiTable() {
    if (_kupljeniSuplementi == null || _kupljeniSuplementi!.isEmpty) {
      return noDataFound("Korisnik nema kupljenih suplemenata");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 12, // Adjust spacing between columns
        columns: const [
          DataColumn(label: Text('Slika')),
          DataColumn(label: Text('Naziv')),
          DataColumn(
              label: Text('Recenzije')), // Column for the recension button
        ],
        rows: _kupljeniSuplementi!.map((suplement) {
          // Check if the user has already made a recension for this supplement
          bool hasReviewed = _recenzijeKorisnika?.result.any((recenzija) =>
                  recenzija.suplementId == suplement.suplementId &&
                  recenzija.korisnikId == widget.id) ??
              false;

          return DataRow(cells: [
            // Display image in the first column using MemoryImage and base64 decoding
            DataCell(
              suplement.slika != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: MemoryImage(base64Decode(suplement.slika!)),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.image_not_supported, size: 50),
            ),
            // Display supplement name in the second column with increased width
            DataCell(
              Container(
                width: 170,
                child: Text(suplement.naziv!),
              ),
            ),

            // Elevated button for recensions with a star icon and text, with reduced width
            DataCell(
              Container(
                width: 120,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.star, color: Colors.white),
                  label: Text('Ocjeni', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (hasReviewed) {
                      _showAlreadyReviewedDialog(); // Show dialog if already reviewed
                    } else {
                      // Trigger action to show recension details
                      _showRecensionDialog(suplement);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  void _showRecensionDialog(Suplement suplement) {
    // Create a form key to manage the form state
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    int _rating = 1; // Variable to store the star rating

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${suplement.naziv}'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Star rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            // Update rating on star click
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    // Additional information textbox
                    FormBuilderTextField(
                      name: 'opis',
                      decoration: const InputDecoration(
                        labelText: 'Dodatne informacije',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3, // Set to 3 lines for larger input
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Ovo polje je obavezno.',
                        ),
                        FormBuilderValidators.maxLength(250),
                      ]),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.red),

              onPressed: () =>
                  Navigator.of(context).pop(), // Cancel button first
              child: Text('Odustani'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  var request = Map.from(_formKey.currentState!.value);

                  request['ocjena'] = _rating;

                  request['korisnikId'] = widget.id;

                  request['suplementId'] = suplement.suplementId;

                          try {
                  // Attempt to insert the review
                  await _recenzijaProvider?.insert(request);
                  loadData(); // Refresh the data after successful insertion
                  
                  // Close the dialog
                  Navigator.of(context).pop();
                } catch (e) {
                  // Handle the error (e.g., show a message to the user)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Došlo je do greške: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

  
                }
              },
              child: Text('Spremi'),
            ),
          ],
        );
      },
    );
  }

// Function to show a dialog if the user has already reviewed the supplement
  void _showAlreadyReviewedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Greška"),
          content: const Text("Već ste napravili recenziju za ovaj suplement."),
          actions: <Widget>[
            TextButton(
              child: const Text("U redu"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Placeholder widget for data to be implemented
  Widget _buildPlaceholder(String message) {
    return Container(
      height: 100,
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  // Function to build the table for Korisnik Clanarina data
  Widget _buildKorisnikClanarinaTable() {
    if (_korisnikClanarina == null || _korisnikClanarina!.result.isEmpty) {
      return noDataFound("Korisnik nema članarina");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Paket')),
          DataColumn(label: Text('Uplata')),
          DataColumn(label: Text('Istek')),
        ],
        rows: _korisnikClanarina!.result.map((clanarina) {
          return DataRow(cells: [
            DataCell(Text(clanarina.clanarina!.naziv.toString())),
            DataCell(Text(_formatDate(clanarina.datumUplate))),
            DataCell(Text(_formatDate(clanarina.datumIsteka))),
          ]);
        }).toList(),
      ),
    );
  }

  // Function to build the table for Korisnik Trener data
  Widget _buildKorisnikTrenerTable() {
    if (_korisnikTrener == null || _korisnikTrener!.result.isEmpty) {
      return noDataFound("Korisnik nema termina sa trenerom");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Trener')),
          DataColumn(label: Text('Datum')),
          DataColumn(label: Text('Sati')),
        ],
        rows: _korisnikTrener!.result.map((trener) {
          return DataRow(cells: [
            DataCell(Text('${trener.trener!.ime} ${trener.trener!.prezime}')),
            DataCell(Text(_formatDate(trener.datumTermina))),
            DataCell(Text((trener.zakazanoSati.toString()))),
          ]);
        }).toList(),
      ),
    );
  }

  // Function to build the table for Korisnik Nutricionist data
  Widget _buildKorisnikNutricionistTable() {
    if (_korisnikNutricionist == null ||
        _korisnikNutricionist!.result.isEmpty) {
      return noDataFound("Korisnik nema termina sa nutricionistom");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nutricionist')),
          DataColumn(label: Text('Datum')),
          DataColumn(label: Text('Sati')),
        ],
        rows: _korisnikNutricionist!.result.map((nutricionist) {
          return DataRow(cells: [
            DataCell(Text(
                '${nutricionist.nutricionist!.ime} ${nutricionist.nutricionist!.prezime}')),
            DataCell(Text(_formatDate(nutricionist.datumTermina))),
            DataCell(Text((nutricionist.zakazanoSati.toString()))),
          ]);
        }).toList(),
      ),
    );
  }

  // Format DateTime to show only the date
  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
