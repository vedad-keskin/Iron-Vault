
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/clanarina.dart';
import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/providers/clanarina_provider.dart';
import 'package:ironvault_desktop/screens/clanarina_list_screen.dart';
import 'package:provider/provider.dart';

class ClanarinaDetailsScreen extends StatefulWidget {
  Clanarina? clanarina;

  ClanarinaDetailsScreen({super.key, this.clanarina});

  @override
  State<ClanarinaDetailsScreen> createState() => _ClanarinaDetailsScreenState();
}

class _ClanarinaDetailsScreenState extends State<ClanarinaDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ClanarinaProvider clanarinaProvider;


  SearchResult<Clanarina>? clanarinaResult;

  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    clanarinaProvider = context.read<ClanarinaProvider>();

    // TODO: implement initState
    super.initState();

    _initialValue = {
      'naziv': widget.clanarina?.naziv,
      'cijena' : widget.clanarina?.cijena.toString(),
      'opis' : widget.clanarina?.opis
    };

    initForm();
  }

  Future initForm() async {
    clanarinaResult = await clanarinaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Podaci o paketu",
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
      padding: const EdgeInsets.fromLTRB(150, 120, 150, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Nazad",
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ClanarinaListScreen()));
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 4, // 80% of the row width
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
                flex: 1, // 20% of the row width
                child: FormBuilderTextField(
                  decoration: commonDecoration.copyWith(labelText: "Cijena"),
                  name: 'cijena',
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
                child: Container(
                  height: 150,
                  child: FormBuilderTextField(
                    decoration: commonDecoration.copyWith(labelText: "Opis"),
                    name: 'opis',
                    maxLines: 5,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
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
                      builder: (context) => const ClanarinaListScreen()));
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
                if (widget.clanarina == null) {
                  await clanarinaProvider.insert(request);
                } else {
                  await clanarinaProvider.update(
                      widget.clanarina!.clanarinaId!, request);
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ClanarinaListScreen()));
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
