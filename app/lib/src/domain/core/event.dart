import 'package:event_bus/event_bus.dart';
import 'package:ld_app/src/infrastructure/injector.dart';

mixin DomainEvent {
  EventBus eventBus = locator<EventBus>();
}
