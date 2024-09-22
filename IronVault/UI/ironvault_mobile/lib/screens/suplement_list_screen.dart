import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/utils/utils.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart'; // Import your LoadingScreen
import 'no_data_found.dart';

class SuplementListScreen extends StatefulWidget {
  static const String routeName = "/suplement";
    final int id; // Add this

  const SuplementListScreen(this.id,{Key? key}) : super(key: key);

  @override
  State<SuplementListScreen> createState() => _SuplementListScreenState();
}

class _SuplementListScreenState extends State<SuplementListScreen> {
  SuplementProvider? _suplementProvider;
  CartProvider? _cartProvider;
  SearchResult<Suplement>? data;
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Add a loading flag

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
      _isLoading = false; // Set loading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Suplementi",
      index: 1, // Set the desired index here
      child: _isLoading
          ? LoadingScreen() // Show the loading screen while data is being loaded
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildSuplementSearch(), // Always displayed
                  (data?.result == null || data!.result.isEmpty)
                      ? Container(
                          height: MediaQuery.of(context).size.height -
                              300, // Adjust height if needed
                          child: Scaffold(
                            body: noDataFound("Suplementi nisu pronađeni"),
                          ),
                        )
                      : Container(
                          height: 580,
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            scrollDirection: Axis.horizontal,
                            children: _buildSuplementCardList(),
                          ),
                        ),
                ],
              ),
            ),
            id: widget.id,
    );
  }

  Widget _buildSuplementSearch() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                setState(() {
                  _isLoading = true; // Set loading to true while searching
                });
                var tmpData = await _suplementProvider
                    ?.get(filter: {'fts': _searchController.text});
                setState(() {
                  data = tmpData;
                  _isLoading =
                      false; // Set loading to false after data is loaded
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
                  borderSide: const BorderSide(color: Colors.blue),
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
              setState(() {
                _isLoading = true; // Set loading to true while searching
              });
              var tmpData = await _suplementProvider
                  ?.get(filter: {'fts': _searchController.text});
              setState(() {
                data = tmpData;
                _isLoading = false; // Set loading to false after data is loaded
              });
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSuplementCardList() {
    if (data?.result == null || data!.result.isEmpty) {
      return [noDataFound("Suplementi nisu pronađeni")];
    }

    List<Widget> list = data!.result
        .map((x) => Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(15, 8, 0, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 6,
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
                  addToCartButton(() {
                  _cartProvider?.addToCart(x);
                }),
                
                ],
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }





Widget addToCartButton(VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Background color
      foregroundColor: Colors.white, // Text and icon color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding
       elevation: 10, // Shadow effect
        shadowColor: Colors.black.withOpacity(0.5),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.shopping_cart,
          size: 20, // Icon size
        ),
        SizedBox(width: 8), // Space between icon and text
        Text(
          'Dodaj u korpu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

}
