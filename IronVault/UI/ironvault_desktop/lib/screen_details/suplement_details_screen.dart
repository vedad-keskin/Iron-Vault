import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/dobavljac.dart';
import 'package:ironvault_desktop/models/kategorija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/dobavljac_provider.dart';
import 'package:ironvault_desktop/providers/kategorija_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/screens/suplement_list_screen.dart';
import 'package:provider/provider.dart';

class SuplementDetailsScreen extends StatefulWidget {
  Suplement? suplement;

  SuplementDetailsScreen({super.key, this.suplement});

  @override
  State<SuplementDetailsScreen> createState() => _SuplementDetailsScreenState();
}

class _SuplementDetailsScreenState extends State<SuplementDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late SuplementProvider suplementProvider;
  late KategorijaProvider kategorijaProvider;
  late DobavljacProvider dobavljacProvider;

  SearchResult<Kategorija>? kategorijeResult;
  SearchResult<Dobavljac>? dobavljaciResult;
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
    suplementProvider = context.read<SuplementProvider>();
    kategorijaProvider = context.read<KategorijaProvider>();
    dobavljacProvider = context.read<DobavljacProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'naziv': widget.suplement?.naziv,
      'cijena': widget.suplement?.cijena.toString(),
      'gramaza': widget.suplement?.gramaza.toString(),
      'opis': widget.suplement?.opis,
      'stateMachine': widget.suplement?.stateMachine,
      'dobavljacId': widget.suplement?.dobavljacId.toString(),
      'kategorijaId': widget.suplement?.kategorijaId.toString(),
      'slika': widget.suplement?.slika != null
          ? widget.suplement!.slika.toString()
          : null
    };

    initForm();
  }

  Future initForm() async {
    kategorijeResult = await kategorijaProvider.get();
    dobavljaciResult = await dobavljacProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Podaci o suplementu",
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
        padding: const EdgeInsets.fromLTRB(150, 0, 150, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: "Nazad",
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SuplementListScreen()));
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Naziv"),
                    name: 'naziv',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Cijena"),
                    name: 'cijena',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric()
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Gramaža"),
                    name: 'gramaza',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric()
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown(
                    name: 'kategorijaId',
                    decoration:
                        commonDecoration.copyWith(labelText: "Kategorija"),
                    items: kategorijeResult?.result
                            .map((item) => DropdownMenuItem(
                                value: item.kategorijaId.toString(),
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
                    name: 'dobavljacId',
                    decoration:
                        commonDecoration.copyWith(labelText: "Proizvođač"),
                    items: dobavljaciResult?.result
                            .map((item) => DropdownMenuItem(
                                value: item.dobavljacId.toString(),
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
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    child: FormBuilderTextField(
                      decoration: commonDecoration.copyWith(labelText: "Opis"),
                      name: 'opis',
                      maxLines: 7,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
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
            Row(
              children: [
                Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: _getColorForState(_initialValue[
                        'stateMachine']), // Method to determine color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Stanje"),
                    name: 'stateMachine',
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.suplement != null
                        ? Colors.grey[200]
                        : Colors.grey, // Change color based on enabled state
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    side: BorderSide.none, // No border
                    elevation: 2, // Shadow
                  ),
                  onPressed: widget.suplement != null
                      ? () {
                          _showChoiceDialog(context);
                        }
                      : null, // Disable button if widget.suplement is null
                  child: const Text(
                    'Promijeni stanje',
                    style: TextStyle(
                      color: Colors.black, // Adjust text color as needed
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForState(String? state) {
    switch (state) {
      case 'draft':
        return Colors.yellow;
      case 'active':
        return Colors.green;
      case 'hidden':
        return Colors.orange;
      default:
        return Colors.grey;
    }
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
                      builder: (context) => const SuplementListScreen()));
                },
                child: const Text("Odustani")),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 150, 0),
              child: ElevatedButton(
                // Ako su polja validirana idi na dialog

                onPressed: () => {
                  if (_formKey.currentState!.saveAndValidate())
                    {
                      if (_initialValue['stateMachine'] == 'active' ||
                          _initialValue['stateMachine'] == 'hidden')
                        {_showErrorDialog(context)}
                      else
                        {_showConfirmationDialog(context)}
                    }
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
                  if (widget.suplement == null) {
                    await suplementProvider.insert(request);
                  } else {
                    await suplementProvider.update(
                        widget.suplement!.suplementId!, request);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SuplementListScreen()));
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

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Greška',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Ako želite urediti suplement on mora biti u draft stanju',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

    void _showErrorDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Greška',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Promjena u odabrano stanje nije dozvoljena',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Odaberite stanje'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow, // Text color
                        foregroundColor: Colors.black),
                     onPressed: () async {
                      // Activate

                      if (widget.suplement != null && _initialValue['stateMachine'] != "draft") {
                        await suplementProvider.Edit(
                            widget.suplement!.suplementId!);

                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SuplementListScreen()));
                      } else {
                        _showErrorDialog2(context);
                      }


                    },
                    child: const Text('Draft'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green, // Text color
                        foregroundColor: Colors.black),
                    onPressed: () async {
                      // Activate

                      if (widget.suplement != null && _initialValue['stateMachine'] != "active" && _initialValue['stateMachine'] != "hidden") {
                        await suplementProvider.Activate(
                            widget.suplement!.suplementId!);

                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SuplementListScreen()));
                      } else {
                        _showErrorDialog2(context);
                      }
                          
                    },
                    child: const Text('Active'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.orange, // Text color
                        foregroundColor: Colors.black),
                           onPressed: () async {
                      // Activate

                      if (widget.suplement != null && _initialValue['stateMachine'] != "activate" && _initialValue['stateMachine'] != "hidden") {
                        await suplementProvider.Hide(
                            widget.suplement!.suplementId!);

                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SuplementListScreen()));
                      } else {
                        _showErrorDialog2(context);
                      }


                    },
                    child: const Text('Hidden'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
