import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bot_shet_choose_role_model.dart';
export 'bot_shet_choose_role_model.dart';

class BotShetChooseRoleWidget extends StatefulWidget {
  const BotShetChooseRoleWidget({super.key});

  @override
  State<BotShetChooseRoleWidget> createState() =>
      _BotShetChooseRoleWidgetState();
}

class _BotShetChooseRoleWidgetState extends State<BotShetChooseRoleWidget> {
  late BotShetChooseRoleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BotShetChooseRoleModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.chosWorker = FFAppState().choosenRoleWorker;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 573.0,
      constraints: BoxConstraints(
        maxWidth: 500.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(44.0),
          topRight: Radius.circular(44.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                '8piajll2' /* Выберите роль */,
              ),
              style: FlutterFlowTheme.of(context).displayMedium.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).displayMediumFamily,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).displayMediumIsCustom,
                  ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'o9bomrpt' /* Чтобы мы могли предложить Вам ... */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).titleMediumIsCustom,
                  ),
            ),
            Divider(
              thickness: 0.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.chosWorker = true;
                      safeSetState(() {});
                    },
                    child: Container(
                      height: 248.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: _model.chosWorker!
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).primaryBackground,
                          width: 3.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 100.0,
                              buttonSize: 100.0,
                              fillColor: Color(0x14246BFD),
                              icon: Icon(
                                FFIcons.kwork2,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 32.0,
                              ),
                              onPressed: () async {
                                _model.chosWorker = true;
                                safeSetState(() {});
                              },
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'x33wao77' /* Исполнитель */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelLargeIsCustom,
                                  ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'xacadwfr' /* Ищу заказы для выполнения */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.chosWorker = false;
                      safeSetState(() {});
                    },
                    child: Container(
                      height: 248.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: _model.chosWorker!
                              ? Color(0x00000000)
                              : Colors.orange,
                          width: 3.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 100.0,
                              buttonSize: 100.0,
                              fillColor: Color(0x15FF9800),
                              icon: Icon(
                                FFIcons.kprofile,
                                color: Colors.orange,
                                size: 32.0,
                              ),
                              onPressed: () async {
                                _model.chosWorker = false;
                                safeSetState(() {});
                              },
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'ja2pwexa' /* Заказчик */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelLargeIsCustom,
                                  ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                '6x0g6ix6' /* Ищу исполнителей для заказов */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
            FFButtonWidget(
              onPressed: () async {
                if (loggedIn) {
                  FFAppState().choosenRoleWorker = _model.chosWorker!;
                  FFAppState().update(() {});

                  await currentUserReference!.update(createUserRecordData(
                    isWorker: FFAppState().choosenRoleWorker,
                  ));

                  context.goNamed(MainWidget.routeName);

                  Navigator.pop(context);
                  FFAppState().mainFilter =
                      FilterDataStruct.fromSerializableMap(jsonDecode(
                          '{\"userPoint\":\"0.0,0.0\",\"categories\":\"[]\"}'));
                  FFAppState().update(() {});
                } else {
                  context.goNamed(MainWidget.routeName);

                  FFAppState().choosenRoleWorker = _model.chosWorker!;
                  FFAppState().update(() {});
                  Navigator.pop(context);
                  FFAppState().mainFilter =
                      FilterDataStruct.fromSerializableMap(jsonDecode(
                          '{\"userPoint\":\"0.0,0.0\",\"categories\":\"[]\"}'));
                  FFAppState().update(() {});
                }
              },
              text: FFLocalizations.of(context).getText(
                'jskxjr6n' /* Применить */,
              ),
              options: FFButtonOptions(
                width: 360.0,
                height: 58.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: 'involve',
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                ),
              ),
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
