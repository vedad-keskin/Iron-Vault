import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/screens/suplement_details_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SuplementListScreen extends StatefulWidget {
  const SuplementListScreen({super.key});

  @override
  State<SuplementListScreen> createState() => _SuplementListScreenState();
}

class _SuplementListScreenState extends State<SuplementListScreen> {
  late SuplementProvider provider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.read<SuplementProvider>();
    setState(() {
});
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

    setState(() {
      isLoading = false;
    });
  }

  SearchResult<Suplement>? result = null;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista suplemenata",
        Container(
          child: Column(
            children: [
              isLoading ? Container() : _buildSearch(),
              _buildResultView()
            ],
          ),
        ));
  }

  TextEditingController _ftsEditingController = TextEditingController();
  TextEditingController _dobavljacController = TextEditingController();
  TextEditingController _kategorijaController = TextEditingController();

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
                    var filter = {
                      'fts': _ftsEditingController.text,
                      'dobavljac': _dobavljacController.text,
                      'kategorija': _kategorijaController.text
                    };
                    result = await provider.get(filter: filter);

                    setState(() {});
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
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    var filter = {
                      'fts': _ftsEditingController.text,
                      'dobavljac': _dobavljacController.text,
                      'kategorija': _kategorijaController.text
                    };
                    result = await provider.get(filter: filter);

                    setState(() {});
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
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    var filter = {
                      'fts': _ftsEditingController.text,
                      'dobavljac': _dobavljacController.text,
                      'kategorija': _kategorijaController.text
                    };
                    result = await provider.get(filter: filter);

                    setState(() {});
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
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SuplementDetailsScreen()));
                },
                child: Text("Dodaj novi suplement"),
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
                columnSpacing: 12,
                dataRowMaxHeight: 80, // Set the height of the rows
                columns: [
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
                                      ? Container(
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
                                      : Text(""),
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
