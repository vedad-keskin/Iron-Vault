import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/nutricionist.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/providers/nutricionist_provider.dart';
import 'package:ironvault_desktop/providers/trener_provider.dart';
import 'package:ironvault_desktop/screens/nutricionist_list_screen.dart';
import 'package:ironvault_desktop/screens/trener_list_screen.dart';
import 'package:provider/provider.dart';

class NutricionistDetailsScreen extends StatefulWidget {
  Nutricionist? nutricionist;

  NutricionistDetailsScreen({super.key, this.nutricionist});

  @override
  State<NutricionistDetailsScreen> createState() => _TrenerDetailsScreenState();
}

class _TrenerDetailsScreenState extends State<NutricionistDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late NutricionistProvider nutricionistProvider;

  SearchResult<Nutricionist>? nutricionistResult;

  bool isLoading = true;

  File? _image;
  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    nutricionistProvider = context.read<NutricionistProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
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
    nutricionistResult = await nutricionistProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Podaci o nutricionisti",
        Column(
          children: [isLoading ? Container() : _buildForm(), _saveRow()],
        ));
  }

  Widget _buildForm() {
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

    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(150, 90, 150, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: "Nazad",
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const NutricionistListScreen()));
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Ime"),
                    name: 'ime',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Ovo polje je obavezno.',
                      ),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Prezime"),
                    name: 'prezime',
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
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      FormBuilderField(
                        name: "imageId",
                        builder: (field) {
                          return Container(
                            height:
                                67, // Assuming each text field has a height of 48 + 8 padding
                            child: InputDecorator(
                              decoration:
                                  commonDecoration.copyWith(labelText: "Slika"),
                              child: ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text("Odaberite sliku"),
                                trailing: const Icon(Icons.file_upload),
                                onTap: getImage,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        decoration: commonDecoration.copyWith(
                            labelText: "Broj telefona"),
                        name: 'brojTelefona',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Ovo polje je obavezno.',
                          ),
                          FormBuilderValidators.match(r'^\+?[0-9]\d{1,14}$',
                              errorText: 'Telefon nije u ispravnom formatu'),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        decoration:
                            commonDecoration.copyWith(labelText: "Email"),
                        name: 'email',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Ovo polje je obavezno.',
                          ),
                          FormBuilderValidators.email(
                              errorText: 'Email nije u ispravnom formatu'),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: commonDecoration.fillColor,
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
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _saveRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 10, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const NutricionistListScreen()));
                },
                child: const Text("Odustani")),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 150, 0),
              child: ElevatedButton(
                // Ako su polja validirana idi na dialog
                onPressed: () => {
                  if (_formKey.currentState!.saveAndValidate())
                    {_showConfirmationDialog(context)}
                },
                child: const Text('Sačuvaj'),
              ))
        ],
      ),
    );
  }

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      // _base64Image = base64Encode(_image!.readAsBytesSync());
      _initialValue['slika'] = base64Encode(_image!.readAsBytesSync());
    }

    setState(() {});
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potvrda'),
          content: const Text('Da li želite spasiti izmjene'),
          actions: <Widget>[
            TextButton(
              child: const Text('Otkaži'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Potvrdi'),
              onPressed: () async {
                debugPrint(_formKey.currentState?.value.toString());

                var request = Map.from(_formKey.currentState!.value);

                request['slika'] = _initialValue['slika'];

                try {
                  if (widget.nutricionist == null) {
                    await nutricionistProvider.insert(request);
                  } else {
                    await nutricionistProvider.update(
                        widget.nutricionist!.nutricionistId!, request);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const NutricionistListScreen()));
                } on Exception catch (e) {
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
                        e.toString().replaceFirst('Exception: ', ''),
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
