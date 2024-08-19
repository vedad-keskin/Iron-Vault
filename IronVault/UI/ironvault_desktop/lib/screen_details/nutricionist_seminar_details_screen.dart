import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/nutricionist.dart';
import 'package:ironvault_desktop/models/nutricionist_seminar.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/seminar.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/models/trener_seminar.dart';
import 'package:ironvault_desktop/providers/nutricionist_seminar_provider.dart';
import 'package:ironvault_desktop/providers/seminar_provider.dart';
import 'package:ironvault_desktop/providers/trener_seminar_provider.dart';
import 'package:ironvault_desktop/screen_details/trener_details_screen.dart';
import 'package:ironvault_desktop/screens/nutricionist_list_screen.dart';
import 'package:ironvault_desktop/screens/trener_list_screen.dart';
import 'package:ironvault_desktop/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class NutricionistSeminarDetailsScreen extends StatefulWidget {
  Nutricionist? nutricionist;

  NutricionistSeminarDetailsScreen({super.key, this.nutricionist});

  @override
  State<NutricionistSeminarDetailsScreen> createState() =>
      _NutricionistSeminarDetailsScreenState();
}

class _NutricionistSeminarDetailsScreenState
    extends State<NutricionistSeminarDetailsScreen> {

  Map<String, dynamic> _initialValue = {};
  late NutricionistSeminarProvider provider;
  late SeminarProvider seminarProvider;
  bool isLoading = true;

  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<NutricionistSeminarProvider>();
    seminarProvider = context.read<SeminarProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'nutricionistId': widget.nutricionist?.nutricionistId,
      'ime': widget.nutricionist?.ime,
      'prezime': widget.nutricionist?.prezime,
      'email': widget.nutricionist?.email,
      'brojTelefona': widget.nutricionist?.brojTelefona,
      'slika': widget.nutricionist?.slika != null
          ? widget.nutricionist!.slika.toString()
          : null
    };

    initForm();
  }

  Future initForm() async {
    var filter = {
      'nutricionistId': _initialValue['nutricionistId'],
    };
    result = await provider.get(filter: filter);
    searchResult = await seminarProvider.get();

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

  SearchResult<NutricionistSeminar>? result;
  SearchResult<Seminar>? searchResult;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Odslušani seminari nutricioniste",
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
                        builder: (context) => const NutricionistListScreen()),
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
                        "Nutricionist",
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
                child: const Text('Dodaj novi seminar'),
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
                    DataColumn(label: Text("Tema")),
                    DataColumn(label: Text("Predavač")),
                    DataColumn(label: Text("Datum održavanja")),
                  ],
                  rows: result?.result
                          .map((e) {
                            return DataRow(cells: [
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.6, // 40% of the available width
                                child: Text(e.seminar?.tema ?? ""),
                              )),
                              DataCell(Container(
                                width: constraints.maxWidth *
                                    0.2, // 40% of the available width
                                child: Text(e.seminar?.predavac ?? ""),
                              )),
                              DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.2, // 40% of the available width
                                  child: Text(DateFormat('dd MMM yyyy')
                                      .format(e.seminar!.datum!)))),
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
          title: const Text('Odaberite seminar'),
          content: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'seminarId',
                        decoration:
                            commonDecoration.copyWith(labelText: "Seminar"),
                        items: searchResult?.result
                                .map((item) => DropdownMenuItem(
                                    value: item.seminarId.toString(),
                                    child: Text(item.tema ?? "")))
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

                          request['nutricionistId'] =
                              _initialValue['nutricionistId'];

                          if (result!.result
                              .where((element) =>
                                  element.seminarId.toString() ==
                                  request['seminarId'])
                              .isNotEmpty) {
                            ErrorDialog(context,
                                "Nutricionist je odslušao odabrani seminar");
                           } else {
                            await provider.insert(request);

                            await initForm();
                             Navigator.pop(context);
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
