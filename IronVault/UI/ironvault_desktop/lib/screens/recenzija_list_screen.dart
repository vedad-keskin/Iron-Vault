import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/recenzija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/recenzija_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:provider/provider.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider provider;
  late SuplementProvider suplementProvider;
    bool isLoading = true;

  String? selectedSuplementId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    provider = context.read<RecenzijaProvider>();
    suplementProvider = context.read<SuplementProvider>();

    super.initState();
    initForm();
  }

  Future initForm() async {
    var filter = {
      'suplementId': selectedSuplementId,
    };
    result = await provider.get(filter: filter);
    suplementResult = await suplementProvider.get();
  setState(() {
      isLoading = false;
    });
  }

  SearchResult<Recenzija>? result;
  SearchResult<Suplement>? suplementResult;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista recenzija",
      Container(
        child: Column(
          children: [isLoading ? Container() : _buildSearch(), _buildResultView()],
        ),
      ),
    );
  }

Widget _buildSearch() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(150, 15, 150, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedSuplementId,
                onChanged: (newValue) async {
                  setState(() {
                    selectedSuplementId = newValue;
                  });
                  await initForm();
                },
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
                items: suplementResult?.result.map((suplement) {
                  return DropdownMenuItem<String>(
                    value: suplement.suplementId.toString(),
                    child: Text(suplement.naziv ?? ""),
                  );
                }).toList() ?? [],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // Space between dropdown and additional row
        if (selectedSuplementId != null) 
          _buildSupplementDetails(),
      ],
    ),
  );
}

Widget _buildSupplementDetails() {
  final selectedSuplement = suplementResult?.result.firstWhere(
    (suplement) => suplement.suplementId.toString() == selectedSuplementId,
    orElse: () => Suplement(), // Provide a default value if not found
  );

  double averageRating = selectedSuplement?.prosjecnaOcjena ?? 0.0;

  return Center(
    child: SizedBox(
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures column size is based on content
            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
            children: [
              Text(
                selectedSuplement?.naziv ?? 'N/A',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "${selectedSuplement?.prosjecnaOcjena ?? '0'}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final rating = index + 1;
                  if (rating <= averageRating.floor()) {
                    // Full star
                    return const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    );
                  } else if (rating - 0.5 <= averageRating && rating - 1 < averageRating) {
                    // Half star
                    return const Icon(
                      Icons.star_half,
                      color: Colors.yellow,
                    );
                  } else {
                    // Empty star
                    return const Icon(
                      Icons.star_border,
                      color: Colors.grey,
                    );
                  }
                }),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
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
                                      // zbog izgleda, ljepse je kad je clickable 
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
