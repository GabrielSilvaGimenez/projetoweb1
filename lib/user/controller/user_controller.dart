import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:web_shop/login/pages/login_page.dart';
import 'package:web_shop/model/user_model.dart';
import 'package:web_shop/user/service/user_service.dart';

class UserController extends GetxController {
  var login = false.obs;
  var token = ''.obs;
  var user = UserModel();
  final UserService userService;
  static UserController get i => Get.find();

  UserController({
    required this.userService,
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> save(String to) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(to);
    if (decodedToken != null) {
      user.id = int.parse(decodedToken['sub']);
      userService.save(to);

      var result = await userService.getUserInfo(user.id!);
      if (result.id != null) {
        user = result;

        login.value = userService.getLogin();
        token.value = userService.getToken();
      }
    } else {
      print('Falha ao decodificar o token');
    }
  }

  Future<void> logout() async {
    if (!login.value && !token.isNotEmpty) {
      userService.logout();
      login.value = false;
      token.value = '';
      user = UserModel();

      Get.offAll(LoginPage());
    }
    Get.offAll(LoginPage());
  }
}
