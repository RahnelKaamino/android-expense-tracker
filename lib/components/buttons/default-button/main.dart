import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DefaultButton extends HookWidget {
  final void Function() onPress;
  final String label;

  DefaultButton({
    required this.onPress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: this.onPress,
        child: Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(35, 150, 243, 1),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }
}
