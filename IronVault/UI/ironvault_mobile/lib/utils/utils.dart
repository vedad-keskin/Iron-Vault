import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

Image imageFromString(String input) {
  return Image.memory(base64Decode(input));
}














// -----------  new button 




  // Widget _buildButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //        Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                   builder: (context) => MoodTrackerDetailsScreen(widget.id)));
  //     },
  //     child: Text("Dodaj"),
      
  //   );
  // }


// -----------  dtp 


  // Widget _buildDateTimePicker() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
  //           child: FormBuilderDateTimePicker(
  //             name: 'datumVazenja',
  //             controller: _dateController,
  //             initialValue: _dateController.text.isNotEmpty
  //                 ? DateFormat('d MMM yyyy').parse(_dateController.text)
  //                 : null,
  //             inputType: InputType.both,
  //             format: DateFormat('d MMM yyyy'),
  //             decoration: InputDecoration(
  //               labelText: "Datum i vrijeme",
  //               prefixIcon: Icon(Icons.calendar_today),
  //               filled: true,
  //               fillColor: Colors.grey[200],
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 borderSide: BorderSide.none,
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 borderSide: const BorderSide(color: Colors.blue),
  //               ),
  //             ),
  //             onChanged: (value) {
  //               // Update the text controller whenever the date is selected
  //               _dateController.text =
  //                   value != null ? DateFormat('d MMM yyyy').format(value) : '';
  //             },
  //           ),
  //         ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  //         child: IconButton(
  //           icon: _isLoading
  //               ? CircularProgressIndicator()
  //               : Icon(Icons.arrow_forward_ios_outlined),
  //           onPressed: () async {
  //             if (_dateController.text.isNotEmpty) {
  //               setState(() {
  //                 _isLoading = true; // Set loading to true while searching
  //               });
  //               var tmpData = await _fitPasosProvider
  //                   ?.get(filter: {'datumVazenja': _dateController.text});
  //               setState(() {
  //                 data = tmpData;
  //                 _isLoading = false; // Set loading to false after data is loaded
  //               });
  //             }
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }


// --------------- combo search



// Widget _buildDropdown() {
//   return Row(
//     children: [
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
//           child: FormBuilderDropdown<String>(
//             name: 'status',
//             initialValue: _statusController.text.isNotEmpty
//                 ? _statusController.text
//                 : null,
//             decoration: InputDecoration(
//               labelText: 'Status',
//               prefixIcon: Icon(Icons.filter_list),
//               filled: true,
//               fillColor: Colors.grey[200],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(color: Colors.blue),
//               ),
//             ),
//             items: [
//               DropdownMenuItem(
//                 value: 'U toku',
//                 child: Text('U toku'),
//               ),
//               DropdownMenuItem(
//                 value: 'Realizovana',
//                 child: Text('Realizovana'),
//               ),
//                        DropdownMenuItem(
//                 value: 'Istekla',
//                 child: Text('Istekla'),
//               ),
//             ],
//             onChanged: (value) {
//               // Update the controller whenever a new value is selected
//               _statusController.text = value ?? '';
//             },
//           ),
//         ),
//       ),
//       Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         child: IconButton(
//           icon: _isLoading
//               ? CircularProgressIndicator()
//               : Icon(Icons.arrow_forward_ios_outlined),
//           onPressed: () async {
//             if (_statusController.text.isNotEmpty) {
//               setState(() {
//                 _isLoading = true; // Set loading to true while searching
//               });
//               var tmpData = await _toDo4924Provider
//                   ?.get(filter: {'status': _statusController.text});
//               setState(() {
//                 data = tmpData;
//                 _isLoading = false; // Set loading to false after data is loaded
//               });
//             }
//           },
//         ),
//       ),
//     ],
//   );
// }










// -----------  new form 






// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';
// import 'package:ironvault_mobile/layouts/master_screen.dart';
// import 'package:ironvault_mobile/models/korisnik.dart';
// import 'package:ironvault_mobile/models/search_result.dart';
// import 'package:ironvault_mobile/providers/korisnik_provider.dart';
// import 'package:ironvault_mobile/providers/mood_tracker_provider.dart';
// import 'package:ironvault_mobile/screens/frmMoodTracker.dart';

// import 'package:provider/provider.dart';

// class MoodTrackerDetailsScreen extends StatefulWidget {
//   Korisnik? korisnik;

//   final int id;

//   MoodTrackerDetailsScreen(this.id, {super.key});

//   @override
//   State<MoodTrackerDetailsScreen> createState() =>
//       _MoodTrackerDetailsScreenState();
// }

// class _MoodTrackerDetailsScreenState extends State<MoodTrackerDetailsScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   Map<String, dynamic> _initialValue = {};
//   late KorisnikProvider korisnikProvider;
//   late MoodTrackerProvider moodTrackerProvider;

//   SearchResult<Korisnik>? korisnikResult;

//   bool isLoading = true;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     korisnikProvider = context.read<KorisnikProvider>();
//     moodTrackerProvider = context.read<MoodTrackerProvider>();

//     // TODO: implement initState
//     super.initState();

//     initForm();
//   }

//   Future initForm() async {
//     korisnikResult = await korisnikProvider.get();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreen("Mood Tracker",
//         index: 8,
//         id: widget.id,
//         child: 
//         SingleChildScrollView(child: 
//          Column(
//           children: [isLoading ? Container() : _buildForm()],
//         )
//         )
//         );
//   }

// Widget _buildForm() {
//   final commonDecoration = InputDecoration(
//     filled: true,
//     fillColor: Colors.grey[200],
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide.none,
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: const BorderSide(color: Colors.blue),
//     ),
//   );

//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(5.0), // Optional padding
//     child: FormBuilder(
//       key: _formKey,
//       initialValue: _initialValue,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           IconButton(
//             icon: Icon(Icons.arrow_back),
//             tooltip: "Nazad",
//             onPressed: () {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (context) => MoodTrackerScreen(widget.id),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 20),


//          Column(
//   children: [
//     FormBuilderDropdown(
//       name: 'raspolozenje',
//       decoration: commonDecoration.copyWith(labelText: "Raspolozenje"),
//       items: [
//         DropdownMenuItem(
//           value: 'Sretan',
//           child: Text("Sretan"),
//         ),
//         DropdownMenuItem(
//           value: 'Tužan',
//           child: Text("Tužan"),
//         ),
//         DropdownMenuItem(
//           value: 'Uzbuđen',
//           child: Text("Uzbuđen"),
//         ),
        
