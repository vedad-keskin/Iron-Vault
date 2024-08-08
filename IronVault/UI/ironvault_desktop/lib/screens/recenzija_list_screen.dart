import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/clanarina.dart';
import 'package:ironvault_desktop/models/recenzija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/clanarina_provider.dart';
import 'package:ironvault_desktop/providers/recenzija_provider.dart';
import 'package:ironvault_desktop/screen_details/clanarina_details_screen.dart';
import 'package:provider/provider.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<RecenzijaProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'suplementId': _suplementIdSearchController.text,
    };
    result = await provider.get(filter: filter);

    setState(() {});
  }

  SearchResult<Recenzija>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista recenzija",
        Container(
          child: Column(
            children: [_buildSearch(), _buildResultView()],
          ),
        ));
  }

  final TextEditingController _suplementIdSearchController =
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
                  controller: _suplementIdSearchController,
                  decoration: InputDecoration(
                    labelText: "Suplement",
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
                  DataColumn(label: Text("Suplement")),
                  DataColumn(label: Text("Korisnik")),
                  DataColumn(label: Text("Ocjena")),
                  DataColumn(label: Text("Opis")),
                ],
                rows: result?.result
                        .map((e) {
                          return DataRow(
                              onSelectChanged: (selected) => {
                                    if (selected == true)
                                      {
                                        // Navigator.of(context).pushReplacement(
                                        // MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         ClanarinaDetailsScreen(
                                        //           clanarina: e,
                                        //         )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(e.suplement?.naziv ?? ""),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(
                                      "${e.korisnik?.ime} ${e.korisnik?.prezime}"),
                                )),
                                DataCell(
                                  Container(
                                    width: constraints.maxWidth * 0.2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < (e.ocjena ?? 0)
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: index < (e.ocjena ?? 0)
                                              ? Colors.yellow
                                              : Colors.grey,
                                        );
                                      }),
                                    ),
                                  ),
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
