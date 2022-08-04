import 'package:expense_tracker/constants/trips/trip_constants.dart';
import 'package:expense_tracker/models/groups/groups_model.dart';
import 'package:expense_tracker/models/groups/groups_operation.dart';
import 'package:expense_tracker/models/trips/trip_model.dart';
import 'package:expense_tracker/models/trips/trip_operation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createTrip({
  required TextEditingController name,
  required TextEditingController groupSize,
  required BuildContext context,
}) =>
    () async {
      try {
        GroupOperation groupOperation = GroupOperation();
        TripOperation tripOperation = TripOperation();

        Group group = Group(groupSize: int.parse(groupSize.text));
        final Group createdGroup = await groupOperation.createGroup(group);

        Trip trip = Trip(
          groupID: createdGroup.id!,
          name: name.text,
          status: IN_PROGRESS,
        );
        tripOperation.create(trip);

        Navigator.pushReplacementNamed(
          context,
          '/add-members',
          arguments: {
            'group': createdGroup,
          },
        );
      } catch (e) {
        print(e);
        print('Something went wrong');
      }
    };
