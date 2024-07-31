// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ironvault_mobile/providers/auth_provider.dart';
import 'package:ironvault_mobile/providers/dobavljac_provider.dart';
import 'package:ironvault_mobile/providers/kategorija_provider.dart';
import 'package:ironvault_mobile/providers/logged_suplement_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/screens/suplement_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SuplementProvider>(
          create: (_) => LoggedSuplementProvider()),
      ChangeNotifierProvider<KategorijaProvider>(
          create: (_) => KategorijaProvider()),
      ChangeNotifierProvider<DobavljacProvider>(
          create: (_) => DobavljacProvider()),
    ],
    child: const MyApp(),
  ));
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
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_top.png"),
                      fit: BoxFit.fill)),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
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
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        SuplementProvider provider = new SuplementProvider();

                        print(
                            "credentials: ${_usernameController.text} : ${_passwordController.text}");
                        AuthProvider.username = _usernameController.text;
                        AuthProvider.password = _passwordController.text;
                        try {
                          var data = await provider.get();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SuplementListScreen()));
                          print("pokusano");
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
                        backgroundColor: Color(0xFF08b7f0),
                      ),
                      child: Text("Potvrdi",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
