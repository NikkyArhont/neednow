import '/app_components/menu/menu_widget.dart';
import '/app_components/top_avatar_nnotific/top_avatar_nnotific_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_new_works/emtpy_new_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/respond_card/respond_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'jobs_model.dart';
export 'jobs_model.dart';

class JobsWidget extends StatefulWidget {
  const JobsWidget({super.key});

  static String routeName = 'Jobs';
  static String routePath = '/jobs';

  @override
  State<JobsWidget> createState() => _JobsWidgetState();
}

class _JobsWidgetState extends State<JobsWidget> {
  late JobsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                    tabletLandscape: false,
                  ))
                    wrapWithModel(
                      model: _model.webMenuModel,
                      updateCallback: () => safeSetState(() {}),
                      child: WebMenuWidget(),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    desktop: false,
                  ))
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 0.0),
                      child: wrapWithModel(
                        model: _model.topAvatarNnotificModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TopAvatarNnotificWidget(),
                      ),
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FFButtonWidget(
                                  onPressed: (_model.choosenStatus == null)
                                      ? null
                                      : () async {
                                          _model.choosenStatus = null;
                                          safeSetState(() {});
                                        },
                                  text: FFLocalizations.of(context).getText(
                                    '7wt239h4' /* Все */,
                                  ),
                                  options: FFButtonOptions(
                                    height: 38.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleSmallIsCustom,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(100.0),
                                    disabledColor:
                                        FlutterFlowTheme.of(context).primary,
                                    disabledTextColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: (_model.choosenStatus ==
                                            ResponseType.confirmed)
                                        ? null
                                        : () async {
                                            _model.choosenStatus =
                                                ResponseType.confirmed;
                                            safeSetState(() {});
                                          },
                                    text: valueOrDefault<bool>(
                                            currentUserDocument?.isWorker,
                                            false)
                                        ? FFLocalizations.of(context)
                                            .getVariableText(
                                            ruText: 'Подтвержден',
                                            mnText: 'Батлагдсан',
                                          )
                                        : FFLocalizations.of(context)
                                            .getVariableText(
                                            ruText: 'Исполнитель подтвержден',
                                            mnText: 'Гүйцэтгэгч нь батлагдсан',
                                          ),
                                    options: FFButtonOptions(
                                      height: 38.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context).primary,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                    ),
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: (_model.choosenStatus ==
                                            ResponseType.denied)
                                        ? null
                                        : () async {
                                            _model.choosenStatus =
                                                ResponseType.denied;
                                            safeSetState(() {});
                                          },
                                    text: valueOrDefault<bool>(
                                            currentUserDocument?.isWorker,
                                            false)
                                        ? FFLocalizations.of(context)
                                            .getVariableText(
                                            ruText: 'Отклонен',
                                            mnText: 'Татгалзсан',
                                          )
                                        : FFLocalizations.of(context)
                                            .getVariableText(
                                            ruText: 'Исполнитель отклонен',
                                            mnText:
                                                'Жүжигчин татгалзсан байна.',
                                          ),
                                    options: FFButtonOptions(
                                      height: 38.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context).primary,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                    ),
                                  ),
                                ),
                                AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: (_model.choosenStatus ==
                                            ResponseType.offer)
                                        ? null
                                        : () async {
                                            _model.choosenStatus =
                                                ResponseType.offer;
                                            safeSetState(() {});
                                          },
                                    text: valueOrDefault<bool>(
                                            currentUserDocument?.isWorker,
                                            false)
                                        ? 'Отклик отправлен'
                                        : 'С откликом',
                                    options: FFButtonOptions(
                                      height: 38.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context).primary,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                    ),
                                  ),
                                ),
                              ]
                                  .divide(SizedBox(width: 12.0))
                                  .addToStart(SizedBox(width: 12.0))
                                  .addToEnd(SizedBox(width: 12.0)),
                            ),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (valueOrDefault<bool>(
                              currentUserDocument?.isWorker, false)) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              child: StreamBuilder<List<WorkRecord>>(
                                stream: queryWorkRecord(
                                  queryBuilder: (workRecord) => workRecord
                                      .where(
                                        'worker',
                                        isEqualTo: currentUserReference,
                                      )
                                      .orderBy('created_time'),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<WorkRecord> listViewWorkRecordList =
                                      snapshot.data!;
                                  if (listViewWorkRecordList.isEmpty) {
                                    return EmtpyNewWorksWidget();
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      12.0,
                                      0,
                                      0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewWorkRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 12.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewWorkRecord =
                                          listViewWorkRecordList[listViewIndex];
                                      return Visibility(
                                        visible: (_model.choosenStatus ==
                                                listViewWorkRecord
                                                    .workStatus) ||
                                            (_model.choosenStatus == null),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                WorkPageWidget.routeName,
                                                queryParameters: {
                                                  'workRef': serializeParam(
                                                    listViewWorkRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: wrapWithModel(
                                              model: _model.respondCardModels1
                                                  .getModel(
                                                listViewWorkRecord.reference.id,
                                                listViewIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: RespondCardWidget(
                                                key: Key(
                                                  'Key1ff_${listViewWorkRecord.reference.id}',
                                                ),
                                                respondStatus:
                                                    listViewWorkRecord
                                                        .workStatus!,
                                                userData:
                                                    listViewWorkRecord.client!,
                                                orderTitle: listViewWorkRecord
                                                    .workTitle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              child: StreamBuilder<List<WorkRecord>>(
                                stream: queryWorkRecord(
                                  queryBuilder: (workRecord) => workRecord
                                      .where(
                                        'client',
                                        isEqualTo: currentUserReference,
                                      )
                                      .orderBy('created_time'),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<WorkRecord> listViewWorkRecordList =
                                      snapshot.data!;
                                  if (listViewWorkRecordList.isEmpty) {
                                    return EmtpyNewWorksWidget();
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      12.0,
                                      0,
                                      0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewWorkRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 12.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewWorkRecord =
                                          listViewWorkRecordList[listViewIndex];
                                      return Visibility(
                                        visible: (_model.choosenStatus ==
                                                listViewWorkRecord
                                                    .workStatus) ||
                                            (_model.choosenStatus == null),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                WorkPageWidget.routeName,
                                                queryParameters: {
                                                  'workRef': serializeParam(
                                                    listViewWorkRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: wrapWithModel(
                                              model: _model.respondCardModels2
                                                  .getModel(
                                                listViewWorkRecord.reference.id,
                                                listViewIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: RespondCardWidget(
                                                key: Key(
                                                  'Key4ai_${listViewWorkRecord.reference.id}',
                                                ),
                                                respondStatus:
                                                    listViewWorkRecord
                                                        .workStatus!,
                                                userData:
                                                    listViewWorkRecord.client!,
                                                orderTitle: listViewWorkRecord
                                                    .workTitle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ]
                    .divide(SizedBox(height: 24.0))
                    .addToEnd(SizedBox(height: 100.0)),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.menuModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MenuWidget(
                    currentPage: CurrentPage.orders,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
