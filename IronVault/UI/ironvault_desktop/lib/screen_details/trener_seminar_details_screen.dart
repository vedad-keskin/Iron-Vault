import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/models/trener_seminar.dart';
import 'package:ironvault_desktop/providers/trener_provider.dart';
import 'package:ironvault_desktop/providers/trener_seminar_provider.dart';
import 'package:ironvault_desktop/screens/trener_list_screen.dart';
import 'package:provider/provider.dart';

class TrenerSeminarDetailsScreen extends StatefulWidget {
  Trener? trener;

  TrenerSeminarDetailsScreen({super.key, this.trener});

  @override
  State<TrenerSeminarDetailsScreen> createState() =>
      _TrenerSeminarDetailsScreenState();
}

class _TrenerSeminarDetailsScreenState
    extends State<TrenerSeminarDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late TrenerSeminarProvider provider;

  bool isLoading = true;

  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
      provider = context.read<TrenerSeminarProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'trenerId' : widget.trener?.trenerId,
      'ime': widget.trener?.ime,
      'prezime': widget.trener?.prezime,
      'email': widget.trener?.email,
      'brojTelefona': widget.trener?.brojTelefona,
      'slika':
          widget.trener?.slika != null ? widget.trener!.slika.toString() : null
    };

    initForm();
  }

  Future initForm() async {

  var filter = {
      'trenerId': _initialValue['trenerId'],
    };
    result = await provider.get(filter: filter);

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


  SearchResult<TrenerSeminar>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Odslušani seminari trenera",
        Column(
          children: [
            _buildHeader(),
            _buildResultView(),

            // isLoading ? Container() : _buildForm(),
            // _saveRow()
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
                        builder: (context) => const TrenerListScreen()),
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
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Center content horizontally
                    children: [
                      Text(
                        "${_initialValue['ime']} ${_initialValue['prezime']}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Trener",
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
              padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
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
        
                                cells: [
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
                                    child: Text(DateFormat('dd MMM yyyy').format(e.seminar!.datum!))
                                   
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
      ),
    );
  }




}





 

