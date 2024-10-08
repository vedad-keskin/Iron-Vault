// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ironvault_desktop/providers/biznis_report_provider.dart';
import 'package:ironvault_desktop/providers/korisnik_clanarina_provider.dart';
import 'package:ironvault_desktop/providers/prisustvo_provider.dart';
import 'package:ironvault_desktop/providers/auth_provider.dart';
import 'package:ironvault_desktop/providers/clanarina_provider.dart';
import 'package:ironvault_desktop/providers/dobavljac_provider.dart';
import 'package:ironvault_desktop/providers/faq_provider.dart';
import 'package:ironvault_desktop/providers/grad_provider.dart';
import 'package:ironvault_desktop/providers/kategorija_provider.dart';
import 'package:ironvault_desktop/providers/korisnik_provider.dart';
import 'package:ironvault_desktop/providers/korisnik_uloga_provider.dart';
import 'package:ironvault_desktop/providers/narudzba_provider.dart';
import 'package:ironvault_desktop/providers/narudzba_stavka_provider.dart';
import 'package:ironvault_desktop/providers/nutricionist_provider.dart';
import 'package:ironvault_desktop/providers/nutricionist_seminar_provider.dart';
import 'package:ironvault_desktop/providers/recenzija_provider.dart';
import 'package:ironvault_desktop/providers/seminar_provider.dart';
import 'package:ironvault_desktop/providers/spol_provider.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';
import 'package:ironvault_desktop/providers/trener_provider.dart';
import 'package:ironvault_desktop/providers/trener_seminar_provider.dart';
import 'package:ironvault_desktop/providers/uloga_provider.dart';
import 'package:ironvault_desktop/screens/biznis_report_screen.dart';
import 'package:ironvault_desktop/screens/korisnik_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SuplementProvider>(create: (_) => SuplementProvider()),
      ChangeNotifierProvider<KategorijaProvider>(create: (_) => KategorijaProvider()),
      ChangeNotifierProvider<DobavljacProvider>(create: (_) => DobavljacProvider()),
      ChangeNotifierProvider<GradProvider>(create: (_) => GradProvider()),
      ChangeNotifierProvider<FaqProvider>(create: (_) => FaqProvider()),
      ChangeNotifierProvider<ClanarinaProvider>(create: (_) => ClanarinaProvider()),
      ChangeNotifierProvider<SeminarProvider>(create: (_) => SeminarProvider()),
      ChangeNotifierProvider<TrenerProvider>(create: (_) => TrenerProvider()),
      ChangeNotifierProvider<NutricionistProvider>(create: (_) => NutricionistProvider()),
      ChangeNotifierProvider<RecenzijaProvider>(create: (_) => RecenzijaProvider()),
      ChangeNotifierProvider<TrenerSeminarProvider>(create: (_) => TrenerSeminarProvider()),
      ChangeNotifierProvider<NutricionistSeminarProvider>(create: (_) => NutricionistSeminarProvider()),
      ChangeNotifierProvider<KorisnikProvider>(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider<SpolProvider>(create: (_) => SpolProvider()),
      ChangeNotifierProvider<UlogaProvider>(create: (_) => UlogaProvider()),
      ChangeNotifierProvider<KorisnikUlogaProvider>(create: (_) => KorisnikUlogaProvider()),
      ChangeNotifierProvider<NarudzbaProvider>(create: (_) => NarudzbaProvider()),
      ChangeNotifierProvider<NarudzbaStavkaProvider>(create: (_) => NarudzbaStavkaProvider()),
      ChangeNotifierProvider<PrisustvoProvider>(create: (_) => PrisustvoProvider()),
      ChangeNotifierProvider<KorisnikClanarinaProvider>(create: (_) => KorisnikClanarinaProvider()),
      ChangeNotifierProvider<BiznisReportProvider>(create: (_) => BiznisReportProvider()),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Vault',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
            child: Card(
              color: Color.fromARGB(255, 236, 236, 236),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/tinylogo4.png",
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Korisničko ime",
                        prefixIcon: Icon(Icons.account_circle_sharp),
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
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Lozinka",
                        prefixIcon: Icon(Icons.password),
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        KorisnikProvider provider = KorisnikProvider();

                        print(
                            "credentials: ${_usernameController.text} : ${_passwordController.text}");
                        AuthProvider.username = _usernameController.text;
                        AuthProvider.password = _passwordController.text;
                        try {
                          var data = await provider.get();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BiznisReportScreen()));
                        } on Exception catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Greška",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                e.toString().replaceFirst('Exception: ', ''),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
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
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                        minimumSize: Size(double.infinity, 30),
                      ),
                      child: Text("Prijavi se"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




