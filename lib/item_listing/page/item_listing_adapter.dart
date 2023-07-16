import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/cost_listing/page/cost_listing_page.dart';
import 'package:web_shop/edit_item/page/edit_item_page.dart';
import 'package:web_shop/item_listing/controller/item_listing_controller.dart';
import 'package:web_shop/model/item_model.dart';

class ItemListingAdapter extends StatelessWidget {
  final ItemModel item;
  final ItemListingController itemListingController;

  const ItemListingAdapter({
    Key? key,
    required this.item,
    required this.itemListingController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color.fromARGB(255, 146, 109, 248),
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              await Get.to(
                CostListingPage(item),
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          item.imageView!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Container(child: internalMechanicalPartsTitle()),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 5,
            child: InkWell(
              onTap: () {
                Get.to(EditItemPage(itemListingController, item));
              },
              child: Icon(
                Icons.list,
                size: 32,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 5,
            child: InkWell(
              onTap: () {
                itemListingController.removerItem(item.id);
              },
              child: Icon(
                Icons.delete,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget internalMechanicalPartsTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.name!,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Descrição',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(Get.context!).size.width * 0.2,
            maxHeight: MediaQuery.of(Get.context!).size.height,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent, // border color
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description!,
                maxLines: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
