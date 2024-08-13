import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/grad.dart';
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/spol.dart';
import 'package:ironvault_desktop/providers/grad_provider.dart';
import 'package:ironvault_desktop/providers/korisnik_provider.dart';
import 'package:ironvault_desktop/providers/spol_provider.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
import 'package:provider/provider.dart';

class KorisnikDetailsScreen extends StatefulWidget {
  Korisnik? korisnik;

  KorisnikDetailsScreen({super.key, this.korisnik});

  @override
  State<KorisnikDetailsScreen> createState() => _SuplementDetailsScreenState();
}

class _SuplementDetailsScreenState extends State<KorisnikDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisnikProvider korisnikProvider;
  late GradProvider gradProvider;
  late SpolProvider spolProvider;

  SearchResult<Spol>? spoloviResult;
  SearchResult<Grad>? gradoviResult;
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
    korisnikProvider = context.read<KorisnikProvider>();
    gradProvider = context.read<GradProvider>();
    spolProvider = context.read<SpolProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
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
    gradoviResult = await gradProvider.get();
    spoloviResult = await spolProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Podaci o korisniku",
        Column(
          children: [isLoading ? Container() : _buildForm(), _saveRow()],
        ));
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

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(150, 0, 150, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: "Nazad",
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const KorisnikListScreen()));
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Ime"),
                    name: 'ime',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Prezime"),
                    name: 'prezime',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration:
                        commonDecoration.copyWith(labelText: "Korisničko ime"),
                    name: 'korisnickoIme',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            widget.korisnik == null ? BarZaLozinku() : Container(),
            widget.korisnik == null ? const SizedBox(height: 10) : Container(),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown(
                    name: 'spolId',
                    decoration: commonDecoration.copyWith(labelText: "Spol"),
                    items: spoloviResult?.result
                            .map((item) => DropdownMenuItem(
                                value: item.spolId.toString(),
                                child: Text(item.naziv ?? "")))
                            .toList() ??
                        [],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderDropdown(
                    name: 'gradId',
                    decoration: commonDecoration.copyWith(
                        labelText: "Grad prebivališta"),
                    items: gradoviResult?.result
                            .map((item) => DropdownMenuItem(
                                value: item.gradId.toString(),
                                child: Text(item.naziv ?? "")))
                            .toList() ??
                        [],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FormBuilderField(
                    name: "imageId",
                    builder: (field) {
                      return InputDecorator(
                        decoration:
                            commonDecoration.copyWith(labelText: "Slika"),
                        child: ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text("Odaberite sliku"),
                          trailing: const Icon(Icons.file_upload),
                          onTap: getImage,
                        ),
                      );
                    },
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
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              decoration: commonDecoration.copyWith(
                                  labelText: "Visina"),
                              name: 'visina',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Add some space between the text fields
                          Expanded(
                            child: FormBuilderTextField(
                              decoration: commonDecoration.copyWith(
                                  labelText: "Težina"),
                              name: 'tezina',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        decoration: commonDecoration.copyWith(
                            labelText: "Broj telefona"),
                        name: 'brojTelefona',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.match(r'^\+?[0-9]\d{1,14}$',
                              errorText: 'Telefon nije u ispravnom formatu'),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        decoration:
                            commonDecoration.copyWith(labelText: "Email"),
                        name: 'email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
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
          ],
        ),
      ),
    );
  }

  Widget BarZaLozinku() {
    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            decoration: commonDecoration.copyWith(labelText: "Lozinka"),
            name: 'lozinka',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FormBuilderTextField(
            decoration: commonDecoration.copyWith(labelText: "Potvrda lozinke"),
            name: 'lozinkaPotvrda',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
      ],
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
                      builder: (context) => const KorisnikListScreen()));
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
                  if (widget.korisnik == null) {
                    await korisnikProvider.insert(request);
                  } else {
                    await korisnikProvider.update(
                        widget.korisnik!.korisnikId!, request);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const KorisnikListScreen()));
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
