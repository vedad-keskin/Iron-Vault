import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/seminar.dart';
import 'package:ironvault_mobile/models/trener.dart';
import 'package:ironvault_mobile/models/trener_seminar.dart';
import 'package:ironvault_mobile/providers/seminar_provider.dart';
import 'package:ironvault_mobile/providers/trener_provider.dart';
import 'package:ironvault_mobile/providers/trener_seminar_provider.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';
import 'no_data_found.dart';

class TrenerListScreen extends StatefulWidget {
  static const String routeName = "/trener";

  const TrenerListScreen({Key? key}) : super(key: key);

  @override
  State<TrenerListScreen> createState() => _TrenerListScreenState();
}

class _TrenerListScreenState extends State<TrenerListScreen> {
  TrenerProvider? _trenerProvider;

  SearchResult<Trener>? data;
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Add a loading flag

  @override
  void initState() {
    super.initState();
    _trenerProvider = context.read<TrenerProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _trenerProvider?.get();
    setState(() {
      data = tmpData;
      _isLoading = false; // Set loading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Treneri",
      index: 3, // Set the desired index here
      child: _isLoading
          ? LoadingScreen() // Show the loading screen while data is being loaded
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildTrenerSearch(), // Always displayed
                  (data?.result == null || data!.result.isEmpty)
                      ? Container(
                          height: MediaQuery.of(context).size.height -
                              300, // Adjust height if needed
                          child: Scaffold(
                            body: noDataFound("Treneri nisu pronađeni"),
                          ),
                        )
                      : Container(
                          height: 530,
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 4 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            scrollDirection: Axis.horizontal,
                            children: _buildTrenerCardList(),
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  Widget _buildTrenerSearch() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                setState(() {
                  _isLoading = true; // Set loading to true while searching
                });
                var tmpData = await _trenerProvider
                    ?.get(filter: {'imePrezime': _searchController.text});
                setState(() {
                  data = tmpData;
                  _isLoading =
                      false; // Set loading to false after data is loaded
                });
              },
              decoration: InputDecoration(
                labelText: "Ime ili prezime",
                prefixIcon: Icon(Icons.search),
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
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              setState(() {
                _isLoading = true; // Set loading to true while searching
              });
              var tmpData = await _trenerProvider
                  ?.get(filter: {'imePrezime': _searchController.text});
              setState(() {
                data = tmpData;
                _isLoading = false; // Set loading to false after data is loaded
              });
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTrenerCardList() {
    if (data?.result == null || data!.result.isEmpty) {
      return [noDataFound("Treneri nisu pronađeni")];
    }

    List<Widget> list = data!.result
        .map((x) => Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(40, 8, 0, 8),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 6,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 300, // Adjust image height
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: x.slika == null
                              ? const Icon(Icons.image,
                                  size: 50, color: Colors.grey)
                              : imageFromString(x.slika!),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${x.ime} ${x.prezime}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Trener",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        addToCartButton(() {
                          // TO DO
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      icon: const Icon(Icons.info,
                          size: 40, color: Color.fromARGB(255, 230, 210, 34)),
                      onPressed: () {
                        // Show more information
                        showMoreInfo(context, x);
                      },
                    ),
                  ),
                ],
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }

  void showMoreInfo(BuildContext context, Trener x) {
    // Učitavanje seminara trenera kada se info box otvori
    final trenerSeminarProvider = context.read<TrenerSeminarProvider>();

    // Variables to handle loading state and fetched data
    SearchResult<TrenerSeminar>? result;
    bool isLoading = true;

    // Fetch the seminars associated with the selected trainer
    Future<void> initForm() async {
      var filter = {
        'trenerId': x.trenerId,
      };
      result = await trenerSeminarProvider.get(filter: filter);

      // Update the state to stop loading once data is fetched
      isLoading = false;
    }

    // Initialize the fetching of data
    initForm().then((_) {
      // After data is fetched, show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  children: [
                    // Trainer's picture in a circle
                    x.slika == null
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.image,
                                size: 30, color: Colors.white),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                MemoryImage(base64Decode(x.slika!)),
                          ),
                    const SizedBox(width: 15),
                    // Trainer's name
                    Expanded(
                      child: Text(
                        "${x.ime} ${x.prezime}",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                content: isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // Show loading indicator while data is being fetched
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.blue),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "${x.email}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Phone number
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.green),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "${x.brojTelefona}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // List of seminars
                          Text(
                            "Seminari:",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          // Displaying seminars or no seminars available
                          result?.result.isNotEmpty ?? false
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: result!.result
                                      .map((seminar) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              "- ${seminar.seminar!.tema}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Text(
                                  "Nema dostupnih seminara.",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                        ],
                      ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Zatvori"),
                  ),
                ],
              );
            },
          );
        },
      );
    });
  }

  Widget addToCartButton(VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Background color
        foregroundColor: Colors.white, // Text and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 50), // Padding
        elevation: 5, // Shadow effect
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_month,
            size: 25, // Icon size
          ),
          SizedBox(width: 8), // Space between icon and text
          Text(
            'Zakažite termin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
