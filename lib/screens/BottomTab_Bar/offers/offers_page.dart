import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vanfly/modals/product_modal.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/screens/BottomTab_Bar/offers/offer_details.dart';
import 'package:vanfly/widgets/loading.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: width / 1.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            )),
                            Center(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxu6wGLJqMOAMT8j8fh2fjxSt3022MXvQ7Ow&usqp=CAU',
                                fit: BoxFit.cover,
                                height: width / 2.4,
                                width: width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Ends in: ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('00:20:59', style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
              'Free',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
          Container(
            height: width,
            child: Offers(),
          )
        ],
      ),
    );
  }
}

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return GridView.builder(
      itemCount: productProvider.offers.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return OfferCard(
          index: index,
          product: productProvider.offers[index],
        );
      },
    );
  }
}

class OfferCard extends StatelessWidget {
  final ProductModal product;
  final index;
  OfferCard({this.product, this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink[100]),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.pink[100],
                    offset: Offset(-2, -1),
                    blurRadius: 5),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: product.picture,
                              fit: BoxFit.cover,
                              height: 120,
                              width: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.pinkAccent,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return OfferDetails(
                                index: index,
                                products: product,
                              );
                            }));
                          },
                          child: Text(
                            'Get',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        )),
                  ),
                ])));
  }
}
