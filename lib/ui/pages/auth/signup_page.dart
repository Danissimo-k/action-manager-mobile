import 'package:action_manager/controllers/auth_controller.dart';
import 'package:action_manager/models/user.dart';
import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../components/password_textfield.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  AuthController controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
          return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            //  signup + login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "Регистрация",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 25),
                            //  name textfield
                            TextField(
                              controller: controller.name,
                              decoration: const InputDecoration(
                                hintText: "Имя",
                              ),
                            ),
                            const SizedBox(height: 25),

                            //  mail textfield
                            TextField(
                              controller: controller.email,
                              decoration: const InputDecoration(
                                hintText: "Эл. почта",
                              ),
                            ),

                            const SizedBox(height: 25),
                            //  password
                            PasswordTextField(
                              controller: controller.password,
                              hintText: "Пароль",
                            ),
                            const SizedBox(height: 30),
                            Container(
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: TextButton(
                                  onPressed: () async {
                                    controller.registerUser(UserModel(
                                        name: controller.name.text,
                                        email: controller.email.text,
                                        phone: null,
                                        password: controller.password.text));
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: HexColor.fromHex("2864FF"),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  child: const Text(
                                    'Зарегистрироваться',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(30, 30),
                              ),
                              onPressed: () {
                                Get.offNamed("/login");
                              },
                              child: Text(
                                "Авторизоваться",
                                style: TextStyle(
                                  color: HexColor.fromHex("#2864FF"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }
}
