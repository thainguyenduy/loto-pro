import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class Debouncer<T> {
  Debouncer(this.duration, this.onValue);
  final Duration duration;
  final void Function(T value) onValue;
  late T _value;
  late Timer _timer;
  T get value => _value;
  set value(T val) {
    _value = val;
    _timer.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}

EventTransformer<Event> debounce<Event>(
    {Duration duration = const Duration(milliseconds: 300)}) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
