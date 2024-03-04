import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_drop_down.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/form_field_controller.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';
import 'package:ld_app/src/domain/contact/contact.dart';

class ReplyModeField extends StatelessWidget {
  const ReplyModeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      builder: (context, state) {
        var controller =
            FormFieldController<num>(state.contact.replyMode.getOrCrash());
        return FlutterFlowDropDown<num>(
          controller: controller,
          options: ReplyModes.values.map((e) => e.index).toList(),
          optionLabels: [
            FFLocalizations.of(context).getText(
              '0h907zlv' /* Không trả lời */,
            ),
            FFLocalizations.of(context).getText(
              'sv59ofep' /* Đếm tin đã xử lý thành công */,
            ),
            FFLocalizations.of(context).getText(
              '4t5c053r' /* Trích dẫn tin sau khi xử lý */,
            ),
            FFLocalizations.of(context).getText(
              'ahlbqhso' /* Trích dẫn nội dung nhận được */,
            )
          ],
          onChanged: (val) => context
              .read<ContactFormBloc>()
              .add(ContactFormReplyModeChanged(val!)),
          height: 50.0,
          textStyle: FlutterFlowTheme.of(context).bodyMedium,
          hintText: FFLocalizations.of(context).getText(
            'm5j9wm6l' /* Trả lời tin nhắn */,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: FlutterFlowTheme.of(context).alternate,
          borderWidth: 2.0,
          borderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
          hidesUnderline: true,
          isOverButton: true,
          isSearchable: false,
          isMultiSelect: false,
        );
      },
    );
  }
}
