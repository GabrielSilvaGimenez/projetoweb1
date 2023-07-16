import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/controller/cost_listing_controller.dart';
import 'package:web_shop/edit_cost/page/edit_cost_page.dart';
import 'package:web_shop/model/cost_model.dart';
import 'package:web_shop/model/item_model.dart';

class CostListingAdapter extends StatelessWidget {
  final CostModel cost;
  final CostListingController costController;
  final ItemModel item;

  const CostListingAdapter({
    required this.cost,
    required this.costController,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cost.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descrição: ${cost.description}'),
            Text('Valor: ${cost.value}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await costController.deleteCost(cost);
              },
              child: Icon(Icons.delete),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: () {
                Get.to(EditCostPage(costController, cost, item));
              },
              child: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
