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

class OfferDetails extends StatefulWidget {
  final ProductModal products;
  final index;

  OfferDetails({this.products, this.index});

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        onPressed: () async {},
        minWidth: double.infinity,
        height: 70.0,
        child: Text(
          'Buy Now',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                  child: Container(
                    width: 280,
                    height: 80,
                    child: Text(
                      widget.products.name,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${widget.products.newprice} Coins',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs${widget.products.oldprice}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough, fontSize: 15),
                    )
                  ],
                ),
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