//           DropdownMenuItem(
//           value: 'Umoran',
//           child: Text("Umoran"),
//         ),
//           DropdownMenuItem(
//           value: 'Pod stresom',
//           child: Text("Pod stresom"),
//         ),
//       ],
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: FormBuilderValidators.compose([
//         FormBuilderValidators.required(
//           errorText: 'Ovo polje je obavezno',
//         ),
//       ]),
//     ),
//   ],
// ),


//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: commonDecoration.copyWith(labelText: "Opis"),
//                   name: 'opis',
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(
//                       errorText: 'Ovo polje je obavezno.',
//                     ),
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FormBuilderDateTimePicker(
//                 name: 'datum',
//                 decoration: const InputDecoration(
//                   labelText: "Datum i vrijeme",
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 inputType: InputType.both,
//                 format: DateFormat('dd/MM/yyyy HH:mm'),
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(
//                     errorText: 'Obavezan datum i vrijeme',
//                   ),
//                 ]),
//                 firstDate: DateTime.now(),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Column(
//             children: [
//               FormBuilderDropdown(
//                 name: 'korisnikId',
//                 decoration: commonDecoration.copyWith(labelText: "Korisnik"),
//                 items: korisnikResult!.result
//                     .map((item) => DropdownMenuItem(
//                           value: item.korisnikId.toString(),
//                           child: Text("${item.ime} ${item.prezime}"),
//                         ))
//                     .toList(),
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(
//                     errorText: 'Ovo polje je obavezno',
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _saveRow(), // Save and Cancel buttons
//         ],
//       ),
//     ),
//   );
// }





//   Widget _saveRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => MoodTrackerScreen(widget.id),
//               ),
//             );
//           },
//           child: const Text("Odustani"),
//         ),
//         SizedBox(width: 10), // Space between buttons
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.saveAndValidate()) {
//               _showConfirmationDialog(context);
//             }
//           },
//           child: const Text('Sačuvaj'),
//         ),
//       ],
//     );
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Potvrda'),
//           content: const Text('Da li želite spasiti izmjene'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Otkaži'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Potvrdi'),
//               onPressed: () async {
//                 debugPrint(_formKey.currentState?.value.toString());

//                 var request = Map.from(_formKey.currentState!.value);

// debugPrint('REQUEST -----------> ${request.toString()}');

//                   if (request['datum'] is DateTime) {
//                         request['datum'] =
//                             (request['datum'] as DateTime)
//                                 .toIso8601String();
//                       }



//                 try {
//                    await moodTrackerProvider.insert(request);

//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) =>
//                           MoodTrackerScreen(widget.id)));
//                 } on Exception catch (e) {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text(
//                         "Greška",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       content: Text(
//                         e.toString().replaceFirst('Exception: ', ''),
//                         style: const TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text(
//                             "OK",
//                             style: TextStyle(
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }












// ------------ > status 


            // Column(
            //   children: [
            //     FormBuilderDropdown(
            //       name: 'aktivan',
            //       decoration: commonDecoration.copyWith(labelText: "Aktivan"),
            //       items: [
            //         DropdownMenuItem(
            //           value: 'aktivan',
            //           child: Text("Aktivan"),
            //         ),
            //         DropdownMenuItem(
            //           value: 'neaktivan',
            //           child: Text("Neaktivan"),
            //         ),
            //       ],
            //       autovalidateMode: AutovalidateMode.onUserInteraction,
            //       validator: FormBuilderValidators.compose([
            //         FormBuilderValidators.required(
            //           errorText: 'Ovo polje je obavezno',
            //         ),
            //       ]),
            //     ),
            //   ],
            // ),




































// -----------  footer text








  // Widget _buildCounterView() {
  //   int brojacSretan = 0;
  //   int brojacTuzan = 0;
  //   int brojacUzbudjen = 0;
  //   int brojacUmoran = 0;
  //   int brojacPodStresom = 0;

  //   for (var mood in data!.result) {
  //     // Assuming items is a List or Iterable
  //     if (mood.raspolozenje == 'Sretan') {
  //       brojacSretan++;
  //     }
  //     if (mood.raspolozenje == 'Tužan') {
  //       brojacTuzan++;
  //     }
  //     if (mood.raspolozenje == 'Uzbuđen') {
  //       brojacUzbudjen++;
  //     }
  //     if (mood.raspolozenje == 'Umoran') {
  //       brojacUmoran++;
  //     }
  //     if (mood.raspolozenje == 'Pod stresom') {
  //       brojacPodStresom++;
  //     }
  //   }

  //   return Padding(
  //     padding:
  //         const EdgeInsets.fromLTRB(0, 20, 0, 20), // Adjust padding as needed
  //     child: Column(
  //       crossAxisAlignment:
  //           CrossAxisAlignment.end, // Align content to the start (left)
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(16.0),
  //           decoration: BoxDecoration(
  //             color: Colors.grey[200], // Background color
  //             borderRadius: BorderRadius.circular(10.0), // Rounded corners
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.1),
  //                 spreadRadius: 1,
  //                 blurRadius: 4,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           child: Text(
  //             "Sretnih ima $brojacSretan, umornih $brojacUmoran, pod stresom $brojacPodStresom, uzbuđenih ${brojacUzbudjen}, tužnih $brojacTuzan . ", // Format to 2 decimal places
  //             style: Theme.of(context).textTheme.titleSmall,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );



