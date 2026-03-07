import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/narudzba.dart';
import 'package:ironvault_desktop/models/narudzba_stavka.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/narudzba_stavka_provider.dart';
import 'package:ironvault_desktop/screens/narudzba_list_screen.dart';
import 'package:provider/provider.dart';

class NarudzbaStavkaDetailsScreen extends StatefulWidget {
  Narudzba? narudzba;

  NarudzbaStavkaDetailsScreen({super.key, this.narudzba});

  @override
  State<NarudzbaStavkaDetailsScreen> createState() =>
      _NarudzbaStavkaDetailsScreenState();
}

class _NarudzbaStavkaDetailsScreenState
    extends State<NarudzbaStavkaDetailsScreen> {
  Map<String, dynamic> _initialValue = {};

  late NarudzbaStavkaProvider provider;



  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<NarudzbaStavkaProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'narudzbaId': widget.narudzba?.narudzbaId,
      'korisnikId': widget.narudzba?.korisnikId,
      'sifra': widget.narudzba?.sifra,
      'korisnik': widget.narudzba?.korisnik,
      'datumVrijemeNarudzbe': widget.narudzba?.datumVrijemeNarudzbe,
      'status': widget.narudzba?.status,
      'otkazano': widget.narudzba?.otkazano
    };

    initForm();
  }

  Future initForm() async {
    var filter = {
      'narudzbaId': _initialValue['narudzbaId'],
    };
    result = await provider.get(filter: filter);

    setState(() {

    });
  }

  final commonDecoration = InputDecoration(
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
  );

  SearchResult<NarudzbaStavka>? result;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Detalji narudžbe",
        Column(
          children: [
            _buildHeader(),
            _buildResultView(),
            result != null ? _buildOverallResultView() : Container()
          ],
        ));
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(150, 30, 150, 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: "Nazad",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const NarudzbaListScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image Container
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[
                      200], // Use a common decoration fill color or define a new one
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.transparent),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    _initialValue['korisnik'].slika == null
                        ? base64Decode(_base64Placeholder)
                        : base64Decode(_initialValue['korisnik'].slika),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                  width: 20), // Space between image and text container
              // Text Container
              SizedBox(
                width: 300, // Set the width of the container
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures column size is based on content
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Center content horizontally
                    children: [
                      Text(
                       "Kupac : ${_initialValue['korisnik'].ime} ${_initialValue['korisnik'].prezime}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        
                         "Sifra narudžbe : ${_initialValue['sifra']}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
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
                    DataColumn(label: Text("Količina")),
                    DataColumn(label: Text("Cijena")),
                  ],
                  rows: result?.result
                          .map((e) {
                            return DataRow(cells: [
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.6, // 40% of the available width
                                child: Text(e.suplement?.naziv ?? ""),
                              )),
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.2, // 40% of the available width
                                child: Text(e.kolicina.toString() ?? ""),
                              )),
                              DataCell(Text(
                                ("${(e.suplement?.cijena ?? 0) * (e.kolicina ?? 0)} KM"),
                              ))
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
      ),
    );
  }

Widget _buildOverallResultView() {
  // Calculate the total price
  double totalPrice = result?.result.fold(0.0, (sum, e) {
    return sum! + (e.suplement?.cijena ?? 0) * (e.kolicina ?? 0);
  }) ?? 0.0;

  return Padding(
    padding: const EdgeInsets.fromLTRB(700, 20, 0, 20), // Adjust padding as needed
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end, // Align content to the start (left)
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            "Ukupna cijena: ${totalPrice.toStringAsFixed(2)} KM", // Format to 2 decimal places
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    ),
  );
}
}
