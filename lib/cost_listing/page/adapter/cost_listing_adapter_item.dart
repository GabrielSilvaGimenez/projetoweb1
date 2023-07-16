import 'package:flutter/material.dart';
import 'package:web_shop/model/item_model.dart';

class CostListingAdapterItem extends StatelessWidget {
  final ItemModel item;
  const CostListingAdapterItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.memory(
            item.imageView!,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 16),
          Text(
            item.name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.description!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
