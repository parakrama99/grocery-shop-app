import 'package:flutter/material.dart';
import 'package:grocery_shop/models/cart_model.dart';
import 'package:grocery_shop/models/product_model.dart';

// CartProvider class to manage cart operations using ChangeNotifier for state management
class CartProvider with ChangeNotifier {
  // Private list to store cart items
  List<CartModel> _carts = [];

  // Getter to access cart items
  List<CartModel> get carts => _carts;

  // Setter to update cart items and notify listeners
  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to add a product to the cart or update quantity if it already exists
  addCart(ProductModel product, int qunatity) {
    // Check if the product already exists in the cart
    if (productExist(product)) {
      // Find the index of the existing product
      int index =
          _carts.indexWhere((element) => element.product!.id == product.id);
      // Update the quantity of the existing product
      _carts[index].quantity = _carts[index].quantity! + qunatity;
    } else {
      // Add a new product to the cart
      _carts.add(
          CartModel(id: _carts.length, product: product, quantity: qunatity));
    }
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to remove a product from the cart based on its ID
  remoceCart(int id) {
    _carts.removeWhere((element) => element.id == id);
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to check if a product already exists in the cart
  productExist(ProductModel product) {
    // Check if the product exists by comparing IDs
    if (_carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false; // Product does not exist
    } else {
      return true; // Product exists
    }
  }

  // Method to calculate the total price of items in the cart
  totalPrice() {
    double total = 0;
    for (var element in _carts) {
      // Multiply quantity by price and add to total
      total += (element.quantity! * element.product!.price!);
    }
    return total; // Return the total price
  }
}
