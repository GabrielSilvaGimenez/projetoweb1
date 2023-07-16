import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_shop/user/controller/user_controller.dart';

class EditUserService {
  Future<String> editUser(
      String username, String password, String email) async {
    var auth = UserController.i.token;
    var id = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/users/update/$id');

    final body = jsonEncode({
      'name': username,
      'password': password,
      'email': UserController.i.user.email,
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
      return '';
    }
  }

  Future<String> deleteUser() async {
    var auth = UserController.i.token;
    var idUser = UserController.i.user.id;
    final url = Uri.parse('http://localhost:8080/users/$idUser');

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
