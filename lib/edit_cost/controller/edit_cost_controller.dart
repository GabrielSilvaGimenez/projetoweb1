import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/edit_cost/service/edit_cost_service.dart';
import 'package:web_shop/model/cost_model.dart';

class EditCostController extends GetxController {
  final EditCostService service = Get.put(EditCostService());

  var name = TextEditingController();
  var description = TextEditingController();
  var value = TextEditingController();
  CostModel cost;
  EditCostController(this.cost);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    name.text = cost.name;
    description.text = cost.description;
    value.text = cost.value.toString();
  }

  Future<bool> editCost() async {
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
    var result = await service.editCost(
      name.text,
      description.text,
      value.text,
      cost.itemId!,
      cost.id,
    );

    if (result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Custo Editado',
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
          'Erro ao Editar custo',
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
