import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/faq.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/tracker.dart';
import 'package:ironvault_mobile/providers/faq_provider.dart';
import 'package:ironvault_mobile/providers/tracker_provider.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import 'no_data_found.dart';

class TrackerScreen extends StatefulWidget {
  static const String routeName = "/tracker";
  final int id;

  const TrackerScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  TrackerProvider? _trackerProvider;
  SearchResult<Tracker>? data;
  bool _isLoading = true;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();
    TextEditingController _suplementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _trackerProvider = context.read<TrackerProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _trackerProvider?.GetAllTracker();
    setState(() {
      data = tmpData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Tracker",
      index: 8,
      id: widget.id,
      child: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildDateTimePickerOd(),
                  _buildDateTimePickerDo(),
                  // _buildDropdown(),
                  (data == null || data!.result.isEmpty)
                      ? Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: Scaffold(
                            body: noDataFound("Trackeri nisu pronađeni"),
                          ),
                        )
                      : _buildTable(),
                  _buildCounterView(),
                ],
              ),
            ),
    );
  }



Widget _buildDropdown() {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: FormBuilderDropdown<String>(
            name: 'suplementId',
            initialValue: _suplementController.text.isNotEmpty
                ? _suplementController.text
                : null,
            decoration: InputDecoration(
              labelText: 'Suplement',
              prefixIcon: Icon(Icons.filter_list),
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
            items: [
              DropdownMenuItem(
                value: 'Sup1',
                child: Text('Sup1'),
              ),
              DropdownMenuItem(
                value: 'Sup2',
                child: Text('Sup2'),
              ),

            ],
            onChanged: (value) {
              // Update the controller whenever a new value is selected
              _suplementController.text = value ?? '';
            },
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: IconButton(
          icon: _isLoading
              ? CircularProgressIndicator()
              : Icon(Icons.arrow_forward_ios_outlined),
          onPressed: () async {
            if (_suplementController.text.isNotEmpty) {
              setState(() {
                _isLoading = true; // Set loading to true while searching
              });
              var tmpData = await _trackerProvider
                  ?.get(filter: {'suplementId': _suplementController.text});
              setState(() {
                data = tmpData;
                _isLoading = false; // Set loading to false after data is loaded
              });
            }
          },
        ),
      ),
    ],
  );
}
















  Widget _buildDateTimePickerOd() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: FormBuilderDateTimePicker(
              name: 'datumOd',
              controller: _dateController,
              initialValue: _dateController.text.isNotEmpty
                  ? DateFormat('d MMM yyyy').parse(_dateController.text)
                  : null,
              inputType: InputType.both,
              format: DateFormat('d MMM yyyy'),
              decoration: InputDecoration(
                labelText: "Datum Od",
                prefixIcon: Icon(Icons.calendar_today),
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
              onChanged: (value) {
                // Update the text controller whenever the date is selected
                _dateController.text =
                    value != null ? DateFormat('d MMM yyyy').format(value) : '';
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: IconButton(
            icon: _isLoading
                ? CircularProgressIndicator()
                : Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              if (_dateController.text.isNotEmpty) {
                setState(() {
                  _isLoading = true; // Set loading to true while searching
                });
                var tmpData = await _trackerProvider
                    ?.GetAllTracker(filter: {'datumOd': _dateController.text});
                setState(() {
                  data = tmpData;
                  _isLoading =
                      false; // Set loading to false after data is loaded
                });
              }
            },
          ),
        ),
      ],
    );
  }


    Widget _buildDateTimePickerDo() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: FormBuilderDateTimePicker(
              name: 'datumDo',
              controller: _dateController2,
              initialValue: _dateController2.text.isNotEmpty
                  ? DateFormat('d MMM yyyy').parse(_dateController2.text)
                  : null,
              inputType: InputType.both,
              format: DateFormat('d MMM yyyy'),
              decoration: InputDecoration(
                labelText: "Datum Do",
                prefixIcon: Icon(Icons.calendar_today),
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
              onChanged: (value) {
                // Update the text controller whenever the date is selected
                _dateController2.text =
                    value != null ? DateFormat('d MMM yyyy').format(value) : '';
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: IconButton(
            icon: _isLoading
                ? CircularProgressIndicator()
                : Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              if (_dateController.text.isNotEmpty) {
                setState(() {
                  _isLoading = true; // Set loading to true while searching
                });
                var tmpData = await _trackerProvider
                    ?.GetAllTracker(filter: {'datumDo': _dateController2.text});
                setState(() {
                  data = tmpData;
                  _isLoading =
                      false; // Set loading to false after data is loaded
                });
              }
            },
          ),
        ),
      ],
    );
  }

  // Function to build the table for Korisnik Clanarina data
  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Korisnik')),
          DataColumn(label: Text('Cijena')),
          DataColumn(label: Text('Prisustva')),
        ],
        rows: data!.result.map((tracker) {
          return DataRow(cells: [
            DataCell(
                Text('${tracker.korisnik?.ime} ${tracker.korisnik?.prezime}')),
            DataCell(Text("${tracker.ukupnoKupljeno} KM")),
            DataCell(Text(tracker.ukupnoPrisutava.toString())),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildCounterView() {
    int brojacCijena = 0;
    int brojacPrisustva = 0;

    for (var tracker in data!.result) {
      // Assuming items is a List or Iterable

      brojacCijena += tracker.ukupnoKupljeno!;
      brojacPrisustva += tracker.ukupnoPrisutava!;
    }

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(0, 20, 0, 20), // Adjust padding as needed
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align content to the start (left)
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
              "Ukupno cijena $brojacCijena KM, ukupno prisustava $brojacPrisustva.", // Format to 2 decimal places
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
