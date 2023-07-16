import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_shop/model/item_model.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class ItemListingService {
  Future<List<ItemModel>> getItemsList() async {
    List<ItemModel> items = [];
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/items/$id');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$auth',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {}
      List<dynamic> jsonList = jsonDecode(response.body);

      for (var itemJson in jsonList) {
        ItemModel item = ItemModel.fromJson(itemJson);
        item.imageView = base64.decode(item.image!);
        items.add(item);
      }

      return items;
    } else {
      // UserController.i.logout();
      return items;
    }
  }

  Future<String> removeItem(int? idItem) async {
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/items/$idItem');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$auth',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      UserController.i.logout();

      return '';
    }
  }
}
