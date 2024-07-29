import 'package:flutter/material.dart';
import 'package:ironvault_desktop/main.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
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
              title: Text("Nazad"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuplementListScreen()));
              },
            ),
              ListTile(
              title: Text("Odjavi se"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              
            )
          ],
        ),
      ),
      body: widget.child ,
    );
  }
}