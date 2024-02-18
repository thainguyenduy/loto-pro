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

class ContactSettingsTab extends StatefulWidget {
  const ContactSettingsTab({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
  });

  final String? parameter1;
  final String? parameter2;
  final String? parameter3;

  @override
  State<ContactSettingsTab> createState() => _ContactSettingsTabState();
}

class _ContactSettingsTabState extends State<ContactSettingsTab>
    with TickerProviderStateMixin {
  late AddContactSettingsModel _model;

  final animationsMap = {
    'buttonOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 40.0),
          end: const Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(1.0, 0.0),
          end: const Offset(1.0, 1.0),
        ),
      ],
    ),
    'buttonOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 40.0),
          end: const Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.bounceOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: const Offset(1.0, 0.0),
          end: const Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddContactSettingsModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SwitchListTile.adaptive(
              value: _model.switchListTileValue1 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.switchListTileValue1 = newValue!);
              },
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
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController1 ??=
                    FormFieldController<String>(null),
                options: [
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
                onChanged: (val) => setState(() => _model.dropDownValue1 = val),
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
