import 'package:auto_route/auto_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:ld_app/flutter_flow/flutter_flow_animations.dart';
import 'package:ld_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:ld_app/src/application/contact/bloc/contact_form_bloc.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:motion_toast/motion_toast.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/contact_info_and_rate_tab.dart';
import 'widgets/contact_settings_tab.dart';

@RoutePage()
class ContactFormPage extends StatefulWidget {
  final String? chatId;
  final Contact? contact;
  const ContactFormPage({super.key, this.chatId, this.contact});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage>
    with TickerProviderStateMixin {
  late String? chatId = widget.chatId;
  late Contact? contact = widget.contact;
  late TabController tabBarController;
  final formKey = GlobalKey<FormState>();
  final animationsMap = {
    'buttonOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.bounceOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.bounceOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 40.0),
          end: const Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.bounceOut,
          delay: 500.ms,
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
          delay: 500.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.bounceOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 40.0),
          end: const Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.bounceOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: const Offset(1.0, 0.0),
          end: const Offset(1.0, 1.0),
        ),
      ],
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
    return BlocProvider(
      create: (BuildContext context) => ContactFormBloc(
          chatId != null ? fpdart.left(chatId!) : fpdart.right(contact!)),
      child: BlocConsumer<ContactFormBloc, ContactFormState>(
        builder: ((BuildContext context, ContactFormState state) => Stack(
              children: <Widget>[
                ContactFormScaffold(
                    scaffoldKey: scaffoldKey,
                    formKey: formKey,
                    tabBarController: tabBarController,
                    animationsMap: animationsMap),
                SavingInProgressOverlay(isSaving: state.isSaving)
              ],
            )),
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () {},
            (either) {
              either.fold(
                (ContactFailure failure) {
                  MotionToast.error(
                          title: const Text("Thông báo"),
                          description: Text(switch (failure) {
                            ContactCreatedFailure() =>
                              'Không thêm được liên hệ',
                            ContactUpdatedFailure() =>
                              'Không cập nhật được liên hệ',
                            // TODO: Handle this case.
                            ContactFailure() => 'Không xác định',
                          }))
                      .show(context);
                },
                (_) {
                  // Can't be just a simple pop. If another route (like a Flushbar) is on top of stack, we'll need to pop even that to get to
                  // the overview page.
                  context.router.popUntilRouteWithName('TelegramRoute');
                },
              );
            },
          );
        },
        listenWhen: (p, c) =>
            p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                'Lưu',
                // Not within a Scaffold. We have to get the TextStyle from a theme ourselves.
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactFormScaffold extends StatelessWidget {
  const ContactFormScaffold({
    super.key,
    required this.scaffoldKey,
    required this.formKey,
    required this.tabBarController,
    required this.animationsMap,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final TabController tabBarController;
  final Map<String, AnimationInfo> animationsMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: BlocBuilder<ContactFormBloc, ContactFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) {
            return Text(
              state.isEditing ? 'Sửa liên hệ' : 'Thêm liên hệ',
              style: FlutterFlowTheme.of(context).headlineSmall,
            );
          },
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: BlocBuilder<ContactFormBloc, ContactFormState>(
        buildWhen: (previous, current) =>
            previous.showErrorMessages != current.showErrorMessages,
        builder: (context, state) {
          return Form(
            key: formKey,
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
                    controller: tabBarController,
                    onTap: (i) async {
                      [() async {}, () async {}][i]();
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabBarController,
                    children: const [
                      UpsertContactInfoAndRateTab(),
                      ContactSettingsTab(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: BlocBuilder<ContactFormBloc, ContactFormState>(
                            builder: (context, state) {
                              return FFButtonWidget(
                                onPressed: () async {},
                                text: state.isSaving
                                    ? 'Sửa liên hệ'
                                    : 'Thêm liên hệ',
                                options: FFButtonOptions(
                                  width: 230.0,
                                  height: 50.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Lexend',
                                        color: FlutterFlowTheme.of(context)
                                            .textColor,
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              );
                            },
                          ).animateOnPageLoad(
                              animationsMap['buttonOnPageLoadAnimation1']!)),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {},
                          text: FFLocalizations.of(context).getText(
                            'ywv1bn35' /* Hủy */,
                          ),
                          options: FFButtonOptions(
                            width: 140.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Lexend',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['buttonOnPageLoadAnimation2']!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
