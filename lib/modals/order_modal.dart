import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _description;
  String _userId;
  String _status;
  dynamic _createdAt;
  dynamic _total;

//  getters
  String get id => _id;

  String get description => _description;

  String get userId => _userId;

  String get status => _status;

  dynamic get total => _total;

  dynamic get createdAt => _createdAt;

  // public variable
  List cart;

  OrderModel.fromDocument(DocumentSnapshot doc) {
    _id = doc.get(ID);
    _description = doc.get(DESCRIPTION);
    _total = doc.get(TOTAL);
    _status = doc.get(STATUS);
    _userId = doc.get(USER_ID);
    _createdAt = doc.get(CREATED_AT);
    cart = doc.get(CART);
  }
}
