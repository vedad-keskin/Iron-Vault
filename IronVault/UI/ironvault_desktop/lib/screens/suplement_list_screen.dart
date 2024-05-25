
import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';

class SuplementListScreen extends StatelessWidget {
  const SuplementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista suplemenata", Column(
      children: [
        Text("Lista suplemenata placeholder"),
        SizedBox(height: 8,),
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Nazad"))
      ],
    ));
  }
}