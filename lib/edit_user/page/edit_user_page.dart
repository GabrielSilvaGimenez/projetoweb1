import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/edit_user/controller/edit_user_controller.dart';

class EditUserPage extends GetView<EditUserController> {
  @override
  var controller = Get.put(EditUserController());

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
                  'Editar',
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
                        controller: controller.name.value,
                        decoration: const InputDecoration(hintText: 'Nome'),
                        onChanged: (value) {
                          controller.name.value.text = value;
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
                              'Editar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          controller.editUser();
                        },
                      ),
                      Container(
                        height: 16,
                      ),
                      InkWell(
                        child: Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 129, 129),
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          child: const Center(
                            child: Text(
                              'Excluir',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await controller.deleteUser();
                        },
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
