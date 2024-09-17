import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

class SuplementListScreen extends StatefulWidget {
  static const String routeName = "/suplement";

  const SuplementListScreen({Key? key}) : super(key: key);

  @override
  State<SuplementListScreen> createState() => _SuplementListScreenState();
}

class _SuplementListScreenState extends State<SuplementListScreen> {
  SuplementProvider? _suplementProvider;
  CartProvider? _cartProvider;
  SearchResult<Suplement>? data;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _suplementProvider = context.read<SuplementProvider>();
    _cartProvider = context.read<CartProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _suplementProvider?.get();
    setState(() {
      data = tmpData;
    });
  }

@override
Widget build(BuildContext context) {
  return MasterScreen(
    "Suplementi",
    index: 1, // Set the desired index here
    child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _buildSuplementSearch(),
            Container(
              height: 580,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                scrollDirection: Axis.horizontal,
                children: _buildSuplementCardList(),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

  _buildSuplementSearch() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                var tmpData = await _suplementProvider
                    ?.get(filter: {'fts': _searchController.text});
                setState(() {
                  data = tmpData;
                });
              },
              decoration: InputDecoration(
                labelText: "Pretraga",
                prefixIcon: Icon(Icons.search),
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
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              var tmpData = await _suplementProvider
                  ?.get(filter: {'fts': _searchController.text});
              setState(() {
                data = tmpData;
              });
            },
          ),
        )
      ],
    );
  }



List<Widget> _buildSuplementCardList() {
  if (data?.result == null || data!.result.isEmpty) {
    return [const Text("Loading...")];
  }

  List<Widget> list = data!.result
      .map((x) => Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            // Set the height explicitly
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 130, // Adjust image height
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: x.slika == null
                      ? const Icon(Icons.image, size: 50, color: Colors.grey)
                      : imageFromString(x.slika!),
                ),
                const SizedBox(height: 10),
                Text(
                  x.naziv ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "${x.cijena} KM",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    _cartProvider?.addToCart(x);
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.green),
                ),
              ],
            ),
          ))
      .cast<Widget>()
      .toList();

  return list;
}



}
