import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  // We cannot let a simple String be passed in. This would allow for possible non-unique IDs.
  factory UniqueId() {
    return UniqueId._(
      Right(const Uuid().v1()),
    );
  }

  /// Used with strings we trust are unique, such as database IDs.
  factory UniqueId.fromUniqueString(String uniqueIdStr) {
    return UniqueId._(
      Right(uniqueIdStr),
    );
  }

  const UniqueId._(this.value);
}

class UniqueIdConverter implements JsonConverter<UniqueId, String> {
  const UniqueIdConverter();

  @override
  UniqueId fromJson(String id) => UniqueId.fromUniqueString(id);

  @override
  String toJson(UniqueId id) => id.getOrCrash();
}
