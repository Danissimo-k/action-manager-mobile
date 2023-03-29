import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/password_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 32.0),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                        ),
                        onPressed: () { 
                          context.go("/signup");
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                            color: HexColor.fromHex("#2864FF"),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25),
                  //  mail textfield
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 25),
                  //  password
                  PasswordTextField(
                    controller: this.passwordController,
                    hintText: "Password",
                    showPassText: "Show",
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {
                          context.go("/");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor.fromHex("2864FF"),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
