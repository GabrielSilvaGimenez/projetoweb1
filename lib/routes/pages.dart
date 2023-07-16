import 'package:get/get.dart';
import 'package:web_shop/create_user/page/create_user_page.dart';
import 'package:web_shop/login/pages/login_page.dart';
import 'package:web_shop/routes/routes.dart';

class Pages {
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.CREATEUSER,
      page: () => CreateUserPage(),
    ),
  ];
}
