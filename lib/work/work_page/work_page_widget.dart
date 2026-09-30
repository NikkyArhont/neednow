import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/safe_fact_deal/safe_fact_deal_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/respond_card/respond_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/work/debate_menu/debate_menu_widget.dart';
import '/work/modal_wind_complete_wrk/modal_wind_complete_wrk_widget.dart';
import '/work/modal_wind_done_work/modal_wind_done_work_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'work_page_model.dart';
export 'work_page_model.dart';

class WorkPageWidget extends StatefulWidget {
  const WorkPageWidget({
    super.key,
    required this.workRef,
  });

  final DocumentReference? workRef;

  static String routeName = 'workPage';
  static String routePath = '/workPage';

  @override
  State<WorkPageWidget> createState() => _WorkPageWidgetState();
}

class _WorkPageWidgetState extends State<WorkPageWidget> {
  late WorkPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WorkPageModel());

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

    return StreamBuilder<WorkRecord>(
      stream: WorkRecord.getDocument(widget!.workRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final workPageWorkRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: FutureBuilder<OrdersRecord>(
              future: OrdersRecord.getDocumentOnce(workPageWorkRecord.order!),
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

                final containerOrdersRecord = snapshot.data!;

                return Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: wrapWithModel(
                                    model: _model.titlewithbackModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TitlewithbackWidget(
                                      title:
                                          FFLocalizations.of(context).getText(
                                        'x9k36eg0' /* Заказ */,
                                      ),
                                    ),
                                  ),
                                ),
                                if (workPageWorkRecord.debateStatus ==
                                    DebateStatus.notStart)
                                  Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        FFIcons.kmoreCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: false,
                                          avoidOverflow: true,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  1.0, -1.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: DebateMenuWidget(
                                                  workDoc: workPageWorkRecord,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                        ))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                100.0, 0.0, 100.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wrapWithModel(
                                  model: _model.backbuttonModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BackbuttonWidget(),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'mvvc7siu' /* Заказ */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displayMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .displayMediumIsCustom,
                                      ),
                                ),
                                if ((workPageWorkRecord.debateStatus ==
                                        DebateStatus.notStart) &&
                                    (workPageWorkRecord.workStatus ==
                                        ResponseType.confirmed))
                                  Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        FFIcons.kmoreCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: false,
                                          avoidOverflow: true,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  1.0, -1.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: DebateMenuWidget(
                                                  workDoc: workPageWorkRecord,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
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
                                    containerOrdersRecord,
                                    ParamType.Document,
                                  ),
                                  'offerdWork': serializeParam(
                                    true,
                                    ParamType.bool,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'orderDoc': containerOrdersRecord,
                                },
                              );
                            },
                            child: wrapWithModel(
                              model: _model.respondCardModel,
                              updateCallback: () => safeSetState(() {}),
                              child: RespondCardWidget(
                                orderTitle: workPageWorkRecord.workTitle,
                                userData: workPageWorkRecord.client!,
                                respondStatus: workPageWorkRecord.workStatus!,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 800.0,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'rhnt4kqz' /* Стоимость */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF424242),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          '${containerOrdersRecord.price.toString()} ${FFAppConstants.currency}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'lw5caezd' /* Специализация */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF424242),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          functions.searchCatTitles(
                                              FFAppState().saveCat.toList(),
                                              containerOrdersRecord.category!),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'knpy7dz2' /* Локация */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF424242),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          containerOrdersRecord.locationTitle,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'hj70z6ch' /* Срок выполнения */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color: Color(0xFF424242),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          '${containerOrdersRecord.deadLine.toString()} дней',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                              if (workPageWorkRecord.workStatus !=
                                  ResponseType.done)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: FutureBuilder<ChatsRecord>(
                                    future: ChatsRecord.getDocumentOnce(
                                        workPageWorkRecord.workChat!),
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

                                      final buttonChatsRecord = snapshot.data!;

                                      return FFButtonWidget(
                                        onPressed: () async {
                                          if (() {
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return true;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return false;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointLarge) {
                                              return false;
                                            } else {
                                              return false;
                                            }
                                          }()) {
                                            context.pushNamed(
                                              ChatWindowWidget.routeName,
                                              queryParameters: {
                                                'chatDoc': serializeParam(
                                                  buttonChatsRecord,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'chatDoc': buttonChatsRecord,
                                              },
                                            );
                                          } else {
                                            context.pushNamed(
                                              WebChatsWidget.routeName,
                                              queryParameters: {
                                                'choosenChat': serializeParam(
                                                  buttonChatsRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          }
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'en7811ql' /* Чат по заказу */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 360.0,
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .override(
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
                                      );
                                    },
                                  ),
                                ),
                              Builder(
                                builder: (context) {
                                  final responces = workPageWorkRecord
                                      .historyResponces
                                      .toList();

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: responces.length,
                                    itemBuilder: (context, responcesIndex) {
                                      final responcesItem =
                                          responces[responcesIndex];
                                      return FutureBuilder<ResponceRecord>(
                                        future: ResponceRecord.getDocumentOnce(
                                            responcesItem),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          final containerResponceRecord =
                                              snapshot.data!;

                                          return Container(
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Divider(
                                                    thickness: 1.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                  ),
                                                  Text(
                                                    () {
                                                      if (containerResponceRecord
                                                              .respOffer ==
                                                          OfferType
                                                              .formClient) {
                                                        return 'Предложение';
                                                      } else if (containerResponceRecord
                                                              .respOffer ==
                                                          OfferType
                                                              .fromWorker) {
                                                        return 'Отклик';
                                                      } else if (containerResponceRecord
                                                              .respOffer ==
                                                          OfferType.agreed) {
                                                        return 'Подтверждение';
                                                      } else {
                                                        return 'Отклонение';
                                                      }
                                                    }(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLargeFamily,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineLargeIsCustom,
                                                        ),
                                                  ),
                                                  FutureBuilder<UserRecord>(
                                                    future: UserRecord
                                                        .getDocumentOnce(
                                                            containerResponceRecord
                                                                .respSender!),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      final rowUserRecord =
                                                          snapshot.data!;

                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          AvatarMiniWidget(
                                                            key: Key(
                                                                'Keykl7_${responcesIndex}_of_${responces.length}'),
                                                            sizeAva: 54,
                                                            sizeLetter: 48,
                                                            avaURL:
                                                                rowUserRecord
                                                                    .photoUrl,
                                                            nameLetter:
                                                                rowUserRecord
                                                                    .displayName,
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                rowUserRecord
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .titleMediumIsCustom,
                                                                    ),
                                                              ),
                                                              Text(
                                                                rowUserRecord
                                                                        .isWorker
                                                                    ? 'Исполнитель'
                                                                    : 'Заказчик',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 8.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      );
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 40.0,
                                                        child: VerticalDivider(
                                                          thickness: 2.0,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          containerResponceRecord
                                                              .respLetter,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if ((containerResponceRecord
                                                                  .respPrice !=
                                                              null) &&
                                                          (containerResponceRecord
                                                                  .respPrice !=
                                                              0))
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ogr1kyi4' /* Стоимость */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${containerResponceRecord.respPrice.toString()} ${FFAppConstants.currency}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      if ((containerResponceRecord
                                                                  .respDeadline !=
                                                              null) &&
                                                          (containerResponceRecord
                                                                  .respDeadline !=
                                                              0))
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'gxrv4gfl' /* Срок выполнения */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '${containerResponceRecord.respDeadline.toString()}${FFLocalizations.of(context).getVariableText(
                                                                ruText: ' дней',
                                                                mnText:
                                                                    ' өдрүүд',
                                                              )}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              if ((workPageWorkRecord.workStatus !=
                                      ResponseType.offer) &&
                                  (workPageWorkRecord.workStatus !=
                                      ResponseType.denied))
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            thickness: 1.0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'wxxuvxfk' /* Детали заказа */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLargeFamily,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLargeIsCustom,
                                                ),
                                          ),
                                          FutureBuilder<UserRecord>(
                                            future: UserRecord.getDocumentOnce(
                                                workPageWorkRecord.client!),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              final rowUserRecord =
                                                  snapshot.data!;

                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  wrapWithModel(
                                                    model:
                                                        _model.avatarMiniModel2,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: AvatarMiniWidget(
                                                      sizeAva: 54,
                                                      sizeLetter: 48,
                                                      avaURL: rowUserRecord
                                                          .photoUrl,
                                                      nameLetter: rowUserRecord
                                                          .displayName,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        rowUserRecord
                                                            .displayName,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMediumIsCustom,
                                                                ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '81w8srd1' /* Заказчик */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              );
                                            },
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'r14eg9ot' /* Стоимость */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      '${formatNumber(
                                                        workPageWorkRecord
                                                            .agreedPrice,
                                                        formatType:
                                                            FormatType.decimal,
                                                        decimalType: DecimalType
                                                            .commaDecimal,
                                                      )} ${FFAppConstants.currency}',
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '0moxt4ms' /* Дата окончания */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      dateTimeFormat(
                                                        "dd.MM.yy",
                                                        workPageWorkRecord
                                                            .finishedTime,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          Wrap(
                                            spacing: 0.0,
                                            runSpacing: 0.0,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            direction: Axis.horizontal,
                                            runAlignment: WrapAlignment.start,
                                            verticalDirection:
                                                VerticalDirection.down,
                                            clipBehavior: Clip.none,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ksrugcoe' /* Способ оплаты */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                              wrapWithModel(
                                                model: _model.safeFactDealModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: SafeFactDealWidget(
                                                  safeDeal: workPageWorkRecord
                                                      .safeDeal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (valueOrDefault<bool>(
                                currentUserDocument?.isWorker, false)) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (workPageWorkRecord.workStatus ==
                                      ResponseType.confirmed)
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: (workPageWorkRecord
                                                      .workStatus !=
                                                  ResponseType.confirmed)
                                              ? null
                                              : () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              ModalWindCompleteWrkWidget(
                                                            client:
                                                                workPageWorkRecord
                                                                    .client!,
                                                            work: widget!
                                                                .workRef!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                          text: workPageWorkRecord.workStatus ==
                                                  ResponseType.confirmed
                                              ? FFLocalizations.of(context)
                                                  .getVariableText(
                                                  ruText:
                                                      'Запросить завершение',
                                                  mnText: 'Хүсэлт бөглөх',
                                                )
                                              : FFLocalizations.of(context)
                                                  .getVariableText(
                                                  ruText:
                                                      'Ждем подтверждение...',
                                                  mnText:
                                                      'Баталгаажуулахыг хүлээж байна...',
                                                ),
                                          options: FFButtonOptions(
                                            width: 360.0,
                                            height: 58.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'involve',
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(100.0),
                                              bottomRight:
                                                  Radius.circular(100.0),
                                              topLeft: Radius.circular(100.0),
                                              topRight: Radius.circular(100.0),
                                            ),
                                            disabledColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((workPageWorkRecord.workStatus ==
                                          ResponseType.offer) &&
                                      workPageWorkRecord.byOffer)
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // respondAgreed

                                            var responceRecordReference =
                                                ResponceRecord.collection.doc();
                                            await responceRecordReference
                                                .set(createResponceRecordData(
                                              respSender: currentUserReference,
                                              respReciver:
                                                  workPageWorkRecord.client,
                                              newResponce: true,
                                              respLetter:
                                                  'Исполнитель отказался от работы',
                                              respOffer: OfferType.denied,
                                            ));
                                            _model.respondAgreedCopy =
                                                ResponceRecord
                                                    .getDocumentFromData(
                                                        createResponceRecordData(
                                                          respSender:
                                                              currentUserReference,
                                                          respReciver:
                                                              workPageWorkRecord
                                                                  .client,
                                                          newResponce: true,
                                                          respLetter:
                                                              'Исполнитель отказался от работы',
                                                          respOffer:
                                                              OfferType.denied,
                                                        ),
                                                        responceRecordReference);
                                            // deniedNotific

                                            var notificationsRecordReference =
                                                NotificationsRecord.collection
                                                    .doc();
                                            await notificationsRecordReference
                                                .set({
                                              ...createNotificationsRecordData(
                                                whosNotification:
                                                    workPageWorkRecord.client,
                                                title: 'Отклик отклонен',
                                                letter:
                                                    '${FFLocalizations.of(context).getVariableText(
                                                  ruText:
                                                      'Исполнитель отказался от заказа ',
                                                  mnText:
                                                      'Гүйцэтгэгч захиалгаас татгалзсан',
                                                )}${workPageWorkRecord.workTitle}',
                                                unRead: true,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'timeStapm': FieldValue
                                                      .serverTimestamp(),
                                                },
                                              ),
                                            });
                                            _model.agreedNotific =
                                                NotificationsRecord
                                                    .getDocumentFromData({
                                              ...createNotificationsRecordData(
                                                whosNotification:
                                                    workPageWorkRecord.client,
                                                title: 'Отклик отклонен',
                                                letter:
                                                    '${FFLocalizations.of(context).getVariableText(
                                                  ruText:
                                                      'Исполнитель отказался от заказа ',
                                                  mnText:
                                                      'Гүйцэтгэгч захиалгаас татгалзсан',
                                                )}${workPageWorkRecord.workTitle}',
                                                unRead: true,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'timeStapm': DateTime.now(),
                                                },
                                              ),
                                            }, notificationsRecordReference);
                                            // updateWork

                                            await workPageWorkRecord.reference
                                                .update({
                                              ...createWorkRecordData(
                                                workStatus: ResponseType.denied,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'history_responces':
                                                      FieldValue.arrayUnion([
                                                    _model.respondAgreedCopy
                                                        ?.reference
                                                  ]),
                                                },
                                              ),
                                            });

                                            await workPageWorkRecord.client!
                                                .update({
                                              ...createUserRecordData(
                                                hasNewNot: true,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'myNotifications':
                                                      FieldValue.arrayUnion([
                                                    _model.agreedNotific
                                                        ?.reference
                                                  ]),
                                                },
                                              ),
                                            });

                                            context
                                                .goNamed(MainWidget.routeName);

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'v7m8stfw' /* Отклонить */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 360.0,
                                            height: 58.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFE9F0FF),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'involve',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(100.0),
                                              bottomRight:
                                                  Radius.circular(100.0),
                                              topLeft: Radius.circular(100.0),
                                              topRight: Radius.circular(100.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                GetOrderWidget.routeName,
                                                queryParameters: {
                                                  'orderRef': serializeParam(
                                                    containerOrdersRecord,
                                                    ParamType.Document,
                                                  ),
                                                  'byOffer': serializeParam(
                                                    workPageWorkRecord,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'orderRef':
                                                      containerOrdersRecord,
                                                  'byOffer': workPageWorkRecord,
                                                },
                                              );
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              '1gi8yhp4' /* Откликнуться */,
                                            ),
                                            options: FFButtonOptions(
                                              width: 360.0,
                                              height: 58.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily: 'involve',
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 0.0,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(100.0),
                                                bottomRight:
                                                    Radius.circular(100.0),
                                                topLeft: Radius.circular(100.0),
                                                topRight:
                                                    Radius.circular(100.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                ],
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (workPageWorkRecord.workStatus ==
                                      ResponseType.workComplete)
                                    Builder(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child:
                                                      ModalWindDoneWorkWidget(
                                                    worker: workPageWorkRecord
                                                        .worker!,
                                                    work: workPageWorkRecord,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          '0tpp78lg' /* Подтвердить завершение */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 360.0,
                                          height: 58.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .override(
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
                                    ),
                                  if ((workPageWorkRecord.workStatus ==
                                          ResponseType.offer) &&
                                      !workPageWorkRecord.byOffer)
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              DeniedWorkerWidget.routeName,
                                              queryParameters: {
                                                'workDoc': serializeParam(
                                                  workPageWorkRecord,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'workDoc': workPageWorkRecord,
                                              },
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'uf6st8hq' /* Отклонить */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 360.0,
                                            height: 58.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFE9F0FF),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'involve',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(100.0),
                                              bottomRight:
                                                  Radius.circular(100.0),
                                              topLeft: Radius.circular(100.0),
                                              topRight: Radius.circular(100.0),
                                            ),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              ApprovedWorkerWidget.routeName,
                                              queryParameters: {
                                                'workDoc': serializeParam(
                                                  workPageWorkRecord,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'workDoc': workPageWorkRecord,
                                              },
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '87lhm8cd' /* Подтвердить */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 360.0,
                                            height: 58.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily: 'involve',
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(100.0),
                                              bottomRight:
                                                  Radius.circular(100.0),
                                              topLeft: Radius.circular(100.0),
                                              topRight: Radius.circular(100.0),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                        if ((workPageWorkRecord.workStatus ==
                                ResponseType.done) &&
                            ((valueOrDefault<bool>(
                                        currentUserDocument?.isWorker, false) &&
                                    !workPageWorkRecord.reviewFromWorker) ||
                                (!valueOrDefault<bool>(
                                        currentUserDocument?.isWorker, false) &&
                                    !workPageWorkRecord.reviewFromClient)))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    TakeReviewWidget.routeName,
                                    queryParameters: {
                                      'reviewReciver': serializeParam(
                                        valueOrDefault<bool>(
                                                currentUserDocument?.isWorker,
                                                false)
                                            ? workPageWorkRecord.client
                                            : workPageWorkRecord.worker,
                                        ParamType.DocumentReference,
                                      ),
                                      'workReview': serializeParam(
                                        widget!.workRef,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: valueOrDefault<bool>(
                                        currentUserDocument?.isWorker, false)
                                    ? FFLocalizations.of(context)
                                        .getVariableText(
                                        ruText: 'Оценить заказчика',
                                        mnText: 'Үйлчлүүлэгчийг үнэл',
                                      )
                                    : FFLocalizations.of(context)
                                        .getVariableText(
                                        ruText: 'Оценить исполнителя',
                                        mnText: 'Уран бүтээлчийг үнэл',
                                      ),
                                options: FFButtonOptions(
                                  width: 360.0,
                                  height: 58.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
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
                            ),
                          ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 40.0))
                          .addToEnd(SizedBox(height: 40.0)),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
