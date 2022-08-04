import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class H1CenteredText extends HookWidget {
  final String text;

  H1CenteredText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(34, 150, 254, 1),
      ),
    );
  }
}
