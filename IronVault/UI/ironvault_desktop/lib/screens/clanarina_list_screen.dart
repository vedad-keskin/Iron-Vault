import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/clanarina.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/clanarina_provider.dart';
import 'package:ironvault_desktop/screens/clanarina_details_screen.dart';
import 'package:provider/provider.dart';

class ClanarinaListScreen extends StatefulWidget {
  const ClanarinaListScreen({super.key});

  @override
  State<ClanarinaListScreen> createState() => _ClanarinaListScreenState();
}

class _ClanarinaListScreenState extends State<ClanarinaListScreen> {
  late ClanarinaProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<ClanarinaProvider>();

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

  SearchResult<Clanarina>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista mjesečnih paketa",
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
                      builder: (context) => ClanarinaDetailsScreen()));
                },
                child: const Text("Dodaj novi paket"),
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
                  DataColumn(label: Text("Opis")),
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
                                                    ClanarinaDetailsScreen(
                                                      clanarina: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(e.naziv ?? ""),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.cijena == null
                                    ? "0 KM "
                                    : "${e.cijena} KM")),
                                ),
                               DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.6, // 40% of the available width
                                  child: Text(e.opis ?? ""),
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
