import 'package:ironvault_mobile/models/suplement.dart';

class Cart {
    List<CartItem> items = [];
}

class CartItem {
  CartItem(this.suplement, this.count);
  late Suplement suplement;
  late int count;
}