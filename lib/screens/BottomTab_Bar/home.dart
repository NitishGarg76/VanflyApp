import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/providers/homeview_provider.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/providers/user_provider.dart';
import 'package:vanfly/refer_and_earnn/create_referal_code.dart';
import 'package:vanfly/screens/BottomTab_Bar/offers/offers_page.dart';
import 'package:vanfly/screens/BottomTab_Bar/profile_page.dart';
import 'package:vanfly/screens/BottomTab_Bar/task/tasks_screen.dart';
import 'package:vanfly/screens/products_screen/products_page.dart';
import 'package:vanfly/screens/orders_screen.dart';
import 'package:vanfly/screens/purchases_screen.dart';
import 'package:vanfly/screens/products_screen/search_products.dart';
import 'package:vanfly/screens/signup_screen/signup.dart';
import 'package:vanfly/widgets/category_card.dart';
import 'package:vanfly/widgets/image_carousel.dart';
import 'package:vanfly/widgets/loading.dart';
import 'package:vanfly/screens/cart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appBarLabel;
  int _selectedIndex = 0;
  List<Widget> pages = <Widget>[
    HomeView(),
    Task(),
    OffersPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  appBarText() {
    if (_selectedIndex == 0) {
      appBarLabel = 'Vanfly';
    } else if (_selectedIndex == 1) {
      appBarLabel = 'Tasks';
    } else if (_selectedIndex == 2) {
      appBarLabel = 'Offers';
    } else if (_selectedIndex == 3) {
      appBarLabel = 'Profile';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    appBarText();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Cart();
                }));
              })
        ],
        title: Text(appBarLabel),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              accountName: Text(
                user.userModel?.name ?? "username lading...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userModel?.email ?? "email loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${user.userModel?.vCoins} Coins' ?? "loading...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
              leading: Icon(FontAwesomeIcons.user),
              title: Text("Profile"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Purchases());
              },
              leading: Icon(FontAwesomeIcons.shoppingBag),
              title: Text("Purchases"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: Text("My orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Cart());
              },
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, SignUp());
              },
              leading: Icon(Icons.read_more_rounded),
              title: Text("About"),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  user.signOut();
                });
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
            ),
          ],
        ),
      ),
      body: Consumer<HomeViewProvider>(
        builder: (_, model, child) => CreateReferralCode((String referralCode) {
          model.deepLinkApi.createReferralLink(referralCode);
          return pages.elementAt(_selectedIndex);
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.blueGrey,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pinkAccent,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'V-Mart',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.tasks),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_sharp),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'Profile',
            ),
          ]),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    productsPage() {
      if (selectedCard == 0) {
        return ProductsPage(
          productList: productProvider.mobiles,
        );
      } else if (selectedCard == 1) {
        return ProductsPage(productList: productProvider.pcANDLaptop);
      } else if (selectedCard == 2) {
        return ProductsPage(productList: productProvider.bedSheets);
      } else if (selectedCard == 3) {
        return ProductsPage(productList: productProvider.doorMats);
      } else if (selectedCard == 4) {
        return ProductsPage(productList: productProvider.kurti);
      } else if (selectedCard == 5) {
        return ProductsPage(productList: productProvider.more);
      }
    }

    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.pinkAccent,
                ),
                title: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (pattern) async {
                    await productProvider.searchProducts(productName: pattern);
                    changeScreen(
                      context,
                      ProductSearchScreen(),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: "search...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('homepageslider')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                return ImageCarousel(
                  imageList: snapshot.data.docs[0]['imagesliderhome'],
                );
              }
            }),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CategoryCard(
                selected: selectedCard == 0 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 0;
                  });
                },
                icon: Icons.phone_iphone,
                name: 'Mobile',
              ),
              CategoryCard(
                selected: selectedCard == 1 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 1;
                  });
                },
                icon: Icons.computer,
                name: 'PC/Laptop',
              ),
              CategoryCard(
                selected: selectedCard == 2 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 2;
                  });
                },
                icon: Icons.king_bed_outlined,
                name: 'BedSheets',
              ),
              CategoryCard(
                selected: selectedCard == 3 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 3;
                  });
                },
                icon: Icons.king_bed_outlined,
                name: 'DoorMats',
              ),
              CategoryCard(
                selected: selectedCard == 4 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 4;
                  });
                },
                icon: Icons.king_bed_outlined,
                name: 'Kurti',
              ),
              CategoryCard(
                selected: selectedCard == 5 ? true : false,
                onPressed: () {
                  setState(() {
                    selectedCard = 5;
                  });
                },
                icon: Icons.king_bed_outlined,
                name: 'More',
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            'Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        //AllProducts()
        Container(
          height: 450,
          child: productsPage(),
        )
      ],
    );
  }
}
