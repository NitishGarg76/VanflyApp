import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_modal.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const VCOINS = "vCoins";

  String _name;
  String _email;
  String _id;
  int _priceSum = 0;
  dynamic _vCoins;

//  getters
  String get name => _name;

  String get email => _email;

  String get id => _id;

  dynamic get vCoins => _vCoins;

  // public variables
  List<CartItemModel> cart;
  String totalCartPrice;

  UserModel.fromDocument(DocumentSnapshot doc) {
    _vCoins = doc.get(VCOINS);
    _name = doc.get(NAME);
    _email = doc.get(EMAIL);
    _id = doc.get(ID);
    cart = _convertCartItems(doc.get(CART) ?? []);
    totalCartPrice = getTotalPrice(cart: doc.get(CART));
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  String getTotalPrice({List cart}) {
    if (cart == null) {
      return '0';
    }
    for (Map cartItem in cart) {
      _priceSum += int.parse(cartItem["price"]);
    }

    String total = _priceSum.toString();
    return total;
  }
}
