import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/card.dart';
import '../widgets/column_with_title.dart';

class Marketplace extends StatelessWidget {
  const Marketplace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MarketPlace"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Column(children: [
          ColumnWithTitle(
            title: "Actions",
            children: <Widget> [
              ColumnItemCard(
                functionHandler: (BuildContext context, TapDownDetails details) {},
                icon: Icons.add,
                imageLink: "Hello",
                itemName: "Hi",
                quantity: 1,
                price: 1,
                sumPrice: 1789,
              ),
            ],
          ),
          ColumnWithTitle(
            title: "Currencies",
            children: <Widget> [
              ColumnItemCard(
                functionHandler: (BuildContext context, TapDownDetails details) {
                  context.push('/buy');
                },
                icon: Icons.add,
                imageLink: "Hello",
                itemName: "Rubles",
                sumPrice: 1789,
              ),
            ],
          ),

        ],),
      ),
    );
  }
}
