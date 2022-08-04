import 'package:expense_tracker/components/buttons/default-button/main.dart';
import 'package:expense_tracker/components/texts/centered-text/h1-centered-text/main.dart';
import 'package:expense_tracker/components/views/screen-view/main.dart';
import 'package:expense_tracker/models/group_members/group_member_model.dart';
import 'package:expense_tracker/models/group_members/group_member_operation.dart';
import 'package:expense_tracker/models/groups/groups_model.dart';
import 'package:expense_tracker/models/members/member_model.dart';
import 'package:expense_tracker/models/members/member_operation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddMembers extends HookWidget {
  final _memberName = TextEditingController();
  final _memberOperation = MemberOperation();
  final _groupMemberOperation = GroupMemberOperation();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Map<String, dynamic>> state = useState({
      "group": Group(groupSize: 0),
      "counter": 0,
      "members": [],
    });
    final Map<String, dynamic>? routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    useEffect(() {
      state.value['group'] = routeData?["group"];
      state.value = {...state.value};
    }, []);

    return ScreenView(
      child: Column(
        children: [
          // HEADER
          SizedBox(height: 40),
          H1CenteredText('Add Members'),
          SizedBox(height: 40),

          // BODY
          TextField(
            controller: _memberName,
            decoration: InputDecoration(hintText: 'Member name'),
          ),

          SizedBox(height: 10),
          DefaultButton(
            onPress: () async {
              final String name = _memberName.text;
              final Group? group = state.value['group'];

              if (group != null) {
                if (state.value["counter"] <= group.groupSize) {
                  state.value["members"].add(name);
                  state.value["counter"] = state.value["counter"] + 1;
                  state.value = {...state.value};
                  _memberName.text = "";
                }

                if (state.value["counter"] >= group.groupSize) {
                  for (final element in state.value["members"]) {
                    Member member = Member(name: element);
                    Member createdMember =
                        await _memberOperation.create(member);

                    GroupMember groupMember = GroupMember(
                      groupId: group.id as int,
                      memberId: createdMember.id as int,
                    );
                    _groupMemberOperation.create(groupMember);
                  }

                  // RESET
                  state.value["members"] = [];
                  state.value["counter"] = 0;
                  state.value = {...state.value};

                  Navigator.pushNamed(context, '/dashboard');
                }
              } else {
                // RESET
                state.value["members"] = [];
                state.value["counter"] = 0;
                state.value = {...state.value};
                print('Something went wrong');
              }
            },
            label: 'ADD MEMBER',
          )
        ],
      ),
    );
  }
}
