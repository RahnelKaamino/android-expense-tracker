import 'package:expense_tracker/components/buttons/default-button/main.dart';
import 'package:expense_tracker/components/navigation-drawer/main.dart';
import 'package:expense_tracker/components/texts/centered-text/h1-centered-text/main.dart';
import 'package:expense_tracker/components/texts/centered-text/h2-centered-text/h2_centered_text.dart';
import 'package:expense_tracker/components/texts/centered-text/h3-centered-text/h3_centered_text.dart';
import 'package:expense_tracker/components/views/screen-view/main.dart';
import 'package:expense_tracker/models/groups/groups_operation.dart';
import 'package:expense_tracker/models/trips/trip_model.dart';
import 'package:expense_tracker/models/trips/trip_operation.dart';
import 'package:expense_tracker/screens/dashboard/methods/check_active_trip/check_active_trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class Dashboard extends HookWidget {
  final TripOperation _tripOperation = TripOperation();
  final GroupOperation _groupOperation = GroupOperation();

  final moneyCurrencyConverter = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Map<String, dynamic>> state = useState({
      "tripName": '',
      "totalExpense": 0,
    });
    useEffect(checkActiveTrip(_tripOperation, context, state), []);

    useEffect(() {
      (() async {
        final Trip? trip = await _tripOperation.findActive();
        final num totalExpense =
            await _groupOperation.getGroupExpenses(trip!.groupID);

        state.value["totalExpense"] = totalExpense;
        state.value = {...state.value};
      })();
    }, []);

    return ScreenView(
      drawer: NavigationDrawer(),
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Dashboard'),
          SizedBox(height: 40),

          // BODY
          H2CenteredText('Trip name: ${state.value["tripName"]}'),
          H3CenteredText(
              'Trip total expense: ${moneyCurrencyConverter.format(state.value["totalExpense"])} Php'),
          SizedBox(height: 40),
          DefaultButton(
              onPress: () async {
                final Trip? trip = await _tripOperation.findActive();
                _tripOperation.endTrip(trip!);
                checkActiveTrip(_tripOperation, context, state)();
              },
              label: "Finish Trip")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-expense');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
