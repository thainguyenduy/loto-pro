import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/contact/contact_failure.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';
part 'contact_form_bloc.freezed.dart';

@injectable
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc() : super(_Initial()) {
    on<ContactFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
