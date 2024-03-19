import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ld_app/flutter_flow/internationalization.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';

class RejectedOvertimeBetField extends StatelessWidget {
  const RejectedOvertimeBetField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      builder: (context, state) {
        return SwitchListTile.adaptive(
                  value: state.contact.rejectedOvertimeBet,
                  onChanged: (newValue) => context.read<ContactFormBloc>().add(ContactFormRejectedOvertimeBetChanged(newValue)),
                  title: Text(
                    FFLocalizations.of(context).getText(
                      '0ue8fyj4' /* Trả lại tin nhắn khi quá giờ n... */,
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                  subtitle: Text(
                    FFLocalizations.of(context).getText(
                      'a594bvka' /* Tự động */,
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