import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_user/controller/create_user_controller.dart';
import 'package:web_shop/login/pages/login_page.dart';

class CreateUserPage extends GetView<CreateUserController> {
  @override
  var controller = CreateUserController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * .9,
          child: Stack(
            children: <Widget>[
              const Positioned(
                top: 100,
                left: 32,
                child: Text(
                  'Cadastro',
                  style: TextStyle(
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(62),
                      )),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(hintText: 'Nome'),
                        onChanged: (value) {
                          controller.name.value = value;
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: 'Email'),
                        onChanged: (value) {
                          controller.email.value = value;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                              'Criar Conta',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          controller.createUser();
                        },
                      ),
                      Container(
                        height: 16,
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
