import 'package:get_it/get_it.dart';
import 'package:vanfly/refer_and_earnn/dynamic_link.dart';

void setUpGetIt() {
  GetIt.I.registerSingleton<DynamicLinksApi>(DynamicLinksApi());
}
