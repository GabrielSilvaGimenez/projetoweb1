import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/controller/cost_listing_controller.dart';
import 'package:web_shop/cost_listing/page/adapter/cost_listing_adapter.dart';
import 'package:web_shop/model/item_model.dart';

class CostListingAdapterListView extends StatelessWidget {
  final CostListingController controller;
  final ItemModel item;
  const CostListingAdapterListView({
    required this.controller,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                          future: controller!.GetMechanicalParts(),
                          builder: (context, snapshot) {
                            Widget? returnedValue;
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                              case ConnectionState.active:
                                returnedValue = Obx(() => ListView.builder(
                                      itemCount: controller!.costs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return CostListingAdapter(
                                          cost: controller!.costs[index],
                                          costController: controller!,
                                          item: item,
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
        ],
      ),
    );
  }
}
