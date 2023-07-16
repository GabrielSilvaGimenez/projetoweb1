import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/controller/cost_listing_controller.dart';
import 'package:web_shop/cost_listing/page/cost_listing_page.dart';
import 'package:web_shop/edit_cost/controller/edit_cost_controller.dart';
import 'package:web_shop/model/cost_model.dart';
import 'package:web_shop/model/item_model.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class EditCostPage extends StatelessWidget {
  final _inputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  EditCostController? controller;
  EditCostPage(CostListingController this.costListingController,
      CostModel this.cost, this.item,
      {super.key}) {
    controller = Get.put(EditCostController(cost));
  }
  CostListingController costListingController;
  ItemModel item;
  CostModel cost;

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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * .9,
          child: Stack(
            children: <Widget>[
              const Positioned(
                top: 100,
                left: 32,
                child: Text(
                  'Editar custo',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                top: 190,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(62),
                      )),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller!.name,
                        decoration: const InputDecoration(hintText: 'Nome'),
                      ),
                      TextField(
                        controller: controller!.description,
                        decoration:
                            const InputDecoration(hintText: 'Descrição'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 62),
                        child: TextField(
                          inputFormatters: [_inputFormatter],
                          controller: controller!.value,
                          decoration: const InputDecoration(hintText: 'Valor'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          child: const Center(
                            child: Text(
                              'Editar custo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await controller!.editCost()) {
                            await costListingController
                                .getAllCosts(cost!.itemId!);
                            await Get.off(
                              CostListingPage(item),
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
    );
  }
}
