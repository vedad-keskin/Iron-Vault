import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/dobavljac.dart';
import 'package:ironvault_desktop/models/kategorija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/dobavljac_provider.dart';
import 'package:ironvault_desktop/providers/kategorija_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
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
      'dobavljacId': widget.suplement?.dobavljacId.toString(),
      'kategorijaId': widget.suplement?.kategorijaId.toString()
    };

    initForm();
  }

  Future initForm() async {
    kategorijeResult = await kategorijaProvider.get();
    dobavljaciResult = await dobavljacProvider.get();
    print("retreived dobavljaci: ${dobavljaciResult?.result.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Detalji",
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
      borderSide: BorderSide(color: Colors.blue),
    ),
  );

  return FormBuilder(
    key: _formKey,
    initialValue: _initialValue,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: commonDecoration.copyWith(labelText: "Naziv"),
                  name: 'naziv',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  decoration: commonDecoration.copyWith(labelText: "Cijena"),
                  name: 'cijena',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  decoration: commonDecoration.copyWith(labelText: "Gramaža"),
                  name: 'gramaza',
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
                  decoration: commonDecoration.copyWith(labelText: "Kategorija"),
                  items: kategorijeResult?.result
                          .map((item) => DropdownMenuItem(
                              value: item.kategorijaId.toString(),
                              child: Text(item.naziv ?? "")))
                          .toList() ??
                      [],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FormBuilderDropdown(
                  name: 'dobavljacId',
                  decoration: commonDecoration.copyWith(labelText: "Dobavljač"),
                  items: dobavljaciResult?.result
                          .map((item) => DropdownMenuItem(
                              value: item.dobavljacId.toString(),
                              child: Text(item.naziv ?? "")))
                          .toList() ??
                      [],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: commonDecoration.copyWith(labelText: "Opis"),
                  name: 'opis',
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
                      decoration: commonDecoration.copyWith(labelText: "Slika"),
                      child: ListTile(
                        leading: Icon(Icons.image),
                        title: Text("Odaberite sliku"),
                        trailing: Icon(Icons.file_upload),
                        onTap: getImage,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
          ElevatedButton(
              onPressed: () {
                _formKey.currentState?.saveAndValidate();
                debugPrint(_formKey.currentState?.value.toString());

                var request = Map.from(_formKey.currentState!.value);

                request['slika'] = _base64Image;

                if (widget.suplement == null) {
                  suplementProvider.insert(request);
                } else {
                  suplementProvider.update(
                      widget.suplement!.suplementId!, request);
                }
              },
              child: Text("Sačuvaj"))
        ],
      ),
    );
  }
}

File? _image;
String? _base64Image;

void getImage() async {
  var result = await FilePicker.platform.pickFiles(type: FileType.image);

  if (result != null && result.files.single.path != null) {
    _image = File(result.files.single.path!);
    _base64Image = base64Encode(_image!.readAsBytesSync());
  }
}
