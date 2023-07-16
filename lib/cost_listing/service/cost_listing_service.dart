import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_shop/model/cost_model.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class CostListingService {
  Future<List<CostModel>> getAllCosts(int itemId) async {
    List<CostModel> costs = [];
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/costs/$itemId');

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
        CostModel item = CostModel.fromJson(itemJson);
        costs.add(item);
      }

      return costs;
    } else {
      UserController.i.logout();
      return costs;
    }
  }

  Future<String> deleteCost(int? costId) async {
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/costs/$costId');

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
