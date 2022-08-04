final String table = "expenses";

class Expense {
  final int? id;
  final int groupMemberId;
  final String name;
  final int expense;

  Expense({
    this.id,
    required this.groupMemberId,
    required this.name,
    required this.expense,
  });

  Expense copy({
    int? id,
  }) =>
      Expense(
        id: id ?? this.id,
        groupMemberId: groupMemberId,
        name: name,
        expense: expense,
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "groupMemberId": groupMemberId,
        "name": name,
        "expense": expense,
      };

  static Expense fromJson(Map<String, Object?> json) => Expense(
        id: json["id"] as int?,
        groupMemberId: json["groupMemberId"] as int,
        name: json["name"] as String,
        expense: json["expense"] as int,
      );

  static List<Expense> fromListJson(List<Map<String, Object?>> jsons) {
    List<Expense> container = [];

    for (final json in jsons) {
      container.add(Expense.fromJson(json));
    }

    return container;
  }
}

class ExpenseColumns {
  static final List<String> values = [id, groupMemberId, name, expense];

  static final String id = 'id';
  static final String groupMemberId = 'groupMemberId';
  static final String name = 'name';
  static final String expense = 'expense';
}
