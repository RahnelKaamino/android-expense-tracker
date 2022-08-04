final String table = 'trips';

class Trip {
  final int? id;
  final int groupID;
  final String name;
  final String status;

  Trip({
    this.id,
    required this.groupID,
    required this.name,
    required this.status,
  });

  Trip copy({
    int? id,
    int? groupID,
    String? name,
    String? status,
  }) =>
      Trip(
        id: id ?? this.id,
        groupID: groupID ?? this.groupID,
        name: name ?? this.name,
        status: status ?? this.status,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'groupID': groupID,
        'name': name,
        'status': status,
      };

  static Trip fromJson(Map<String, Object?> json) => Trip(
        id: json['id'] as int?,
        groupID: json['groupID'] as int,
        name: json['name'] as String,
        status: json['status'] as String,
      );
}

class TripColumns {
  static final List<String> values = [id, groupID, name, status];

  static final String id = 'id';
  static final String groupID = 'groupID';
  static final String name = 'name';
  static final String status = 'status';
}
