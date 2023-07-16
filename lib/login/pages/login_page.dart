import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_user/page/create_user_page.dart';
import 'package:web_shop/login/controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  var controller = LoginController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * .9,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 100,
                left: 32,
                child: Text(
                  controller.login.value,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                top: 190,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(62),
                      )),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(hintText: 'Email'),
                        onChanged: (value) {
                          controller.name.value = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 62),
                        child: TextField(
                          decoration: const InputDecoration(hintText: 'Senha'),
                          obscureText: true,
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          child: const Center(
                            child: Text(
                              'Acessar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          controller.loginIn();
                        },
                      ),
                      Container(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => CreateUserPage(),
                          );
                        },
                        child: const Text(
                          "Criar Conta",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
