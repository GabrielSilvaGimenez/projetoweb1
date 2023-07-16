import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_item_listing.dart/controller/create_item_listing_controller.dart';
import 'package:web_shop/item_listing/controller/item_listing_controller.dart';
import 'package:web_shop/item_listing/page/item_listing_page.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class CreateItemListingPage extends StatelessWidget {
  var controller = Get.put(CreateItemListingController());

  late DropzoneViewController controller1;
  CreateItemListingPage(ItemListingController this.itemController, {super.key});
  ItemListingController itemController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    UserController.i.user.name!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * .9,
            child: Stack(
              children: <Widget>[
                const Positioned(
                  top: 100,
                  left: 32,
                  child: Text(
                    'Criação do item',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                  ),
                ),
                Positioned(
                  top: 190,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(62),
                        )),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.imagesList.length,
                          itemBuilder: (context, index) {
                            return Image.memory(
                              controller.imagesList[index],
                              width: 80,
                              height: 80,
                            );
                          },
                        ),
                        Container(
                          color: controller.highlighted1.value
                              ? Colors.red
                              : Colors.transparent,
                          child: Stack(
                            children: [
                              buildZone1(context),
                              const Center(
                                child: Text('Arraste os arquivos'),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await controller.getImages(controller1);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurpleAccent),
                          ),
                          child: const Text('Pegar Arquivo'),
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: 'Nome'),
                          onChanged: (value) {
                            controller.name.value = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 62),
                          child: TextField(
                            decoration:
                                const InputDecoration(hintText: 'Descrição'),
                            onChanged: (value) {
                              controller.description.value = value;
                            },
                          ),
                        ),
                        InkWell(
                          child: Container(
                            height: 45,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            child: const Center(
                              child: Text(
                                'Criar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (await controller.createItem()) {
                              await itemController.getItemsList();
                              await Get.off(
                                ItemListingPage(),
                              );
                            }
                          },
                        ),
                        Container(
                          height: 16,
                        ),
                        Container(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            controller.highlighted1.value = true;
          },
          onLeave: () {
            controller.highlighted1.value = false;
          },
          onDrop: (ev) async {
            print('Zone 1 drop: ${ev.name}');
            controller.highlighted1.value = false;
            final bytes = await controller1.getFileData(ev);
            print(bytes.sublist(0, 20));
          },
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      );
}
