import 'package:action_manager/controllers/auth_controller.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(60), // Image radius
                child: Image.asset("lib/images/avatar.jpg"),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _authController.user.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Пользователь",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      color: HexColor.fromHex("#686777")),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            // const SizedBox(height: 20),
            // Container(
            //   alignment: AlignmentDirectional.topStart,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Статус",
            //         style: TextStyle(
            //           fontFamily: "Poppins",
            //           fontSize: 12,
            //           color: HexColor.fromHex("#686777"),
            //         ),
            //       ),
            //       SizedBox(height: 5),
            //       const Text(
            //         "Hello World",
            //         style: TextStyle(
            //           fontSize: 16,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const Divider(color: Colors.grey),
            const SizedBox(height: 24),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Данные пользователя",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: HexColor.fromHex("#686777"),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.map,
                        color: HexColor.fromHex("#554AF0"),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        _authController.user.geo != null
                            ? '${_authController.user.geo!.lat.toStringAsFixed(5)}, ${_authController.user.geo!.long.toStringAsFixed(5)}'
                            : "Не указано",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: HexColor.fromHex("#554AF0"),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        _authController.user.email,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
