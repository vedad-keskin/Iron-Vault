import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/grad.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/grad_provider.dart';
import 'package:ironvault_desktop/screens/grad_details_screen.dart';
import 'package:provider/provider.dart';

class GradListScreen extends StatefulWidget {
  const GradListScreen({super.key});

  @override
  State<GradListScreen> createState() => _GradListScreenState();
}

class _GradListScreenState extends State<GradListScreen> {
  late GradProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<GradProvider>();

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

  SearchResult<Grad>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Gradovi",
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
                      builder: (context) => GradDetailsScreen()));
                },
                child: const Text("Dodaj novi grad"),
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
                                                    GradDetailsScreen(
                                                      grad: e,
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
