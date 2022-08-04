import 'package:expense_tracker/components/buttons/default-button/main.dart';
import 'package:expense_tracker/components/texts/centered-text/h1-centered-text/main.dart';
import 'package:expense_tracker/components/views/screen-view/main.dart';
import 'package:expense_tracker/screens/create-trip/methods/create_trip/create_trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateTrip extends HookWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _groupSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Create Trip'),
          SizedBox(height: 40),

          // BODY
          TextField(
            controller: _name,
            decoration: InputDecoration(hintText: 'Trip name'),
          ),

          TextField(
            controller: _groupSize,
            decoration: InputDecoration(hintText: 'Group Size'),
          ),

          SizedBox(height: 10),
          DefaultButton(
            label: 'CREATE TRIP',
            onPress: createTrip(
              name: _name,
              groupSize: _groupSize,
              context: context,
            ),
          )
        ],
      ),
    );
  }
}
