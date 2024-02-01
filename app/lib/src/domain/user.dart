import 'package:tdlib/td_api.dart' as td;

class User {
  User.me(td.User user)
      : id = user.id,
        name = "${user.firstName} ${user.lastName}",
        me = true;

  final int id;
  final String name;
  final bool me;

  const User({required this.id, required this.name, this.me = false});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is User && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
