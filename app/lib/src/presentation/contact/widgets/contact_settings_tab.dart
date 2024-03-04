import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add-contact-settings/add_contact_settings_model.dart';
export 'add-contact-settings/add_contact_settings_model.dart';

class ContactSettingsTab extends StatelessWidget {
  const ContactSettingsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: ,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController2 ??=
                    FormFieldController<String>(null),
                options: [
                  FFLocalizations.of(context).getText(
                    'mykbxw20' /* Báo kèm nợ củ chi tiết */,
                  )
                ],
                onChanged: (val) => setState(() => _model.dropDownValue2 = val),
                height: 50.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                hintText: FFLocalizations.of(context).getText(
                  'ppl0kb88' /* Kiểu báo công nợ */,
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
                margin:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isOverButton: true,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController3 ??=
                    FormFieldController<String>(null),
                options: [
                  FFLocalizations.of(context).getText(
                    'el0icnkl' /* Hệ số = 1 (1 ăn 70) */,
                  )
                ],
                onChanged: (val) => setState(() => _model.dropDownValue3 = val),
                height: 50.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                hintText: FFLocalizations.of(context).getText(
                  'sor9hkjq' /* Chuyển đề 7-8 */,
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
                margin:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isOverButton: true,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            SwitchListTile.adaptive(
              value: _model.switchListTileValue2 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.switchListTileValue2 = newValue!);
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
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController4 ??=
                    FormFieldController<String>(null),
                options: [
                  FFLocalizations.of(context).getText(
                    'js58mgmu' /* Chỉ chấp nhận đề tính bằng ngh... */,
                  )
                ],
                onChanged: (val) => setState(() => _model.dropDownValue4 = val),
                height: 50.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                hintText: FFLocalizations.of(context).getText(
                  '85m88tkv' /* Đơn vị tính đề */,
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
                margin:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isOverButton: true,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            SwitchListTile.adaptive(
              value: _model.switchListTileValue3 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.switchListTileValue3 = newValue!);
              },
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
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: SwitchListTile.adaptive(
                value: _model.switchListTileValue4 ??= true,
                onChanged: (newValue) async {
                  setState(() => _model.switchListTileValue4 = newValue!);
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    'ghl3ylns' /* Giới hạn nhận/1 số */,
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium,
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
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: SwitchListTile.adaptive(
                value: _model.switchListTileValue5 ??= true,
                onChanged: (newValue) async {
                  setState(() => _model.switchListTileValue5 = newValue!);
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    'joemmele' /* Khách giữ lại % cổ phần */,
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium,
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
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: SwitchListTile.adaptive(
                value: _model.switchListTileValue6 ??= true,
                onChanged: (newValue) async {
                  setState(() => _model.switchListTileValue6 = newValue!);
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    '67saz10b' /* Tự động chuyển đi tin đến */,
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                subtitle: Text(
                  FFLocalizations.of(context).getText(
                    'xcvlj456' /* Từ 15h đến 18h45 */,
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
              ),
            ),
          ].addToEnd(const SizedBox(height: 30.0)),
        ),
      ),
    );
  }
}
