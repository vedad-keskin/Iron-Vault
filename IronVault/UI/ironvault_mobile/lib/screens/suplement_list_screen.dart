import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/providers/utils.dart';
import 'package:provider/provider.dart';

class SuplementListScreen extends StatefulWidget {
  const SuplementListScreen({Key? key}) : super(key: key);

  @override
  State<SuplementListScreen> createState() => _SuplementListScreenState();
}

class _SuplementListScreenState extends State<SuplementListScreen> {
  SuplementProvider? _suplementProvider = null;
  CartProvider? _cartProvider = null;
  SearchResult<Suplement>? data = null;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _suplementProvider = context.read<SuplementProvider>();
    _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _suplementProvider?.get();
    setState(() {
      data = tmpData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Suplementi",
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [_buildSuplementSearch()],
            ),
          ),
        ));
  }

  _buildSuplementSearch() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: TextField(
            controller: _searchController,
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
        ))
        ,    Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () async {
                print('called product');
                 // var tmpData = await _suplementProvider?.get(filter: {'fts': _searchController.text});
                setState(() {
                  // data = tmpData!;
                });
              },
            ),
          )
      ],
    );
  }
}
