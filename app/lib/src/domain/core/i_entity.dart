import 'package:event_bus/event_bus.dart';
import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/infrastructure/injector.dart';

abstract class IEntity {
  IEntity({required this.id});
  @UniqueIdConverter()
  UniqueId id;
  Option<ValueFailure<dynamic>> get failureOption;

  @JsonKey(includeFromJson: false, includeToJson: false)
  EventBus eventBus = locator<EventBus>();
}
