import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_shop/user/controller/user_controller.dart';

class EditCostService {
  Future<String> editCost(
    String name,
    String description,
    String value,
    int itemId,
    int costId,
  ) async {
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/costs/update/$costId');

    final body = jsonEncode({
      'name': name,
      'description': description,
      'value': value,
      'itemId': itemId,
    });

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$auth',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Sucesso - o login foi bem-sucedido
      final responseData = response.body;

      return responseData;
    } else {
      UserController.i.logout();

      return '';
    }
  }
}
