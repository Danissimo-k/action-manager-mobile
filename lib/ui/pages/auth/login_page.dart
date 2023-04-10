import 'package:action_manager/controllers/auth_controller.dart';
import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../components/password_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Авторизация",
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 25),
                              //  mail textfield
                              TextField(
                                controller: controller.email,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                ),
                              ),
                              SizedBox(height: 25),
                              //  password
                              PasswordTextField(
                                controller: controller.password,
                                hintText: "Пароль",
                              ),
                              SizedBox(height: 30),
                              Container(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: TextButton(
                                    child: const Text(
                                      'Войти',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    onPressed: () {
                                      controller.login(UserModel(
                                          name: "",
                                          email: controller.email.text,
                                          phone: null,
                                          password: controller.password.text));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          HexColor.fromHex("2864FF"),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      textStyle: const TextStyle(
                                        fontSize: 24,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                ),
                                onPressed: () {
                                  Get.offNamed("/signup");
                                },
                                child: Text(
                                  "Зарегестрироваться",
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
