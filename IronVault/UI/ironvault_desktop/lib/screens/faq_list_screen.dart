import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/faq.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/faq_provider.dart';
import 'package:ironvault_desktop/screen_details/faq_details_screen.dart';
import 'package:ironvault_desktop/screen_details/kategorija_details_screen.dart';
import 'package:provider/provider.dart';

class FaqListScreen extends StatefulWidget {
  const FaqListScreen({super.key});

  @override
  State<FaqListScreen> createState() => _FaqListScreenState();
}

class _FaqListScreenState extends State<FaqListScreen> {
  late FaqProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    provider = context.read<FaqProvider>();

    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    var filter = {
      'pitanjeodgovor': _ftsEditingController.text,
    };
    result = await provider.get(filter: filter);


    setState(() {
    });
  }

  SearchResult<Faq>? result;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Lista FAQs",
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
                    labelText: "Pretraga",
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
                      builder: (context) => FaqDetailsScreen()));
                },
                child: const Text("Dodaj novi FAQ"),
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
                  DataColumn(label: Text("Pitanje")),
                  DataColumn(label: Text("Odgovor")),
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
                                                    FaqDetailsScreen(
                                                      faq: e,
                                                    )))
                                      }
                                  },
                              cells: [
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.3, // 40% of the available width
                                  child: Text(e.pitanje ?? ""),
                                 
                                )),
                                DataCell(Container(
                                  width: constraints.maxWidth *
                                      0.6, // 40% of the available width
                                  child: Text(e.odgovor ?? ""),
                                 
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
