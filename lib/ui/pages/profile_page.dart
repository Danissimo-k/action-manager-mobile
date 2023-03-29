import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your portfolio"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 35, right: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(60), // Image radius
                child: Image.asset("lib/images/img.png"),
              ),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Dan Kokh",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Programmer",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      color: HexColor.fromHex("#686777")),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STATUS",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: HexColor.fromHex("#686777"),
                    ),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    "Hello World",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 24),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "USER DETAILS",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: HexColor.fromHex("#686777"),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                          Icons.phone_outlined,
                          color: HexColor.fromHex("#554AF0"),
                      ),
                      SizedBox(width: 15),
                      Text("+xxx xx xx xx",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(
                          Icons.mail_outline,
                          color: HexColor.fromHex("#554AF0"),
                      ),
                      SizedBox(width: 15),
                      Text("xxxxxxx@gmail.com",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),)
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
