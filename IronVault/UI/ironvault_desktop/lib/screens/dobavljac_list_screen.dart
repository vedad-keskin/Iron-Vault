import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/dobavljac.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/dobavljac_provider.dart';
import 'package:ironvault_desktop/screen_details/dobavljac_details_screen.dart';
import 'package:provider/provider.dart';

class DobavljacListScreen extends StatefulWidget {
  const DobavljacListScreen({super.key});

  @override
  State<DobavljacListScreen> createState() => _DobavljacListScreenState();
}

class _DobavljacListScreenState extends State<DobavljacListScreen> {
  late DobavljacProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<DobavljacProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'naziv': _ftsEditingController.text,
    };
    result = await provider.get(filter: filter);


    setState(() {
    });
  }

  SearchResult<Dobavljac>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista proizvođača",
        Container(
          child: Column(
            children: [
              _buildSearch(),
              _buildResultView()
            ],
          ),
        ));
  }

  final TextEditingController _ftsEditingController = TextEditingController();

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
              
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DobavljacDetailsScreen()));
                },
                child: const Text("Dodaj novog proizvođača"),
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
                  DataColumn(label: Text("Naziv")),
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
                                                    DobavljacDetailsScreen(
                                                      dobavljac: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.4, // 40% of the available width
                                  child: Text(e.naziv ?? ""),
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
