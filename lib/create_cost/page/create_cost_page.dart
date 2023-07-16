import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/controller/cost_listing_controller.dart';
import 'package:web_shop/cost_listing/page/cost_listing_page.dart';
import 'package:web_shop/create_cost/controller/create_cost_controller.dart';
import 'package:web_shop/model/item_model.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class CreateCostPage extends StatelessWidget {
  final _inputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  CreateCostController? controller;
  CreateCostPage(
      CostListingController this.costListingController, ItemModel this.item,
      {super.key}) {
    controller = Get.put(CreateCostController(item));
  }
  CostListingController costListingController;

  ItemModel item;

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
                  'Cadastro de custo',
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
                              'Criar custo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await controller!.createCost()) {
                            await costListingController.getAllCosts(item!.id!);
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
