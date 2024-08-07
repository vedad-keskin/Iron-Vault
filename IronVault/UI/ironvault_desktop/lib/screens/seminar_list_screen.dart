import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/seminar.dart';
import 'package:ironvault_desktop/providers/seminar_provider.dart';
import 'package:ironvault_desktop/screen_details/seminar_details_screen.dart';
import 'package:provider/provider.dart';

class SeminarListScreen extends StatefulWidget {
  const SeminarListScreen({super.key});

  @override
  State<SeminarListScreen> createState() => _SeminarListScreenState();
}

class _SeminarListScreenState extends State<SeminarListScreen> {
  late SeminarProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<SeminarProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'tema': _temaSearchController.text,
      'predavac' : _predavacSearchController.text
    };
    result = await provider.get(filter: filter);


    setState(() {
    });
  }

  SearchResult<Seminar>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista seminara",
        Container(
          child: Column(
            children: [
              _buildSearch(),
              _buildResultView()
            ],
          ),
        ));
  }

  final TextEditingController _temaSearchController = TextEditingController();
  final TextEditingController _predavacSearchController = TextEditingController();

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
                  controller: _temaSearchController,
                  decoration: InputDecoration(
                    labelText: "Tema",
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
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (value) async {
                    initForm();
                  },
                  controller: _predavacSearchController,
                  decoration: InputDecoration(
                    labelText: "Predavač",
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
                      builder: (context) => SeminarDetailsScreen()));
                },
                child: const Text("Dodaj novi seminar"),
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
                  DataColumn(label: Text("Tema")),
                  DataColumn(label: Text("Predavač")),
                  DataColumn(label: Text("Datum održavanja")),
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
                                                    SeminarDetailsScreen(
                                                      seminar: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.5, // 40% of the available width
                                  child: Text(e.tema ?? ""),
                                 
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.3, // 40% of the available width
                                  child: Text(e.predavac ?? ""),
                                 
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.3, // 40% of the available width
                                  child: Text(DateFormat('dd MMM yyyy').format(e.datum!)),
                                 
                                )),
                               
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
