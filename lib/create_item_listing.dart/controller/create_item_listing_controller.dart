// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_shop/create_item_listing.dart/service/create_item_service.dart';

class CreateItemListingController extends GetxController {
  final CreateItemListingService service = Get.put(CreateItemListingService());

  var highlighted1 = false.obs;
  var imagesList = <Uint8List>[].obs;
  var name = ''.obs;
  var description = ''.obs;

  Future<void> getImages(DropzoneViewController dvController) async {
    var files = await dvController.pickFiles(
      mime: ['image/jpeg', 'image/png'],
    );

    var uintList = await dvController.getFileData(files.first);

    imagesList.add(uintList);
    imagesList.refresh();
  }

  Future<bool> createItem() async {
    if (name.isEmpty || description.isEmpty || imagesList.isEmpty) {
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
    var result = await service.createItem(
        name.value, description.value, imagesList.first, dataFormatada);

    if (result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Item criado',
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
      return true;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Erro ao criar item',
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
