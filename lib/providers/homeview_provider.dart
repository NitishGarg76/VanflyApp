import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:vanfly/refer_and_earnn/dynamic_link.dart';

class HomeViewProvider extends ChangeNotifier {

  final deepLinkApi = GetIt.I.get<DynamicLinksApi>();
  HomeViewProvider(){deepLinkApi.handleDynamicLink();}
}
