import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/korisnik_uloga.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/seminar.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/models/trener_seminar.dart';
import 'package:ironvault_desktop/models/uloga.dart';
import 'package:ironvault_desktop/providers/korisnik_provider.dart';
import 'package:ironvault_desktop/providers/korisnik_uloga_provider.dart';
import 'package:ironvault_desktop/providers/seminar_provider.dart';
import 'package:ironvault_desktop/providers/trener_seminar_provider.dart';
import 'package:ironvault_desktop/providers/uloga_provider.dart';
import 'package:ironvault_desktop/screen_details/korisnik_details_screen.dart';
import 'package:ironvault_desktop/screen_details/trener_details_screen.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
import 'package:ironvault_desktop/screens/trener_list_screen.dart';
import 'package:ironvault_desktop/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class KorisnikUlogaDetailsScreen extends StatefulWidget {
  Korisnik? korisnik;

  KorisnikUlogaDetailsScreen({super.key, this.korisnik});

  @override
  State<KorisnikUlogaDetailsScreen> createState() =>
      _KorisnikUlogaDetailsScreenState();
}

class _KorisnikUlogaDetailsScreenState
    extends State<KorisnikUlogaDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisnikUlogaProvider provider;
  late UlogaProvider ulogaProvider;
  bool isLoading = true;

  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<KorisnikUlogaProvider>();
    ulogaProvider = context.read<UlogaProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'korisnikId' : widget.korisnik?.korisnikId,
      'ime': widget.korisnik?.ime,
      'prezime': widget.korisnik?.prezime,
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'email': widget.korisnik?.email,
      'brojTelefona': widget.korisnik?.brojTelefona,
      'gradId': widget.korisnik?.gradId.toString(),
      'spolId': widget.korisnik?.spolId.toString(),
      'visina': widget.korisnik?.visina.toString(),
      'tezina': widget.korisnik?.tezina.toString(),
      'slika': widget.korisnik?.slika != null
          ? widget.korisnik!.slika.toString()
          : null
    };

    initForm();
  }

  Future initForm() async {
    var filter = {
      'korisnikId': _initialValue['korisnikId'],
    };
    result = await provider.get(filter: filter);
    searchResult = await ulogaProvider.get();

    setState(() {
      isLoading = false;
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

  SearchResult<KorisnikUloga>? result;
  SearchResult<Uloga>? searchResult;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Uloge korisnika",
        Column(
          children: [
            isLoading ? Container() : _buildHeader(),
            _buildResultView(),
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
                        builder: (context) => const KorisnikListScreen()),
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
                    _initialValue['slika'] == null
                        ? base64Decode(_base64Placeholder)
                        : base64Decode(_initialValue['slika']),
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
                        "${_initialValue['ime']} ${_initialValue['prezime']}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${_initialValue['korisnickoIme']}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => {_showChoiceDialog(context)},
                child: const Text('Dodaj novu ulogu'),
              )
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
                    DataColumn(label: Text("Uloga")),
                    DataColumn(label: Text("Opis")),
                    DataColumn(label: Text("Datum")),
                  ],
                  rows: result?.result
                          .map((e) {
                            return DataRow(cells: [
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.2, // 40% of the available width
                                child: Text(e.uloga?.naziv ?? ""),
                              )),
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.6, // 40% of the available width
                                child: Text(e.uloga?.opis ?? ""),
                              )),
                              DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(DateFormat('dd MMM yyyy')
                                      .format(e.datumIzmjene!)))),
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

  void _showChoiceDialog(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Odaberite ulogu'),
          content: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'ulogaId',
                        decoration:
                            commonDecoration.copyWith(labelText: "Uloga"),
                        items: searchResult?.result
                                .map((item) => DropdownMenuItem(
                                    value: item.ulogaId.toString(),
                                    child: Text(item.naziv ?? "")))
                                .toList() ??
                            [],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Ovo polje je obavezno.',
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 20), // Adds space between dropdown and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Odustani")),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          // Handle form submission

                          debugPrint(_formKey.currentState?.value.toString());
                          var request = Map.from(_formKey.currentState!.value);

                          request['korisnikId'] = _initialValue['korisnikId'];

                          if (result!.result
                              .where((element) =>
                                  element.ulogaId.toString() ==
                                  request['ulogaId'])
                              .isNotEmpty) {
                            ErrorDialog(
                                context, "Korisnik već ima dodatu ulogu");
                          } else {
                            await provider.insert(request);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    KorisnikUlogaDetailsScreen(
                                  korisnik: widget.korisnik,
                                ),
                              ),
                            );
                          }

                          // Navigate to the SuplementDetailsScreen with the retrieved Suplement
                        }
                      },
                      child: const Text('Dodaj'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
