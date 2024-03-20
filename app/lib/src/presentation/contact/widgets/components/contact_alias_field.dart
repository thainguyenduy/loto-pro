import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_animations.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/presentation/contact/bloc/contact_form_bloc.dart';

class ContactAliasField extends StatefulWidget {
  const ContactAliasField({super.key});

  @override
  State<ContactAliasField> createState() => _ContactAliasFieldState();
}

class _ContactAliasFieldState extends State<ContactAliasField>
    with TickerProviderStateMixin {
  late TextEditingController _controller;
  final _animation = AnimationInfo.formField();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    createAnimation(_animation, this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactFormBloc, ContactFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        _controller.text = state.contact.contactAlias ?? '';
      },
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          focusNode: FocusNode(),
          onChanged: (contactAlias) => EasyDebounce.debounce(
            '_ContactForm_contact_alias',
            const Duration(milliseconds: 2000),
            () => context
                .read<ContactFormBloc>()
                .add(ContactFormContactAliasChanged(contactAlias)),
          ),
          obscureText: false,
          decoration: InputDecoration(
            labelText: FFLocalizations.of(context).getText(
              'welfl6wy' /* Bạn gọi người này là */,
            ),
            labelStyle: FlutterFlowTheme.of(context).bodySmall,
            hintText: FFLocalizations.of(context).getText(
              'thwyhcbq' /* Ví dụ: Anh */,
            ),
            hintStyle: FlutterFlowTheme.of(context).bodySmall,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
            suffixIcon: _controller.text.isNotEmpty
                ? InkWell(
                    onTap: () async {
                      _controller.clear();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Color(0xFF757575),
                      size: 22.0,
                    ),
                  )
                : null,
          ),
          style: FlutterFlowTheme.of(context).bodyMedium,
        );
      },
    ).animateOnPageLoad(_animation);
  }
}
