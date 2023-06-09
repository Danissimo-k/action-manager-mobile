import 'package:flutter/material.dart';

import '../../utils/hex_color.dart';

enum ItemType { currency, stock }

class ColumnItemCard extends StatelessWidget {
  String imageLink;
  String itemName;
  IconData icon;
  void Function(BuildContext context, TapDownDetails details) functionHandler;
  int? quantity;
  double? price;
  double? sumPrice;
  ItemType itemType;

  ColumnItemCard({
    Key? key,
    required this.imageLink,
    required this.itemName,
    required this.icon,
    required this.functionHandler,
    required this.itemType,
    this.quantity,
    this.price,
    this.sumPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: MediaQuery.of(context).size.height / 6.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Border width
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(30), // Image radius
                  child: const FlutterLogo(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._cardQuantityInfo(
                          itemName: itemName, quantity: quantity, price: price)
                    ],
                  ),
                ),
              ),
            ),
            Text(
              sumPrice != null ? "$sumPrice₽" : "",
              style: const TextStyle(fontSize: 18),
            ),
            Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: GestureDetector(
                      onTapDown: (details) {
                        functionHandler(context, details);
                      },
                      child: Icon(icon),
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  List<Widget> _cardQuantityInfo(
      {required String itemName, int? quantity, double? price}) {
    List<Widget> arr = [];
    arr.add(Text(
      itemName,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: HexColor.fromHex("#464948"),
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
      ),
    ));
    if (quantity != null && price != null) {
      arr.add(Text(
        "${this.quantity} ${itemType == ItemType.stock ? "шт" : ""}. · ${this.price}₽",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ));
    } else if (price != null) {
      arr.add(Text(
        "${this.price}₽",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ));
    } else if (quantity != null) {
      arr.add(Text(
        "${this.quantity} ${itemType == ItemType.stock ? "шт" : ""}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ));
    }
    return arr;
  }
}
