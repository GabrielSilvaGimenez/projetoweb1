import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/controller/cost_listing_controller.dart';
import 'package:web_shop/cost_listing/page/adapter/cost_listing_adapter_item.dart';
import 'package:web_shop/create_cost/page/create_cost_page.dart';
import 'package:web_shop/edit_user/page/edit_user_page.dart';
import 'package:web_shop/model/item_model.dart';
import 'package:web_shop/user/controller/user_controller.dart';

import 'adapter/cost_listing_adapter_list_view.dart';

class CostListingPage extends StatelessWidget {
  CostListingController? controller;

  CostListingPage(ItemModel this.item) {
    controller = Get.put(CostListingController(item));
  }
  ItemModel item;

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
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: CostListingAdapterItem(
              item: item,
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Positioned(
                    top: 100,
                    left: 32,
                    child: Text(
                      'Meus Custos',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent),
                    ),
                  ),
                  CostListingAdapterListView(
                    controller: controller!,
                    item: item,
                  ),
                  Divider(
                    color: Colors.red,
                  ),
                  Obx(
                    () => Card(
                      child: ListTile(
                        title: Text('Custo total'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valor: ${controller!.valorTotal}'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            Get.to(CreateCostPage(
              controller!,
              item,
            ));
          }),
    );
  }
}
