import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ironvault_desktop/layouts/master_screen.dart';
import 'package:ironvault_desktop/models/biznis_report.dart';
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/biznis_report_provider.dart';
import 'package:provider/provider.dart';

class BiznisReportScreen extends StatefulWidget {
  const BiznisReportScreen({super.key});

  @override
  State<BiznisReportScreen> createState() => _BiznisReportScreenState();
}

class _BiznisReportScreenState extends State<BiznisReportScreen> {
  late BiznisReportProvider provider;
  BizniReport? result;

  final _base64Placeholder =
      "iVBORw0KGgoAAAANSUhEUgAAAbUAAADnCAYAAACZm8iVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANhSURBVHhe7dVBEQAwEAOh+hcbC1cfOzzQwNt2AFAgNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAGRIDYAMqQGQITUAMqQGQIbUAMiQGgAZUgMgQ2oAZEgNgAypAZAhNQAypAZAhtQAyJAaABlSAyBDagBkSA2ADKkBkCE1ADKkBkCG1ADIkBoAGVIDIENqAETsPkrQ65jNFb26AAAAAElFTkSuQmCC";

  @override
  void initState() {
    provider = context.read<BiznisReportProvider>();

    super.initState();
    initForm();
  }

  Future initForm() async {
    result = await provider.GetBiznisReport();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Biznis Report",
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildResultView(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cards per row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.4, // Adjust this to change card height
        ),
        itemCount: 6, // 6 cards in total
        itemBuilder: (context, index) {
          return Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCardContent(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(int index) {
    switch (index) {
      case 0:
        return _buildSupplementCard(
          title: "Najviše realizovanih prodaja",
          title2: "Broj prodaja : ${result?.najprodavanijiSuplementCount}",
          supplement: result?.najprodavanijiSuplement,
        );
      case 1:
        return _buildUserCard(
          title: "Najaktivniji korisnik",
          title2: "Razina ${result?.najaktivnijiKorisnik?.razina}",
          korisnik: result?.najaktivnijiKorisnik,
        );
      case 2:
        return _buildSupplementCard(
          title: "Najbolje ocjenjeni suplement",
          title2: "Prosječna ocjena : ${result?.najboljaOcjenaSuplement?.prosjecnaOcjena}",
          supplement: result?.najboljaOcjenaSuplement,
        );
      case 3:
        return _buildIncomeCard(
          title: "Mjesečna zarada od članarina",
          amount: result?.zaradaMjesecaNaClanarinama ?? 'N/A',
          icon: Icons.card_membership,
          color: Colors.blue,
        );
      case 4:
        return _buildIncomeCard(
          title: "Ukupna zarada ovog mjeseca",
          amount: result?.ukupnaZaradaMjeseca ?? '0',
          icon: Icons.attach_money,
          color: Colors.green,
        );
      case 5:
        return _buildIncomeCard(
          title: "Mjesečna zarada od kupovina",
          amount: result?.zaradaMjesecaNaKupovinama ?? '0',
          icon: Icons.shopping_cart,
          color: Colors.orange,
        );
      default:
        return Container();
    }
  }

  Widget _buildIncomeCard({
    required String title,
    required dynamic amount,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 32.0, color: color),
            SizedBox(width: 8.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Text(
          "$amount KM",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        LinearProgressIndicator(
          value: _getProgressValue(amount),
          color: color,
          backgroundColor: color.withOpacity(0.2),
        ),
      ],
    );
  }

  Widget _buildUserCountCard({
    required String title,
    required dynamic count,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 32.0, color: color),
            SizedBox(width: 8.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        Text(
          "$count korisnik/a",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  double _getProgressValue(dynamic amount) {
    if (amount == 'N/A') return 0.0;
    final double maxAmount = 1000; // Example max value for visualization
    final double value = double.tryParse(amount.toString()) ?? 0.0;
    return value / maxAmount;
  }

  Widget _buildSupplementCard({
    required String title,
    required String title2,
    required Suplement? supplement,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center items horizontally
      children: [
        // Title at the top, centered
        Text(
          title,
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        Text(
          title2,
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        // Picture in the next row, centered
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Placeholder color
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.transparent),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              supplement?.slika == null
                  ? base64Decode(_base64Placeholder)
                  : base64Decode(supplement!.slika!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8.0), // Space between picture and name

        // Supplement name below the picture, centered
        Text(
          supplement?.naziv ?? 'N/A',
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildUserCard({
    required String title,
    required String title2,
    required Korisnik? korisnik,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center items horizontally
      children: [
        // Title at the top, centered
        Text(
          title,
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),

        Text(
          title2,
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        // Picture in the next row, centered
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Placeholder color
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.transparent),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              korisnik?.slika == null
                  ? base64Decode(_base64Placeholder)
                  : base64Decode(korisnik!.slika!),
              fit: BoxFit.cover,
            ),
          ),
        ), // Space between picture and name


        // Supplement name below the picture, centered
        Text(
          "${korisnik?.ime} ${korisnik?.prezime}" ?? 'N/A',
          textAlign: TextAlign.center, // Center the text
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
