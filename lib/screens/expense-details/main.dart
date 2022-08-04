import 'package:expense_tracker/components/texts/centered-text/h1-centered-text/main.dart';
import 'package:expense_tracker/components/views/screen-view/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpenseDetails extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenView(
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Expense Details'),
          SizedBox(height: 40),

          // BODY
        ],
      ),
    );
  }
}
