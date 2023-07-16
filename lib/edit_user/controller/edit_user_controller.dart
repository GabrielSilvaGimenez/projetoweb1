import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/edit_user/service/edit_user_service.dart';
import 'package:web_shop/item_listing/page/item_listing_page.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class EditUserController extends GetxController {
  final EditUserService service = Get.put(EditUserService());

  var name = TextEditingController().obs;
  var password = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name.value.text = UserController.i.user.name!;
    email.value = UserController.i.user.email!;
  }

  Future<void> editUser() async {
    bool isValid = validateEmail(email.value);

    if (!isValid || password.value.isEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'preencha todos os campos, ou digite um email valido',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
      return;
    }

    String result =
        await service.editUser(name.value.text, password.value, email.value);
    if (result != null && result.isNotEmpty) {
      await UserController.i.save(UserController.i.token.value);
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Usuario Editado com sucesso',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
      Get.off(ItemListingPage());
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Erro ao editar',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
    }
  }

  bool validateEmail(String email) {
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  Future<void> deleteUser() async {
    var result = await service.deleteUser();

    if (result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Conta excluida com sucesso.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
      UserController.i.logout();
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Ops deu algum problema.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
    }
  }
}
