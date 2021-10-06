import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/screens/cart.dart';
import 'package:vanfly/screens/products_screen/details_page.dart';
import 'package:vanfly/screens/products_screen/products_page.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                productProvider.productsSearched.clear();
                Navigator.pop(context);
              });
            }),
        title: Text(
          "Result",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                changeScreen(
                  context,
                  Cart(),
                );
              })
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No products Found",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 22),
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          ProductDetails(
                              products:
                                  productProvider.productsSearched[index]));
                    },
                    child: SingleProduct(
                        product: productProvider.productsSearched[index]));
              }),
    );
  }
}
