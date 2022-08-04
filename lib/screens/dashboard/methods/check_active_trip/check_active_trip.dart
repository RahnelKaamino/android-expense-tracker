import 'package:expense_tracker/models/trips/trip_model.dart';
import 'package:expense_tracker/models/trips/trip_operation.dart';
import 'package:flutter/material.dart';

checkActiveTrip(
  TripOperation tripOperation,
  BuildContext context,
  ValueNotifier<Map<String, dynamic>> state,
) =>
    () {
      (() async {
        final Trip? trip = await tripOperation.findActive();

        if (trip == null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/create-trip',
            (route) => false,
          );

          return;
        }

        state.value["tripName"] = trip.name;
        state.value = {...state.value};
      })();
    };
