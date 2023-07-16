import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_shop/model/user_model.dart';

class UserService {
  static final GetStorage _storage = GetStorage();

  Future<void> save(token) async {
    if (token != null && token.isNotEmpty) {
      // ignore: prefer_interpolation_to_compose_strings
      token = 'Bearer ' + token;
      _storage.write('token', token);
      _storage.write('isLogin', true);
    }
  }

  String getToken() {
    return _storage.read('token');
  }

  Future logout() async {
    _storage.write('isLogin', false);
    _storage.write('token', '');
  }

  bool getLogin() {
    return _storage.read('isLogin');
  }

  Future<UserModel> getUserInfo(int id) async {
    var model = UserModel();
    var auth = UserService().getToken();

    final url = Uri.parse('http://localhost:8080/users/getMyUser/$id');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$auth',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        model = UserModel.fromJson(jsonDecode(response.body));
      }

      return model;
    } else {
      // UserController.i.logout();
      return model;
    }
  }
}
