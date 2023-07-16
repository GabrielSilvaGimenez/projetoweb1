import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_cost/service/create_cost_service.dart';
import 'package:web_shop/model/item_model.dart';

class CreateCostController extends GetxController {
  final CreateCostService service = Get.put(CreateCostService());

  var name = TextEditingController();
  var description = TextEditingController();
  var value = TextEditingController();

  ItemModel item;

  CreateCostController(
    ItemModel this.item,
  );

  Future<bool> createCost() async {
    if (name.text.isEmpty || description.text.isEmpty || value.text.isEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Por favor, preencha todos os dados.',
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
      return false;
    }
    var result = await service.createCost(
      name.text,
      description.text,
      value.text,
      item.id!,
    );

    if (result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Custo criado',
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

      return true;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Erro ao criar custo',
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
      return false;
    }
  }
}
