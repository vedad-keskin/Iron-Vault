import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/screens/suplement_details_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SuplementListScreen extends StatefulWidget {
  const SuplementListScreen({super.key});

  @override
  State<SuplementListScreen> createState() => _SuplementListScreenState();
}

class _SuplementListScreenState extends State<SuplementListScreen> {
  late SuplementProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<SuplementProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'fts': _ftsEditingController.text,
      'dobavljac': _dobavljacController.text,
      'kategorija': _kategorijaController.text
    };
    result = await provider.get(filter: filter);

    setState(() {});
  }

  SearchResult<Suplement>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista suplemenata",
        Container(
          child: Column(
            children: [_buildSearch(), _buildResultView()],
          ),
        ));
  }

  final TextEditingController _ftsEditingController = TextEditingController();
  final TextEditingController _dobavljacController = TextEditingController();
  final TextEditingController _kategorijaController = TextEditingController();

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
                  controller: _ftsEditingController,
                  decoration: InputDecoration(
                    labelText: "Naziv",
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
                  controller: _kategorijaController,
                  decoration: InputDecoration(
                    labelText: "Kategorija",
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
                  controller: _dobavljacController,
                  decoration: InputDecoration(
                    labelText: "Dobavljač",
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SuplementDetailsScreen()));
                },
                child: const Text("Dodaj novi suplement"),
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
                  DataColumn(label: Text("Naziv")),
                  DataColumn(label: Text("Cijena")),
                  DataColumn(label: Text("Gramaža")),
                  DataColumn(label: Text("Kategorija")),
                  DataColumn(label: Text("Dobavljač")),
                  DataColumn(label: Text("Prosjek")),
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
                                                    SuplementDetailsScreen(
                                                      suplement: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.4, // 40% of the available width
                                  child: Text(e.naziv ?? ""),
                                )),
                                DataCell(Text(e.cijena != null
                                    ? '${e.cijena!.toInt()} KM'
                                    : '')),
                                DataCell(Text(e.gramaza != null
                                    ? '${e.gramaza!.toInt()} g'
                                    : '')),
                                DataCell(Text(e.kategorija?.naziv ?? "")),
                                DataCell(Text(e.dobavljac?.naziv ?? "")),
                                DataCell(Text(e.prosjecnaOcjena == null
                                    ? "0"
                                    : e.prosjecnaOcjena.toString())),
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
