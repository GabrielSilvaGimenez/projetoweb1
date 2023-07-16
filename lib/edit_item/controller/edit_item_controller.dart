import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_shop/edit_item/service/edit_item_service.dart';
import 'package:web_shop/model/item_model.dart';

class EditItemController extends GetxController {
  final EditItemService service = Get.put(EditItemService());
  ItemModel? item;
  var highlighted1 = false.obs;
  var imagesList = <Uint8List>[].obs;
  var name = TextEditingController();
  var description = TextEditingController();
  var idItem;

  EditItemController(
    ItemModel this.item,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imagesList.add(item!.imageView!);
    name.text = item!.name!;
    description.text = item!.description!;
    idItem = item!.id;
  }

  Future<void> getImages(DropzoneViewController dvController) async {
    var files = await dvController.pickFiles(
      mime: ['image/jpeg', 'image/png'],
    );

    var uintList = await dvController.getFileData(files.first);

    imagesList.add(uintList);
    imagesList.refresh();
  }

  Future<bool> editItem() async {
    if (name.text.isEmpty || description.text.isEmpty || imagesList.isEmpty) {
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
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('yyyy-MM-dd').format(dataAtual);
    var result = await service.editItem(
        name.text, description.text, imagesList.first, idItem, dataFormatada);

    if (result != null) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Editado com sucesso.',
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
      imagesList.clear();
      name.text = '';
      description.text = '';
      idItem = '';
      return true;
    }
    return false;
  }

  void remover() {
    imagesList.clear();
  }
}
