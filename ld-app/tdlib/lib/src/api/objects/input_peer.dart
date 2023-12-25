import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Points to a file
@immutable
abstract class InputPeer extends TdObject {
  const InputPeer();

  static const String constructor = 'inputPeer';

  /// Inherited by:
  /// [InputPeerEmpty]
  /// [InputPeerSelf]
  /// [InputPeerChat]
  /// [InputPeerUser]
  static InputPeer? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    switch (json['@type']) {
      case InputPeerEmpty.constructor:
        return InputPeerEmpty.fromJson(json);
      case InputPeerSelf.constructor:
        return InputPeerSelf.fromJson(json);
      /* case InputPeerChat.constructor:
        return InputPeerChat.fromJson(json); */
      case InputPeerUser.constructor:
        return InputPeerUser.fromJson(json);
      default:
        return null;
    }
  }

  @override
  String getConstructor() => constructor;

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
