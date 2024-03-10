import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';

class AutoParseModeField extends HookWidget {
  const AutoParseModeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) =>
          previous.contact.autoParse != current.contact.autoParse,
      builder: (context, state) {
        return SwitchListTile.adaptive(
          value: true,
          onChanged: (newValue) => context
              .read<ContactFormBloc>()
              .add(ContactFormAutoParseChanged(newValue)),
          title: Text(
            FFLocalizations.of(context).getText(
              '0sm6ek1x' /* Phân tích tin đi, đến */,
            ),
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          subtitle: Text(
            FFLocalizations.of(context).getText(
              'w79u6jgx' /* Tự động phân tích */,
            ),
            style: FlutterFlowTheme.of(context).labelSmall,
          ),
          tileColor: FlutterFlowTheme.of(context).secondaryBackground,
          activeColor: FlutterFlowTheme.of(context).primary,
          activeTrackColor: FlutterFlowTheme.of(context).accent1,
          dense: false,
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding:
              const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      },
    );
  }
}
