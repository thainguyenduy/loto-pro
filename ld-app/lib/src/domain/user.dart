import 'package:tdlib/td_api.dart' as td;

class User {
  User.me(td.User user)
      : id = user.id,
        accessHash = user.accessHash,
        name = "${user.firstName} ${user.lastName}";

  final int id;
  final String name;
  final int? accessHash;

  const User({required this.id, required this.name, this.accessHash});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is User && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
