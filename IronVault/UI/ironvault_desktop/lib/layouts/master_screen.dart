import 'package:flutter/material.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
import 'package:ironvault_desktop/screens/suplement_details_screen.dart';
import 'package:ironvault_desktop/screens/suplement_list_screen.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, {super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Back"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
             ListTile(
              title: Text("Detalji"),
              onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuplementDetailsScreen()));
              },
            ),
            ListTile(
              title: Text("Korisnici"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => KorisnikListScreen()));
              },
            ),
            ListTile(
              title: Text("Suplementi"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuplementListScreen()));
              },
            )
          ],
        ),
      ),
      body: widget.child ,
    );
  }
}