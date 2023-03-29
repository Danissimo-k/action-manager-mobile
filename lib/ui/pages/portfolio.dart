import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/card.dart';
import '../widgets/column_with_title.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your portfolio"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Column(
          children: [
            ColumnWithTitle(
              title: "Actions",
              children: <Widget>[
                ColumnItemCard(
                  functionHandler:
                      (BuildContext context, TapDownDetails details) {
                    _showPopUpMenuAtTap(context, details);
                  },
                  icon: Icons.more_vert,
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
              children: <Widget>[
                ColumnItemCard(
                  functionHandler:
                      (BuildContext context, TapDownDetails details) async {
                    _showPopUpMenuAtTap(context, details);
                  },
                  icon: Icons.more_vert,
                  imageLink: "Hello",
                  itemName: "Rubles",
                  sumPrice: 1789,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPopUpMenuAtTap(BuildContext context, TapDownDetails details) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem<String>(value: '1', child: Text('Sell')),
        const PopupMenuItem<String>(value: '2', child: Text('Buy')),
      ],
      // other code as above
    ).then((value) => {
          if (value == '1')
            {context.push('/sell')}
          else if (value == '2')
            {context.push('/buy')}
        });
  }
}
