// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TelegramAuthState {
  TelegramAuthStatus get status => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TelegramAuthStateCopyWith<TelegramAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramAuthStateCopyWith<$Res> {
  factory $TelegramAuthStateCopyWith(
          TelegramAuthState value, $Res Function(TelegramAuthState) then) =
      _$TelegramAuthStateCopyWithImpl<$Res, TelegramAuthState>;
  @useResult
  $Res call(
      {TelegramAuthStatus status,
      String? phone,
      String? code,
      String? password,
      String? errorMessage});
}

/// @nodoc
class _$TelegramAuthStateCopyWithImpl<$Res, $Val extends TelegramAuthState>
    implements $TelegramAuthStateCopyWith<$Res> {
  _$TelegramAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? phone = freezed,
    Object? code = freezed,
    Object? password = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramAuthStatus,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelegramAuthStateImplCopyWith<$Res>
    implements $TelegramAuthStateCopyWith<$Res> {
  factory _$$TelegramAuthStateImplCopyWith(_$TelegramAuthStateImpl value,
          $Res Function(_$TelegramAuthStateImpl) then) =
      __$$TelegramAuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TelegramAuthStatus status,
      String? phone,
      String? code,
      String? password,
      String? errorMessage});
}

/// @nodoc
class __$$TelegramAuthStateImplCopyWithImpl<$Res>
    extends _$TelegramAuthStateCopyWithImpl<$Res, _$TelegramAuthStateImpl>
    implements _$$TelegramAuthStateImplCopyWith<$Res> {
  __$$TelegramAuthStateImplCopyWithImpl(_$TelegramAuthStateImpl _value,
      $Res Function(_$TelegramAuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? phone = freezed,
    Object? code = freezed,
    Object? password = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TelegramAuthStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramAuthStatus,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TelegramAuthStateImpl
    with DiagnosticableTreeMixin
    implements _TelegramAuthState {
  const _$TelegramAuthStateImpl(
      {this.status = TelegramAuthStatus.initial,
      this.phone,
      this.code,
      this.password,
      this.errorMessage});

  @override
  @JsonKey()
  final TelegramAuthStatus status;
  @override
  final String? phone;
  @override
  final String? code;
  @override
  final String? password;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TelegramAuthState(status: $status, phone: $phone, code: $code, password: $password, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TelegramAuthState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelegramAuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, phone, code, password, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelegramAuthStateImplCopyWith<_$TelegramAuthStateImpl> get copyWith =>
      __$$TelegramAuthStateImplCopyWithImpl<_$TelegramAuthStateImpl>(
          this, _$identity);
}

abstract class _TelegramAuthState implements TelegramAuthState {
  const factory _TelegramAuthState(
      {final TelegramAuthStatus status,
      final String? phone,
      final String? code,
      final String? password,
      final String? errorMessage}) = _$TelegramAuthStateImpl;

  @override
  TelegramAuthStatus get status;
  @override
  String? get phone;
  @override
  String? get code;
  @override
  String? get password;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$TelegramAuthStateImplCopyWith<_$TelegramAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
