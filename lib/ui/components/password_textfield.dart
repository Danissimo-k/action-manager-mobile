import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  String showPassText;

  PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.showPassText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hidePass = true;

  void changeShowPassState() {
    setState(() => {_hidePass = !_hidePass});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _hidePass,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffix: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              changeShowPassState();
            },
            child: _hidePass ? const Text("Show") : const Text("Hide")
        ),
      ),
    );
  }
}
