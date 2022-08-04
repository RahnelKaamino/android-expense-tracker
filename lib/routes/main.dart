import 'package:expense_tracker/screens/add-expense/add_expense.dart';
import 'package:expense_tracker/screens/add-members/main.dart';
import 'package:expense_tracker/screens/create-trip/main.dart';
import 'package:expense_tracker/screens/dashboard/main.dart';
import 'package:expense_tracker/screens/expense-details/main.dart';
import 'package:expense_tracker/screens/members/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Routes extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/create-trip': (context) => CreateTrip(),
        '/add-members': (context) => AddMembers(),
        '/add-expense': (context) => AddExpense(),
        '/expense-details': (context) => ExpenseDetails(),
        '/members': (context) => Members(),
      },
    );
  }
}
