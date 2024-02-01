import '/flutter_flow/flutter_flow_util.dart';
import 'add_contact_page.dart' show AddContactPage;
import 'package:flutter/material.dart';

import 'widgets/add-contact-info-and-rate/add_contact_info_and_rate_model.dart';
import 'widgets/add-contact-settings/add_contact_settings_widget.dart';

class AddContactModel extends FlutterFlowModel<AddContactPage> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for addContactInfoAndRate component.
  late AddContactInfoAndRateModel addContactInfoAndRateModel;
  // Model for addContactSettings component.
  late AddContactSettingsModel addContactSettingsModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    addContactInfoAndRateModel =
        createModel(context, () => AddContactInfoAndRateModel());
    addContactSettingsModel =
        createModel(context, () => AddContactSettingsModel());
  }

  void dispose() {
    tabBarController?.dispose();
    addContactInfoAndRateModel.dispose();
    addContactSettingsModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
