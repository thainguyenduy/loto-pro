import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// A file generated by the application
@immutable
class InputPeerSelf extends InputPeer {
  const InputPeerSelf();

  /// [originalPath] Local path to a file from which the file is generated; may
  /// be empty if there is no such file

  static const String constructor = 'inputPeerSelf';

  static InputPeerSelf? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return InputPeerSelf();
  }

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
