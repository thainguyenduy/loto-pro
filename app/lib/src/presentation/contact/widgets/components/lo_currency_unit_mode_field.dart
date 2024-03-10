import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';

class LoCurrencyUnitIsThousandVNDField extends StatelessWidget {
  const LoCurrencyUnitIsThousandVNDField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) =>
          previous.contact.loCurrencyUnitAsThousandVND !=
          current.contact.loCurrencyUnitAsThousandVND,
      builder: (context, state) {
        return SwitchListTile.adaptive(
          value: state.contact.loCurrencyUnitAsThousandVND,
          onChanged: (newValue) async {
            context
                .read<ContactFormBloc>()
                .add(ContactFormLoCurrencyUnitIsThousandVNDChanged(newValue));
          },
          title: Text(
            FFLocalizations.of(context).getText(
              'y0b9iynm' /* Chấp nhận đơn vị lô là nghìn */,
            ),
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          subtitle: Text(
            FFLocalizations.of(context).getText(
              'oo4p7rrf' /* Chấp nhận */,
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
