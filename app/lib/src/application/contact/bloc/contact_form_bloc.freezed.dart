// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ContactFormState {
  Contact get contact => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  Option<Either<ContactFailure, Unit>> get saveFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactFormStateCopyWith<ContactFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactFormStateCopyWith<$Res> {
  factory $ContactFormStateCopyWith(
          ContactFormState value, $Res Function(ContactFormState) then) =
      _$ContactFormStateCopyWithImpl<$Res, ContactFormState>;
  @useResult
  $Res call(
      {Contact contact,
      bool showErrorMessages,
      bool isEditing,
      bool isSaving,
      Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption});
}

/// @nodoc
class _$ContactFormStateCopyWithImpl<$Res, $Val extends ContactFormState>
    implements $ContactFormStateCopyWith<$Res> {
  _$ContactFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
    Object? showErrorMessages = null,
    Object? isEditing = null,
    Object? isSaving = null,
    Object? saveFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFailureOrSuccessOption: null == saveFailureOrSuccessOption
          ? _value.saveFailureOrSuccessOption
          : saveFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<ContactFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactFormStateImplCopyWith<$Res>
    implements $ContactFormStateCopyWith<$Res> {
  factory _$$ContactFormStateImplCopyWith(_$ContactFormStateImpl value,
          $Res Function(_$ContactFormStateImpl) then) =
      __$$ContactFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Contact contact,
      bool showErrorMessages,
      bool isEditing,
      bool isSaving,
      Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption});
}

/// @nodoc
class __$$ContactFormStateImplCopyWithImpl<$Res>
    extends _$ContactFormStateCopyWithImpl<$Res, _$ContactFormStateImpl>
    implements _$$ContactFormStateImplCopyWith<$Res> {
  __$$ContactFormStateImplCopyWithImpl(_$ContactFormStateImpl _value,
      $Res Function(_$ContactFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
    Object? showErrorMessages = null,
    Object? isEditing = null,
    Object? isSaving = null,
    Object? saveFailureOrSuccessOption = null,
  }) {
    return _then(_$ContactFormStateImpl(
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFailureOrSuccessOption: null == saveFailureOrSuccessOption
          ? _value.saveFailureOrSuccessOption
          : saveFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<ContactFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$ContactFormStateImpl implements _ContactFormState {
  const _$ContactFormStateImpl(
      {required this.contact,
      required this.showErrorMessages,
      required this.isEditing,
      required this.isSaving,
      required this.saveFailureOrSuccessOption});

  @override
  final Contact contact;
  @override
  final bool showErrorMessages;
  @override
  final bool isEditing;
  @override
  final bool isSaving;
  @override
  final Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption;

  @override
  String toString() {
    return 'ContactFormState(contact: $contact, showErrorMessages: $showErrorMessages, isEditing: $isEditing, isSaving: $isSaving, saveFailureOrSuccessOption: $saveFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactFormStateImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.saveFailureOrSuccessOption,
                    saveFailureOrSuccessOption) ||
                other.saveFailureOrSuccessOption ==
                    saveFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact, showErrorMessages,
      isEditing, isSaving, saveFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactFormStateImplCopyWith<_$ContactFormStateImpl> get copyWith =>
      __$$ContactFormStateImplCopyWithImpl<_$ContactFormStateImpl>(
          this, _$identity);
}

abstract class _ContactFormState implements ContactFormState {
  const factory _ContactFormState(
      {required final Contact contact,
      required final bool showErrorMessages,
      required final bool isEditing,
      required final bool isSaving,
      required final Option<Either<ContactFailure, Unit>>
          saveFailureOrSuccessOption}) = _$ContactFormStateImpl;

  @override
  Contact get contact;
  @override
  bool get showErrorMessages;
  @override
  bool get isEditing;
  @override
  bool get isSaving;
  @override
  Option<Either<ContactFailure, Unit>> get saveFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$ContactFormStateImplCopyWith<_$ContactFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
