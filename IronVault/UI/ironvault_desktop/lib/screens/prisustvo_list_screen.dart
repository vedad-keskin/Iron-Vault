import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/prisustvo.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/korisnik_provider.dart';
import 'package:ironvault_desktop/providers/prisustvo_provider.dart';
import 'package:ironvault_desktop/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class PrisustvoListScreen extends StatefulWidget {
  const PrisustvoListScreen({super.key});

  @override
  State<PrisustvoListScreen> createState() => _PrisustvoListScreenState();
}

class _PrisustvoListScreenState extends State<PrisustvoListScreen> {
  late PrisustvoProvider provider;
  SearchResult<Prisustvo>? result;
  SearchResult<Korisnik>? searchResult;
  late KorisnikProvider korisnikProvider;

  @override
  void initState() {
    super.initState();
    provider = context.read<PrisustvoProvider>();
    korisnikProvider = context.read<KorisnikProvider>();

    initForm();
  }

  Future initForm() async {
    var filter = {'korisnikPrisutan': "true"};
    result = await provider.get(filter: filter);
    searchResult = await korisnikProvider.get();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Korisnici u teretani",
      Container(
        child: Column(
          children: [
            _buildAddView(),
            _buildResultView(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddView() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(40, 20, 40, 0), // Adjusted right padding
      child: Row(
        children: [
          // Existing icon and text on the left
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () {
              _showChoiceDialog(context);
            },
          ),
          const SizedBox(width: 10),
          Text(
            'Dodaj korisnika u teretanu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
          const Spacer(), // Pushes the legend container to the right
          // Legend section on the right
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.cancel_sharp,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Izbaciti korisnika nakon što napusti teretanu',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Dodati korisnika nakon što dođe u teretanu',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  void _showChoiceDialog(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Odaberite korisnika'),
          content: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'korisnikId',
                        decoration:
                            commonDecoration.copyWith(labelText: "Korisnik"),
                        items: searchResult?.result
                                .map((item) => DropdownMenuItem(
                                    value: item.korisnikId.toString(),
                                    child: Text("${item.ime} ${item.prezime}")))
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

                          

                          if (result!.result
                              .where((element) =>
                                  element.korisnikId.toString() ==
                                  request['korisnikId'])
                              .isNotEmpty) {
                            ErrorDialog(
                                context, "Korisnik je već u teretani");
                          } else {
                            await provider.insert(request);

                            await initForm();

                             Navigator.pop(context);
                          }

                          
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

  Widget _buildResultView() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          padding: const EdgeInsets.all(50),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: result?.result.length ?? 0,
          itemBuilder: (context, index) {
            final e = result!.result[index];
            return CardItem(
              e: e,
              onRemove: () {
                _showConfirmationDialog(context, e);
              },
            );
          },
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Prisustvo e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potvrda'),
          content: const Text('Da li je korisnik napustio teretanu ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ne'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Da'),
              onPressed: () async {
                e.datumVrijemeIzlaska = DateTime.now();

                try {
                  await provider.update(e.prisustvoId!, e);
                  // Update the UI without navigating away
                  setState(() {
                    result?.result.remove(e);
                  });
                  Navigator.of(context).pop(); // Dismiss the dialog
                } on Exception catch (ex) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Greška",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        ex.toString().replaceFirst('Exception: ', ''),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Prisustvo e;
  final VoidCallback onRemove;

  const CardItem({
    super.key,
    required this.e,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.lightGreen[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                e.korisnik?.slika != null
                    ? SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            base64Decode(e.korisnik!.slika!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 160,
                        child: Center(child: Text("No Image")),
                      ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${e.korisnik?.ime} ${e.korisnik?.prezime}",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Ulazak : ${DateFormat('hh:mm:ss').format(e.datumVrijemeUlaska!)}",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: const Icon(Icons.cancel_sharp, color: Colors.redAccent),
            onPressed: onRemove,
          ),
        ),
      ],
    );
  }
}
