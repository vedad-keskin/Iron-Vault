import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/narudzba.dart';
import 'package:ironvault_desktop/models/recenzija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/narudzba_provider.dart';
import 'package:ironvault_desktop/providers/recenzija_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/screen_details/narudzba_stavka_details_screen.dart';
import 'package:provider/provider.dart';

class NarudzbaListScreen extends StatefulWidget {
  const NarudzbaListScreen({super.key});

  @override
  State<NarudzbaListScreen> createState() => _NarudzbaListScreenState();
}

class _NarudzbaListScreenState extends State<NarudzbaListScreen> {
  late NarudzbaProvider provider;

    bool isLoading = true;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<NarudzbaProvider>();


    super.initState();
    initForm();
  }

  Future initForm() async {

    var filter = {
      'imePrezime': _korisnikController.text,
    };

    result = await provider.get(filter: filter);

  setState(() {
      
    });
  }

  SearchResult<Narudzba>? result;



  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista narudžbi",
      Container(
        child: Column(
          children: [ _buildSearch(),
           _buildResultView()],
        ),
      ),
    );
  }

      final TextEditingController _korisnikController = TextEditingController();

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
                  controller: _korisnikController,
                  decoration: InputDecoration(
                    labelText: "Korisnik",
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
                  DataColumn(label: Text("Šifra naružbe")),
                  DataColumn(label: Text("Korisnik")),
                  DataColumn(label: Text("Datum i vrijeme narudžbe")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Otkazano")),
                  
                ],
                rows: result?.result
                        .map((e) {
                          return DataRow(
                              onSelectChanged: (selected) => {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NarudzbaStavkaDetailsScreen(
                                                      narudzba: e,
                                                    )))
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text("SIF-000-00${e.narudzbaId}"),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(
                                      "${e.korisnik?.ime} ${e.korisnik?.prezime}"),
                                )),
                                                       DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(DateFormat('dd MMM yyyy hh:mm:ss').format(e.datumVrijemeNarudzbe!)),
                                 
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.status == true ? "U procesu" : "Završeno"),
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.1, // 40% of the available width
                                  child: Text(e.otkazano == true ? "Otkazana narudžba" : "Bez otkazivanja"),
                                )),
                              ]
                              
                              );
                              
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
