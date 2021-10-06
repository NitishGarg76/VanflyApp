class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "image";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";

  String _id;
  String _name;
  String _image;
  String _productId;
  dynamic _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;


  dynamic get price => _price;


  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name = data[NAME];
    _image = data[PICTURE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
  }

  Map toMap() =>
      {
        ID: _id,
        PICTURE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,

      };
}