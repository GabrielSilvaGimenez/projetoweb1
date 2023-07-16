import 'package:get/get.dart';
import 'package:web_shop/user/controller/user_controller.dart';

import 'user/service/user_service.dart';

class GlobalBind implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(UserService());
    Get.put<UserController>(
      UserController(
        userService: Get.find(),
      ),
    );
  }
}
