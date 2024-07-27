import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/providers/utils.dart';
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

    provider = context.read<SuplementProvider>();
  }

  SearchResult<Suplement>? result = null;
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

  TextEditingController _ftsEditingController = TextEditingController();
  TextEditingController _dobavljacController = TextEditingController();

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _ftsEditingController,
            decoration: InputDecoration(labelText: "Naziv"),
          )),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: TextField(
            controller: _dobavljacController,
            decoration: InputDecoration(labelText: "Dobavljač"),
          )),
          ElevatedButton(
              onPressed: () async {
                var filter = {
                  'fts': _ftsEditingController.text,
                  'dobavljac': _dobavljacController.text
                };
                result = await provider.get(filter: filter);

                setState(() {});

                //TODO: add call to API
              },
              child: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
          ElevatedButton(
              onPressed: () async {
                //TODO: add call to API
              },
              child: Text("Dodaj"))
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 12,
          dataRowMaxHeight: 80, // Set the height of the rows
          columns: [
            // DataColumn(label: Text("ID"), numeric: true),
            DataColumn(label: Text("Naziv")),
            DataColumn(label: Text("Cijena")),
            DataColumn(label: Text("Gramaža")),
            DataColumn(label: Text("Prosječna ocjena")),
            DataColumn(label: Text("Slika")),
          ],
          rows: result?.result
                  .map((e) => DataRow(cells: [
                        // DataCell(Text(e.suplementId.toString())),
                        DataCell(Text(e.naziv ?? "")),
                        DataCell(Text(formatNumber(e.cijena))),
                        DataCell(Text(e.gramaza.toString())),
                        DataCell(Text(e.prosjecnaOcjena == null ? "0" : e.prosjecnaOcjena.toString() )),
                        DataCell(
                          e.slika != null
                              ? Container(
                                  width:
                                      300, // Set the width of the image container
                                  height:
                                      300, // Set the height of the image container
                                  child: Image.memory(
                                    base64Decode(
                                        e.slika!), // Decode base64 string
                                    fit: BoxFit
                                        .fitHeight, // Ensures the image scales properly
                                  ),
                                )
                              : Text(""),
                        ),
                      ]))
                  .toList()
                  .cast<DataRow>() ??
              [], // Convert Iterable to List
        ),
      ),
    );
  }
}
