import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/nutricionist.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/providers/nutricionist_provider.dart';
import 'package:ironvault_desktop/providers/trener_provider.dart';
import 'package:ironvault_desktop/screen_details/nutricionist_details_screen.dart';
import 'package:ironvault_desktop/screen_details/trener_details_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class NutricionistListScreen extends StatefulWidget {
  const NutricionistListScreen({super.key});

  @override
  State<NutricionistListScreen> createState() => _NutricionistListScreenState();
}

class _NutricionistListScreenState extends State<NutricionistListScreen> {
  late NutricionistProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<NutricionistProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'imePrezime': _imePrezimeEditingController.text,
    };
    result = await provider.get(filter: filter);


    setState(() {
    });
  }

  SearchResult<Nutricionist>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista nutricionista",
        Container(
          child: Column(
            children: [
              _buildSearch(),
              _buildResultView()
            ],
          ),
        ));
  }

  final TextEditingController _imePrezimeEditingController = TextEditingController();

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
                  controller: _imePrezimeEditingController,
                  decoration: InputDecoration(
                    labelText: "Ime ili prezime",
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
                      builder: (context) => NutricionistDetailsScreen()));
                },
                child: const Text("Dodaj novog nutricionistu"),
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
                dataRowMaxHeight: 70, // Set the height of the rows
                columns: const [
                  DataColumn(label: Text("Ime")),
                  DataColumn(label: Text("Prezime")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Broj telefona")),
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
                                                    NutricionistDetailsScreen(
                                                      nutricionist: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.ime ?? ""),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.prezime ?? ""),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(e.email ?? ""),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.brojTelefona ?? ""),
                                )),
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
