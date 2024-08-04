import 'package:flutter/material.dart';
import 'package:ironvault_mobile/layouts/master_screen.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/cart_provider.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';
import 'package:ironvault_mobile/providers/utils.dart';
import 'package:provider/provider.dart';

class SuplementListScreen extends StatefulWidget {
  static const String routeName = "/suplement";

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
    return MasterScreen("Suplementi",
    SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _buildSuplementSearch(),
            Container(
              height: 500,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30
                ),
                scrollDirection: Axis.horizontal,
                children: _buildSuplementCardList(),
              ),
            )
          ],
        ),
      ),
    ) );
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
                data = tmpData!;
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
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              print('called product');
              var tmpData = await _suplementProvider
                  ?.get(filter: {'fts': _searchController.text});
              setState(() {
                data = tmpData!;
              });
            },
          ),
        )
      ],
    );
  }

    List<Widget> _buildSuplementCardList() {
    if (data?.result?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data!.result.map((x) => Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: x.slika == null ? const Placeholder() : imageFromString(x.slika!),
          ),
          Text(x.naziv ?? ""),
          Text(formatNumber(x.cijena)),
          IconButton(onPressed: () {
              _cartProvider?.addToCart(x);
          }, icon: const Icon(Icons.shopping_cart))
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }
}
