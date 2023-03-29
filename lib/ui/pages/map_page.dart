import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';

import '../widgets/card.dart';
import '../widgets/column_with_title.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);

  final TextEditingController mapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Print country",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: HexColor.fromHex("#554AF0")),
                  )
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              // height: MediaQuery.of(context).size.height / 1.4,
              child: Container(width: double.infinity, child: FittedBox(child: Image.asset("lib/images/map.jpeg"), fit: BoxFit.fill,)),
            )
          ],
        ),
      ),
    );
  }
}
