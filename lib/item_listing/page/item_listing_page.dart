import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_item_listing.dart/page/create_item_listing_page.dart';
import 'package:web_shop/edit_user/page/edit_user_page.dart';
import 'package:web_shop/item_listing/page/item_listing_adapter.dart';
import 'package:web_shop/item_listing/controller/item_listing_controller.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class ItemListingPage extends StatelessWidget {
  var controller = Get.put(ItemListingController());
  ItemListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.to(EditUserPage());
                  },
                  child: Container(
                      child: Text(
                    UserController.i.user.name!,
                  )),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Meus items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FutureBuilder(
                          future: controller.GetMechanicalParts(),
                          builder: (context, snapshot) {
                            Widget? returnedValue;
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                              case ConnectionState.active:
                                returnedValue = Obx(() => ListView.builder(
                                      itemCount: controller.items.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ItemListingAdapter(
                                          item: controller.items[index],
                                          itemListingController: controller,
                                        );
                                      },
                                    ));
                                break;
                              default:
                                returnedValue = const LinearProgressIndicator();
                                break;
                            }

                            return returnedValue;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            await Get.to(
              CreateItemListingPage(controller),
            );
          }),
    );
  }
}
