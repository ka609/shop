import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem(String articleId, String title, double price) {
    if (_items.containsKey(articleId)) {
      _items[articleId]!.quantity += 1;
    } else {
      _items[articleId] = CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
      );
    }
    notifyListeners();
  }

  void removeItem(String articleId) {
    _items.remove(articleId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
