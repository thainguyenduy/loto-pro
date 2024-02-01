import 'package:auto_route/auto_route.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_contact_model.dart';
import 'widgets/add-contact-info-and-rate/add_contact_info_and_rate_widget.dart';
import 'widgets/add-contact-settings/add_contact_settings_widget.dart';
export 'add_contact_model.dart';

@RoutePage()
class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage>
    with TickerProviderStateMixin {
  late AddContactModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddContactModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            'l8hgzapa' /* Thêm liên hệ */,
          ),
          style: FlutterFlowTheme.of(context).headlineSmall,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Align(
              alignment: const Alignment(0.0, 0),
              child: TabBar(
                labelColor: FlutterFlowTheme.of(context).primaryText,
                unselectedLabelColor:
                    FlutterFlowTheme.of(context).secondaryText,
                labelStyle: FlutterFlowTheme.of(context).titleMedium,
                unselectedLabelStyle: const TextStyle(),
                indicatorColor: FlutterFlowTheme.of(context).primary,
                padding: const EdgeInsets.all(4.0),
                tabs: [
                  Tab(
                    text: FFLocalizations.of(context).getText(
                      'isd1p2so' /* Số ĐT và giá */,
                    ),
                    icon: const Icon(
                      Icons.person_add_alt,
                    ),
                  ),
                  Tab(
                    text: FFLocalizations.of(context).getText(
                      '368j65no' /* Cấu hình riêng */,
                    ),
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                  ),
                ],
                controller: _model.tabBarController,
                onTap: (i) async {
                  [() async {}, () async {}][i]();
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _model.tabBarController,
                children: [
                  wrapWithModel(
                    model: _model.addContactInfoAndRateModel,
                    updateCallback: () => setState(() {}),
                    child: const AddContactInfoAndRateWidget(),
                  ),
                  wrapWithModel(
                    model: _model.addContactSettingsModel,
                    updateCallback: () => setState(() {}),
                    child: AddContactSettingsWidget(
                      parameter1: _model.addContactInfoAndRateModel
                          .contactNameController.text,
                      parameter2: _model.addContactInfoAndRateModel
                          .contactAliasController.text,
                      parameter3: _model
                          .addContactInfoAndRateModel.yourAliasController.text,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
