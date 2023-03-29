import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ColumnWithTitle extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ColumnWithTitle({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
              fontFamily: 'Poppins',
              color: HexColor.fromHex("#686777"),
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
          ),
        ),
        Column(children: children.isNotEmpty ? children : [Text("No")])
      ],
    );
  }
}
