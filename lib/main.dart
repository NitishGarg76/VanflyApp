import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/providers/app_provider.dart';
import 'package:vanfly/providers/homeview_provider.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/providers/user_provider.dart';
import 'package:vanfly/refer_and_earnn/get_it_setup.dart';
import 'package:vanfly/screens/BottomTab_Bar/home.dart';
import 'package:vanfly/screens/login_screen/login.dart';
import 'package:vanfly/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  setUpGetIt();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: ProductProvider.initialize(),
      ),
      ChangeNotifierProvider.value(
        value: UserProvider.initialize(),
      ),
      ChangeNotifierProvider.value(
        value: AppProvider(),
      ),
      ChangeNotifierProvider.value(
        value: HomeViewProvider(),
      ),
    ],
    child: MaterialApp(
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return MyHomePage();
      default:
        return Login();
    }
  }
}
