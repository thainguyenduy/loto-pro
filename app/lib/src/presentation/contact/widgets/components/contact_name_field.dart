import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';

class ContactNameField extends StatefulWidget {
  const ContactNameField({super.key});

  @override
  State<ContactNameField> createState() => _ContactNameFieldState();
}

class _ContactNameFieldState extends State<ContactNameField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      builder: (context, state) {
        return TextFormField(
          controller: _model.contactNameController,
          focusNode: FocusNode(),
          onChanged: (_) => EasyDebounce.debounce(
            '_model.contactNameController',
            const Duration(milliseconds: 2000),
            () => setState(() {}),
          ),
          obscureText: false,
          decoration: InputDecoration(
            labelText: FFLocalizations.of(context).getText(
              'q85cu9ud' /* Tên khách hàng */,
            ),
            labelStyle: FlutterFlowTheme.of(context).bodySmall,
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
            suffixIcon: _model.contactNameController!.text.isNotEmpty
                ? InkWell(
                    onTap: () async {
                      _model.contactNameController?.clear();
                      setState(() {});
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
          validator: _model.contactNameControllerValidator.asValidator(context),
        );
      },
    );
  }
}
