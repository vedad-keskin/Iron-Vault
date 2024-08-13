import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/korisnik_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/screen_details/korisnik_details_screen.dart';
import 'package:ironvault_desktop/screen_details/suplement_details_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class KorisnikListScreen extends StatefulWidget {
  const KorisnikListScreen({super.key});

  @override
  State<KorisnikListScreen> createState() => _KorisnikListScreenState();
}

class _KorisnikListScreenState extends State<KorisnikListScreen> {
  late KorisnikProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<KorisnikProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'imeGTE': _imeController.text,
      'prezimeGTE': _prezimeController.text,
      'korisnickoIme': _korisnickoImeController.text
    };
    result = await provider.get(filter: filter);

    setState(() {});
  }

  SearchResult<Korisnik>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista korisnika",
        Container(
          child: Column(
            children: [_buildSearch(), _buildResultView()],
          ),
        ));
  }

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _korisnickoImeController =
      TextEditingController();

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 15, 150, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    initForm();
                  },
                  controller: _imeController,
                  decoration: InputDecoration(
                    labelText: "Ime",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    initForm();
                  },
                  controller: _prezimeController,
                  decoration: InputDecoration(
                    labelText: "Prezime",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    initForm();
                  },
                  controller: _korisnickoImeController,
                  decoration: InputDecoration(
                    labelText: "Korisničko ime",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => KorisnikDetailsScreen()));
                },
                child: const Text("Dodaj novog korisnika"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return DataTable(
                showCheckboxColumn: false,
                columnSpacing: 12,
                dataRowMaxHeight: 80, // Set the height of the rows
                columns: const [
                  DataColumn(label: Text("Razina")),
                  DataColumn(label: Text("Ime i prezime")),
                  DataColumn(label: Text("Korisničko ime")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Broj telefona")),
                  DataColumn(label: Text("Visina")),
                  DataColumn(label: Text("Težina")),
                  DataColumn(label: Text("Grad")),
                  DataColumn(label: Text("Spol")),
                  DataColumn(label: Text("Slika")),
                ],
                rows: result?.result
                        .map((e) {
                          return DataRow(
                              onSelectChanged: (selected) => {
                                    if (selected == true)
                                      {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    KorisnikDetailsScreen(
                                                      korisnik: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                 DataCell(
  Text(
    e.razina != null ? e.razina.toString() : '1',
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    ),
  ),
),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text("${e.ime} ${e.prezime}"),
                                )),
                            
                 
                                DataCell(Text(e.korisnickoIme ?? "")),
                                DataCell(Text(e.email ?? "")),
                                    DataCell(Text(e.brojTelefona.toString())),
                                                               DataCell(Text(e.visina != null
                                    ? '${e.visina!.toInt()} cm'
                                    : '')),
                                DataCell(Text(e.tezina != null
                                    ? '${e.tezina!.toInt()} kg'
                                    : '')),
                                DataCell(Text(e.grad?.naziv ?? "")),
                                DataCell(Text(e.spol?.naziv ?? "")),
     
                                DataCell(
                                  e.slika != null
                                      ? SizedBox(
                                          width:
                                              100, // Set the width of the image container
                                          height:
                                              300, // Set the height of the image container
                                          child: Image.memory(
                                            base64Decode(e
                                                .slika!), // Decode base64 string
                                            fit: BoxFit
                                                .fitHeight, // Ensures the image scales properly
                                          ),
                                        )
                                      : const Text(""),
                                ),
                              ]);
                        })
                        .toList()
                        .cast<DataRow>() ??
                    [], // Convert Iterable to List
              );
            },
          ),
        ),
      ),
    );
  }
}
