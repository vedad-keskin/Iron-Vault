import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/providers/trener_provider.dart';
import 'package:ironvault_desktop/screen_details/trener_details_screen.dart';
import 'package:ironvault_desktop/screen_details/trener_seminar_details_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class TrenerListScreen extends StatefulWidget {
  const TrenerListScreen({super.key});

  @override
  State<TrenerListScreen> createState() => _TrenerListScreenState();
}

class _TrenerListScreenState extends State<TrenerListScreen> {
  late TrenerProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<TrenerProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'imePrezime': _imePrezimeEditingController.text,
    };
    result = await provider.get(filter: filter);

    setState(() {});
  }

  SearchResult<Trener>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista trenera",
        Container(
          child: Column(
            children: [_buildSearch(), _buildResultView()],
          ),
        ));
  }

  final TextEditingController _imePrezimeEditingController =
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
                      builder: (context) => TrenerDetailsScreen()));
                },
                child: const Text("Dodaj novog trenera"),
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
                  DataColumn(label: Text("Ime i prezime")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Broj telefona")),
                  DataColumn(label: Text("Slika")),
                  DataColumn(label: Text("")),
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
                                                    TrenerDetailsScreen(
                                                      trener: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.3, // 40% of the available width
                                  child: Text("${e.ime} ${e.prezime}"),
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
                                DataCell(
                                  Container(
                                    width: constraints.maxWidth *
                                        0.1, // 10% of the available width
                                    child: ElevatedButton(
                                      onPressed: () {

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrenerSeminarDetailsScreen(
                                                      trener: e,
                                                    )));
                                                    
                                      },
                                      child: Text('Seminari'),
                                    ),
                                  ),
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
