import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_contact_info_and_rate_widget.dart' show AddContactInfoAndRateWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddContactInfoAndRateModel
    extends FlutterFlowModel<AddContactInfoAndRateWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for contactName widget.
  FocusNode? contactNameFocusNode;
  TextEditingController? contactNameController;
  String? Function(BuildContext, String?)? contactNameControllerValidator;
  // State field(s) for contactAlias widget.
  FocusNode? contactAliasFocusNode;
  TextEditingController? contactAliasController;
  String? Function(BuildContext, String?)? contactAliasControllerValidator;
  // State field(s) for yourAlias widget.
  FocusNode? yourAliasFocusNode;
  TextEditingController? yourAliasController;
  String? Function(BuildContext, String?)? yourAliasControllerValidator;
  // State field(s) for contactPhone widget.
  FocusNode? contactPhoneFocusNode;
  TextEditingController? contactPhoneController;
  String? Function(BuildContext, String?)? contactPhoneControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController11;
  String? Function(BuildContext, String?)? textController11Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController12;
  String? Function(BuildContext, String?)? textController12Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode9;
  TextEditingController? textController13;
  String? Function(BuildContext, String?)? textController13Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    contactNameFocusNode?.dispose();
    contactNameController?.dispose();

    contactAliasFocusNode?.dispose();
    contactAliasController?.dispose();

    yourAliasFocusNode?.dispose();
    yourAliasController?.dispose();

    contactPhoneFocusNode?.dispose();
    contactPhoneController?.dispose();

    textFieldFocusNode1?.dispose();
    textController5?.dispose();

    textFieldFocusNode2?.dispose();
    textController6?.dispose();

    textFieldFocusNode3?.dispose();
    textController7?.dispose();

    textFieldFocusNode4?.dispose();
    textController8?.dispose();

    textFieldFocusNode5?.dispose();
    textController9?.dispose();

    textFieldFocusNode6?.dispose();
    textController10?.dispose();

    textFieldFocusNode7?.dispose();
    textController11?.dispose();

    textFieldFocusNode8?.dispose();
    textController12?.dispose();

    textFieldFocusNode9?.dispose();
    textController13?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String? get radioButtonValue => radioButtonValueController?.value;
}
