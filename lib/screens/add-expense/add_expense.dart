import 'package:expense_tracker/components/buttons/default-button/main.dart';
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

class AddExpense extends HookWidget {
  final ExpenseOperation _expenseOperation = ExpenseOperation();
  final GroupMemberOperation _groupMemberOperation = GroupMemberOperation();
  final GroupOperation _groupOperation = GroupOperation();
  final TripOperation _tripOperation = TripOperation();
  final TextEditingController _expenseName = TextEditingController();
  final TextEditingController _expenseAmount = TextEditingController();

  Future<List<Member>> _getMembers() async {
    Trip? trip = await _tripOperation.findActive();
    Group? group = await _groupOperation.readGroup(trip!.groupID);
    return _groupMemberOperation.getMembersInGroup(group!.id as int);
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Map<String, dynamic>> state = useState({
      "memberIndex": -1,
      "member": null,
    });

    return ScreenView(
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Add Expense'),
          SizedBox(height: 40),

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

          TextField(
            controller: _expenseName,
            decoration: InputDecoration(hintText: 'Expense name'),
          ),

          TextField(
            controller: _expenseAmount,
            decoration: InputDecoration(hintText: 'Expense amount'),
          ),

          SizedBox(height: 20),
          DefaultButton(
              onPress: () async {
                final String name = _expenseName.text;
                final int expenseValue = int.parse(_expenseAmount.text);
                final Member member = state.value["member"];
                final Group? group = await _groupOperation.readGroup(
                  (await _tripOperation.findActive())!.groupID,
                );
                final GroupMember? groupMember =
                    await _groupMemberOperation.get(
                  groupId: group!.id as int,
                  memberId: member.id as int,
                );

                final Expense expense = Expense(
                  groupMemberId: groupMember!.id as int,
                  name: name,
                  expense: expenseValue,
                );
                await _expenseOperation.create(expense);

                Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (route) => false);
              },
              label: "Add expense")
        ],
      ),
    );
  }
}
