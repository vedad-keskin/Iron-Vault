
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/kategorija.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/kategorija_provider.dart';
import 'package:ironvault_desktop/screens/kategorija_list_screen.dart';
import 'package:provider/provider.dart';

class KategorijaDetailsScreen extends StatefulWidget {
  Kategorija? kategorija;

  KategorijaDetailsScreen({super.key, this.kategorija});

  @override
  State<KategorijaDetailsScreen> createState() => _KategorijaDetailsScreenState();
}

class _KategorijaDetailsScreenState extends State<KategorijaDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KategorijaProvider kategorijaProvider;


  SearchResult<Kategorija>? kategorijeResult;

  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    kategorijaProvider = context.read<KategorijaProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'naziv': widget.kategorija?.naziv,
    };

    initForm();
  }

  Future initForm() async {
    kategorijeResult = await kategorijaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Podaci o kategoriji",
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
        padding: const EdgeInsets.fromLTRB(150, 180, 150, 15),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Nazad",
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const KategorijaListScreen()));
            },
          ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Naziv"),
                    name: 'naziv',
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
                      builder: (context) => const KategorijaListScreen()));
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


              try {
                if (widget.kategorija == null) {
                  await kategorijaProvider.insert(request);
                } else {
                  await kategorijaProvider.update(
                      widget.kategorija!.kategorijaId!, request);
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const KategorijaListScreen()));
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
