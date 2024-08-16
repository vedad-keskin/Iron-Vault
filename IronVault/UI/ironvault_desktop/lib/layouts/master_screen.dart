import 'package:flutter/material.dart';
import 'package:ironvault_desktop/main.dart';
import 'package:ironvault_desktop/screens/clanarina_list_screen.dart';
import 'package:ironvault_desktop/screens/dobavljac_list_screen.dart';
import 'package:ironvault_desktop/screens/faq_list_screen.dart';
import 'package:ironvault_desktop/screens/grad_list_screen.dart';
import 'package:ironvault_desktop/screens/kategorija_list_screen.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
import 'package:ironvault_desktop/screens/narudzba_list_screen.dart';
import 'package:ironvault_desktop/screens/nutricionist_list_screen.dart';
import 'package:ironvault_desktop/screens/recenzija_list_screen.dart';
import 'package:ironvault_desktop/screens/seminar_list_screen.dart';
import 'package:ironvault_desktop/screens/suplement_list_screen.dart';
import 'package:ironvault_desktop/screens/trener_list_screen.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
           SizedBox(
            height: 64,
             child: DrawerHeader(
                margin: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
           ),
            ListTile(
              title: const Text("Korisnici"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const KorisnikListScreen()));
              },
            ),
            ListTile(
              title: const Text("Narudžbe"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NarudzbaListScreen()));
              },
            ),
            ListTile(
              title: const Text("Mjesečni paketi"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ClanarinaListScreen()));
              },
            ),
            ListTile(
              title: const Text("Suplementi"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SuplementListScreen()));
              },
            ),
            ListTile(
              title: const Text("Recenzije"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RecenzijaListScreen()));
              },
            ),
            ListTile(
              title: const Text("Proizvođači"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DobavljacListScreen()));
              },
            ),
            ListTile(
              title: const Text("Kategorije"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const KategorijaListScreen()));
              },
            ),
            ListTile(
              title: const Text("Treneri"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TrenerListScreen()));
              },
            ),
            ListTile(
              title: const Text("Nutricionisti"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NutricionistListScreen()));
              },
            ),
              ListTile(
              title: const Text("Seminari"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SeminarListScreen()));
              },
            ),
            ListTile(
              title: const Text("Gradovi"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GradListScreen()));
              },
            ),
            ListTile(
              title: const Text("FAQ"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FaqListScreen()));
              },
            ),
            ListTile(
              title: const Text("Odjavi se"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}