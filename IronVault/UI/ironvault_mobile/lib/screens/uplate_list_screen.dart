import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/korisnik_clanarina.dart';
import 'package:ironvault_mobile/models/korisnik_nutricionist.dart';
import 'package:ironvault_mobile/models/korisnik_trener.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/providers/korisnik_clanarina_provider.dart';
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

  SearchResult<KorisnikClanarina>? _korisnikClanarina;
  SearchResult<KorisnikTrener>? _korisnikTrener;
  SearchResult<KorisnikNutricionist>? _korisnikNutricionist;
  bool _isLoading = true; // Loading flag

  // Track selected button
  int _selectedButton = 1;

  @override
  void initState() {
    super.initState();
    _korisnikClanarinaProvider = context.read<KorisnikClanarinaProvider>();
    _korisnikTrenerProvider = context.read<KorisnikTrenerProvider>();
    _korisnikNutricionistProvider = context.read<KorisnikNutricionistProvider>();
    loadData();
  }

  Future loadData() async {
    var filter = {
      'korisnikId': widget.id,
    };
    _korisnikClanarina = await _korisnikClanarinaProvider?.get(filter: filter);
    _korisnikTrener = await _korisnikTrenerProvider?.get(filter: filter);
    _korisnikNutricionist = await _korisnikNutricionistProvider?.get(filter: filter);
    setState(() {
      _isLoading = false; // Set loading to false when data is loaded
    });
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
        return _buildPlaceholder("Data for Button 4"); // Replace with appropriate data
      default:
        return Container(); // Default empty container
    }
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
    if (_korisnikNutricionist == null || _korisnikNutricionist!.result.isEmpty) {
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
            DataCell(Text('${nutricionist.nutricionist!.ime} ${nutricionist.nutricionist!.prezime}')),
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
