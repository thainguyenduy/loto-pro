import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Resends the login email address verification code
/// Returns [EmailAddressAuthenticationCodeInfo]
@immutable
class ResendLoginEmailAddressCode extends TdFunction {
  const ResendLoginEmailAddressCode();

  static const String constructor = 'resendLoginEmailAddressCode';

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
