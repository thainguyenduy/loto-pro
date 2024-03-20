import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_drop_down.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/form_field_controller.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/presentation/contact/bloc/contact_form_bloc.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';

class DebtReminderModeField extends StatelessWidget {
  const DebtReminderModeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) =>
          previous.contact.debtReminderMode.code !=
          current.contact.debtReminderMode.code,
      builder: (context, state) {
        var controller =
            FormFieldController<int>(state.contact.debtReminderMode.code);
        return FlutterFlowDropDown<int>(
          controller: controller,
          options: DebtReminderMode.values.map((e) => e.code).toList(),
          optionLabels: DebtReminderMode.values.map((e) => e.label).toList(),
          onChanged: (val) => context.read<ContactFormBloc>().add(
              ContactFormDebtReminderModeChanged(
                  DebtReminderMode.fromKey(val!))),
          height: 50.0,
          textStyle: FlutterFlowTheme.of(context).bodyMedium,
          hintText: FFLocalizations.of(context).getText(
            'mykbxw20' /* Báo kèm nợ cũ chi tiết */,
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
