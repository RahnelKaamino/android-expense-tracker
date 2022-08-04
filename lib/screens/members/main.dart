import 'package:expense_tracker/components/navigation-drawer/main.dart';
import 'package:expense_tracker/components/texts/centered-text/h1-centered-text/main.dart';
import 'package:expense_tracker/components/views/screen-view/main.dart';
import 'package:expense_tracker/models/expenses/expense_model.dart';
import 'package:expense_tracker/models/expenses/expense_operation.dart';
import 'package:expense_tracker/models/group_members/group_member_model.dart';
import 'package:expense_tracker/models/group_members/group_member_operation.dart';
import 'package:expense_tracker/models/groups/groups_model.dart';
import 'package:expense_tracker/models/groups/groups_operation.dart';
import 'package:expense_tracker/models/members/member_model.dart';
import 'package:expense_tracker/models/trips/trip_model.dart';
import 'package:expense_tracker/models/trips/trip_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class Members extends HookWidget {
  final GroupMemberOperation _groupMemberOperation = GroupMemberOperation();
  final GroupOperation _groupOperation = GroupOperation();
  final TripOperation _tripOperation = TripOperation();
  final ExpenseOperation _expenseOperation = ExpenseOperation();

  Future<List<Member>> _getMembers() async {
    Trip? trip = await _tripOperation.findActive();
    Group? group = await _groupOperation.readGroup(trip!.groupID);
    return _groupMemberOperation.getMembersInGroup(group!.id as int);
  }

  final moneyCurrencyConverter = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Map<String, dynamic>> state = useState({
      "memberIndex": -1,
      "member": null,
      "expenses": [],
    });

    return ScreenView(
      drawer: NavigationDrawer(),
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Members'),
          SizedBox(height: 40),

          // BODY
          FutureBuilder<List<Member>>(
            future: _getMembers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButton<Member>(
                  hint: Text("Choose a name"),
                  items: snapshot.data!
                      .map(
                        (Member item) => DropdownMenuItem<Member>(
                          child: Text(item.name),
                          value: item,
                        ),
                      )
                      .toList(),
                  value: state.value["memberIndex"] == -1
                      ? null
                      : snapshot.data![state.value["memberIndex"]],
                  onChanged: (item) {
                    if (item != null) {
                      state.value["memberIndex"] = snapshot.data!.indexOf(item);
                      state.value["member"] = item;
                      state.value = {...state.value};
                    }
                  },
                );
              }
              return Text("No data");
            },
          ),

          Expanded(
            flex: 1,
            child: FutureBuilder<List<Expense>>(
              future: (() async {
                final Member member = state.value["member"];

                final Group? group = await _groupOperation.readGroup(
                  (await _tripOperation.findActive())!.groupID,
                );

                final GroupMember? groupMember =
                    await _groupMemberOperation.get(
                  groupId: group!.id as int,
                  memberId: member.id as int,
                );

                return _expenseOperation
                    .getMemberExpenses(groupMember!.id as int);
              })(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("None");
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    if (snapshot.hasError) {
                      return Text("Select a member");
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  '${snapshot.data![index].name} => ${moneyCurrencyConverter.format(snapshot.data![index].expense)} Php'),
                            ),
                          );
                        },
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
