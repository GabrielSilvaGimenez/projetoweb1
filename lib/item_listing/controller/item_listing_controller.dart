import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/item_listing/service/item_listing_service.dart';
import 'package:web_shop/model/item_model.dart';

class ItemListingController extends GetxController {
  final ItemListingService service = Get.put(ItemListingService());
  var items = <ItemModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getItemsList();
  }

  Future<void> GetMechanicalParts() async {
    Future.delayed(const Duration(seconds: 3));
  }

  Future<void> getItemsList() async {
    var result = await service.getItemsList();

    if (result != null) {
      items.value = result;
    }
  }

  Future<void> removerItem(int? id) async {
    var result = await service.removeItem(id);

    if (result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Excluido com sucesso.',
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

      await getItemsList();

      return;
    }

    Get.snackbar(
      '',
      '',
      titleText: const Text(
        'Erro ao deletar.',
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
