import 'package:flutter/material.dart';
import 'package:ironvault_mobile/models/cart.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();
  addToCart(Suplement suplement) {
    if (findInCart(suplement) != null) {
      findInCart(suplement)?.count++;
    } else {
      cart.items.add(CartItem(suplement, 1));
    }
    
    notifyListeners();
  }

  removeFromCart(Suplement suplement) {
    cart.items.removeWhere((item) => item.suplement.suplementId == suplement.suplementId);
    notifyListeners();
  }

  CartItem? findInCart(Suplement suplement) {
    CartItem? item = cart.items.firstWhere((item) => item.suplement.suplementId == suplement.suplementId);
    return item;
  }
}