import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class H3CenteredText extends HookWidget {
  final String text;

  H3CenteredText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(37, 39, 77, 1),
      ),
    );
  }
}
