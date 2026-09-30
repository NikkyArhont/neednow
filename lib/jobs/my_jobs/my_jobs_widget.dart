import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/new_job_button/new_job_button_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/empty_list_widget/emtpy_new_works/emtpy_new_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/my_job_card/my_job_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_jobs_model.dart';
export 'my_jobs_model.dart';

class MyJobsWidget extends StatefulWidget {
  const MyJobsWidget({super.key});

  static String routeName = 'myJobs';
  static String routePath = '/myJobs';

  @override
  State<MyJobsWidget> createState() => _MyJobsWidgetState();
}

class _MyJobsWidgetState extends State<MyJobsWidget> {
  late MyJobsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyJobsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
            Column(
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
                        EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.backbuttonModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: BackbuttonWidget(),
                        ),
                        Text(
                          'Мои ${FFAppState().choosenRoleWorker ? 'услуги' : 'заказы'}',
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                ))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(100.0, 40.0, 100.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wrapWithModel(
                          model: _model.backbuttonModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: BackbuttonWidget(),
                        ),
                        Text(
                          'Мои ${FFAppState().choosenRoleWorker ? 'услуги' : 'заказы'}',
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayMediumIsCustom,
                              ),
                        ),
                        if (FFAppState().choosenRoleWorker)
                          FFButtonWidget(
                            onPressed: () async {
                              if (FFAppState().choosenRoleWorker) {
                                context
                                    .pushNamed(CreateServiceWidget.routeName);
                              } else {
                                context.pushNamed(CreateOrderWidget.routeName);
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'smjwd1co' /* Создать услугу */,
                            ),
                            icon: Icon(
                              FFIcons.kadditionalIcons1,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleSmallIsCustom,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        if (!FFAppState().choosenRoleWorker)
                          AuthUserStreamWidget(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                if (FFAppState().choosenRoleWorker) {
                                  context
                                      .pushNamed(CreateServiceWidget.routeName);
                                } else {
                                  context
                                      .pushNamed(CreateOrderWidget.routeName);
                                }
                              },
                              text: valueOrDefault<bool>(
                                      currentUserDocument?.isWorker, false)
                                  ? FFLocalizations.of(context).getVariableText(
                                      ruText: 'Создать услугу',
                                      mnText: 'Үйлчилгээ үүсгэх',
                                    )
                                  : FFLocalizations.of(context).getVariableText(
                                      ruText: 'Создать заказ',
                                      mnText: 'Захиалга үүсгэх',
                                    ),
                              icon: Icon(
                                FFIcons.kadditionalIcons1,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleSmallIsCustom,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (FFAppState().choosenRoleWorker) {
                        return StreamBuilder<List<ServicesRecord>>(
                          stream: queryServicesRecord(
                            queryBuilder: (servicesRecord) =>
                                servicesRecord.where(
                              'who_create',
                              isEqualTo: currentUserReference,
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<ServicesRecord> listViewServicesRecordList =
                                snapshot.data!;
                            if (listViewServicesRecordList.isEmpty) {
                              return EmtpyNewWorksWidget();
                            }

                            return ListView.separated(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                12.0,
                                0,
                                80.0,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewServicesRecordList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.0),
                              itemBuilder: (context, listViewIndex) {
                                final listViewServicesRecord =
                                    listViewServicesRecordList[listViewIndex];
                                return Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          ServiceDetailsWidget.routeName,
                                          queryParameters: {
                                            'serviceDoc': serializeParam(
                                              listViewServicesRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'serviceDoc':
                                                listViewServicesRecord,
                                          },
                                        );
                                      },
                                      child: wrapWithModel(
                                        model: _model.myJobCardModels1.getModel(
                                          listViewServicesRecord.reference.id,
                                          listViewIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: MyJobCardWidget(
                                          key: Key(
                                            'Keyvp6_${listViewServicesRecord.reference.id}',
                                          ),
                                          titleCategory:
                                              functions.searchCatTitles(
                                                  FFAppState().saveCat.toList(),
                                                  listViewServicesRecord
                                                      .category!),
                                          jobTitle:
                                              listViewServicesRecord.title,
                                          jobPrice:
                                              listViewServicesRecord.price,
                                          sumOffers: listViewServicesRecord
                                              .responce.length,
                                          sumViews: listViewServicesRecord
                                              .views.length,
                                          jobStatus:
                                              listViewServicesRecord.status!,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return StreamBuilder<List<OrdersRecord>>(
                          stream: queryOrdersRecord(
                            queryBuilder: (ordersRecord) => ordersRecord.where(
                              'who_create',
                              isEqualTo: currentUserReference,
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<OrdersRecord> listViewOrdersRecordList =
                                snapshot.data!;
                            if (listViewOrdersRecordList.isEmpty) {
                              return EmtpyNewWorksWidget();
                            }

                            return ListView.separated(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                12.0,
                                0,
                                80.0,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewOrdersRecordList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.0),
                              itemBuilder: (context, listViewIndex) {
                                final listViewOrdersRecord =
                                    listViewOrdersRecordList[listViewIndex];
                                return Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          OrderDetailsWidget.routeName,
                                          queryParameters: {
                                            'orderDoc': serializeParam(
                                              listViewOrdersRecord,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'orderDoc': listViewOrdersRecord,
                                          },
                                        );
                                      },
                                      child: wrapWithModel(
                                        model: _model.myJobCardModels2.getModel(
                                          listViewOrdersRecord.reference.id,
                                          listViewIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: MyJobCardWidget(
                                          key: Key(
                                            'Key973_${listViewOrdersRecord.reference.id}',
                                          ),
                                          titleCategory:
                                              functions.searchCatTitles(
                                                  FFAppState().saveCat.toList(),
                                                  listViewOrdersRecord
                                                      .category!),
                                          jobTitle: listViewOrdersRecord.title,
                                          jobPrice: listViewOrdersRecord.price,
                                          sumOffers: listViewOrdersRecord
                                              .responces.length,
                                          sumViews:
                                              listViewOrdersRecord.views.length,
                                          jobStatus:
                                              listViewOrdersRecord.status!,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            if (responsiveVisibility(
              context: context,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(1.0, 1.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (FFAppState().choosenRoleWorker) {
                      context.pushNamed(CreateServiceWidget.routeName);
                    } else {
                      context.pushNamed(CreateOrderWidget.routeName);
                    }
                  },
                  child: wrapWithModel(
                    model: _model.newJobButtonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: NewJobButtonWidget(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
