import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class H2CenteredText extends HookWidget {
  final String text;

  H2CenteredText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(34, 150, 254, 1),
      ),
    );
  }
}
