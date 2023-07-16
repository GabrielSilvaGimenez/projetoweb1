import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/login/pages/login_page.dart';

class CustomAppBar extends StatelessWidget {
  final bool enableAction1;
  final bool enableAction2;
  final bool enableAction3;
  final bool enableAction4;
  final bool seller;
  final Size screenSize;

  CustomAppBar({
    required this.enableAction1,
    required this.enableAction2,
    required this.enableAction3,
    required this.enableAction4,
    required this.seller,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).hintColor,
    );

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 7,
                      ),
                      child: TextButton(
                        style: style,
                        onPressed: enableAction1 ? () {} : null,
                        child: const Text('Lotes'),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 7,
                      ),
                      child: TextButton(
                        style: style,
                        onPressed: enableAction2 ? () {} : null,
                        child: const Text('Histórico de lances'),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 60),
                    Visibility(
                      visible: seller,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 7,
                        ),
                        child: TextButton(
                          style: style,
                          onPressed: enableAction3 ? () {} : null,
                          child: const Text('Criar lotes'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenSize.width / 60),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                child: Visibility(
                  child: TextButton(
                    style: style,
                    onPressed: enableAction4
                        ? () {
                            Get.to(() => LoginPage());
                          }
                        : null,
                    child: const Text('Acessar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
