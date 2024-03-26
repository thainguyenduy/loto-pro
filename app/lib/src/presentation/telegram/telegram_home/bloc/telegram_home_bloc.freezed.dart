// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TelegramHomeState {
  TelegramHomeStatus get status => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  List<Chat> get chats => throw _privateConstructorUsedError;
  ChatListFilter get filter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TelegramHomeStateCopyWith<TelegramHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramHomeStateCopyWith<$Res> {
  factory $TelegramHomeStateCopyWith(
          TelegramHomeState value, $Res Function(TelegramHomeState) then) =
      _$TelegramHomeStateCopyWithImpl<$Res, TelegramHomeState>;
  @useResult
  $Res call(
      {TelegramHomeStatus status,
      String? query,
      List<Chat> chats,
      ChatListFilter filter});
}

/// @nodoc
class _$TelegramHomeStateCopyWithImpl<$Res, $Val extends TelegramHomeState>
    implements $TelegramHomeStateCopyWith<$Res> {
  _$TelegramHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? query = freezed,
    Object? chats = null,
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramHomeStatus,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ChatListFilter,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelegramHomeStateImplCopyWith<$Res>
    implements $TelegramHomeStateCopyWith<$Res> {
  factory _$$TelegramHomeStateImplCopyWith(_$TelegramHomeStateImpl value,
          $Res Function(_$TelegramHomeStateImpl) then) =
      __$$TelegramHomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TelegramHomeStatus status,
      String? query,
      List<Chat> chats,
      ChatListFilter filter});
}

/// @nodoc
class __$$TelegramHomeStateImplCopyWithImpl<$Res>
    extends _$TelegramHomeStateCopyWithImpl<$Res, _$TelegramHomeStateImpl>
    implements _$$TelegramHomeStateImplCopyWith<$Res> {
  __$$TelegramHomeStateImplCopyWithImpl(_$TelegramHomeStateImpl _value,
      $Res Function(_$TelegramHomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? query = freezed,
    Object? chats = null,
    Object? filter = null,
  }) {
    return _then(_$TelegramHomeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramHomeStatus,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      chats: null == chats
          ? _value._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ChatListFilter,
    ));
  }
}

/// @nodoc

class _$TelegramHomeStateImpl implements _TelegramHomeState {
  const _$TelegramHomeStateImpl(
      {required this.status,
      this.query,
      required final List<Chat> chats,
      required this.filter})
      : _chats = chats;

  @override
  final TelegramHomeStatus status;
  @override
  final String? query;
  final List<Chat> _chats;
  @override
  List<Chat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  final ChatListFilter filter;

  @override
  String toString() {
    return 'TelegramHomeState(status: $status, query: $query, chats: $chats, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelegramHomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, query,
      const DeepCollectionEquality().hash(_chats), filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelegramHomeStateImplCopyWith<_$TelegramHomeStateImpl> get copyWith =>
      __$$TelegramHomeStateImplCopyWithImpl<_$TelegramHomeStateImpl>(
          this, _$identity);
}

abstract class _TelegramHomeState implements TelegramHomeState {
  const factory _TelegramHomeState(
      {required final TelegramHomeStatus status,
      final String? query,
      required final List<Chat> chats,
      required final ChatListFilter filter}) = _$TelegramHomeStateImpl;

  @override
  TelegramHomeStatus get status;
  @override
  String? get query;
  @override
  List<Chat> get chats;
  @override
  ChatListFilter get filter;
  @override
  @JsonKey(ignore: true)
  _$$TelegramHomeStateImplCopyWith<_$TelegramHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
