import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/modals/product_modal.dart';
import 'package:vanfly/providers/app_provider.dart';
import 'package:vanfly/providers/user_provider.dart';
import 'package:vanfly/screens/cart.dart';
import 'package:vanfly/screens/BottomTab_Bar/home.dart';
import 'package:vanfly/widgets/image_carousel.dart';

bool favourite = false;

class ProductDetails extends StatefulWidget {
  final ProductModal products;
  final index;

  ProductDetails({this.products, this.index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                changeScreen(context, Cart());
              })
        ],
        title: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }));
            },
            child: Text('Vanfly')),
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.pinkAccent,
        onPressed: () async {
          appProvider.changeIsLoading();
          bool success = await userProvider.addToCart(
            product: widget.products,
          );

          if (success) {
            // ignore: deprecated_member_use
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Added to Cart!")));
            userProvider.reloadUserModel();

            appProvider.changeIsLoading();
            return;
          } else {
            // ignore: deprecated_member_use
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Not added to Cart!")));
            appProvider.changeIsLoading();
            return;
          }
        },
        minWidth: double.infinity,
        height: 70.0,
        child: Text(
          'Add To Cart',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 400,
            child: ImageCarousel(
              imageList: [
                for (var i = 0; i < widget.products.imageslider.length; i++)
                  widget.products.imageslider[i]
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        widget.products.name,
                        style: TextStyle(fontSize: 17),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(direction: Axis.vertical, children: [
                            Text(
                              'Rs${widget.products.newprice}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rs${widget.products.oldprice}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 17,
                                  color: Colors.blueGrey),
                            ),
                          ]))
                    ])),
              ],
            ),
          ),
          Divider(
            color: Colors.pink[100],
            endIndent: 10,
            indent: 10,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.products.description,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
