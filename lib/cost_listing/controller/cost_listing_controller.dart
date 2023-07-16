import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/service/cost_listing_service.dart';
import 'package:web_shop/model/cost_model.dart';
import 'package:web_shop/model/item_model.dart';

class CostListingController extends GetxController {
  final CostListingService service = Get.put(CostListingService());
  var costs = <CostModel>[].obs;
  var valorTotal = 0.0.obs;
  ItemModel? item;

  CostListingController(
    ItemModel this.item,
  );

  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllCosts(item!.id!);
  }

  Future<void> getAllCosts(int itemId) async {
    var result = await service.getAllCosts(item!.id!);

    if (result != null) {
      costs.value = result;
      valorTotal.value = 0;
      for (var cost in costs) {
        valorTotal.value += cost.value.toDouble();
      }
    }
  }

  Future<void> GetMechanicalParts() async {
    Future.delayed(const Duration(seconds: 3));
  }

  Future<void> deleteCost(CostModel cost) async {
    var result = await service.deleteCost(cost.id);

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

      await getAllCosts(cost.itemId);

      return;
    }
  }
}
