import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../utils/hex_color.dart';

class BuyItemPage extends StatefulWidget {
  const BuyItemPage({Key? key}) : super(key: key);

  @override
  State<BuyItemPage> createState() => _BuyItemPageState();
}

class _BuyItemPageState extends State<BuyItemPage> {
  int _quantity = 1;
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy actions"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 35, right: 35),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8), // Border width
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(60), // Image radius
                  child: const FlutterLogo(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Rubles",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Price: 360",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity--;
                      quantityController.text = '$_quantity';
                    });
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.remove),
                  splashRadius: 1,
                ),
                Flexible(
                  child: TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        _quantity = int.tryParse(text) ?? 0;
                      });
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _quantity++;
                    quantityController.text = '$_quantity';
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.add_outlined),
                  splashRadius: 1,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Available slots: 120",
              style: TextStyle(
                fontSize: 14,
                color: HexColor.fromHex("#686777"),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height /10,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(

                ),
                child: const Text("Buy"),
              ),
            ),
            const SizedBox(height: 20, ),
          ],
        ),
      ),
    );
  }
}
