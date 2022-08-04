import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScreenView extends HookWidget {
  final Widget child;
  final Widget? drawer;
  final FloatingActionButton? floatingActionButton;

  ScreenView({
    required this.child,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: this.drawer,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: SizedBox(
            width: double.infinity,
            child: this.child,
          ),
        ),
      ),
      floatingActionButton: this.floatingActionButton,
    );
  }
}
