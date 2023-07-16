import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web_shop/user/controller/user_controller.dart';

class CreateItemListingService {
  Future<String> createItem(
    String name,
    String description,
    Uint8List image,
    String dataFormatada,
  ) async {
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/items');

    String encodedString = base64.encode(image);

    var body = jsonEncode({
      'name': name,
      'description': description,
      'dateCad': '$dataFormatada',
      'userId': id,
      'image': '$encodedString'
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
