import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/backbutton/backbutton_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'review_with_jobs_model.dart';
export 'review_with_jobs_model.dart';

class ReviewWithJobsWidget extends StatefulWidget {
  const ReviewWithJobsWidget({
    super.key,
    required this.whosReview,
  });

  final UserRecord? whosReview;

  static String routeName = 'reviewWithJobs';
  static String routePath = '/reviewWithJobs';

  @override
  State<ReviewWithJobsWidget> createState() => _ReviewWithJobsWidgetState();
}

class _ReviewWithJobsWidgetState extends State<ReviewWithJobsWidget> {
  late ReviewWithJobsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewWithJobsModel());

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: wrapWithModel(
                        model: _model.backbuttonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BackbuttonWidget(),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.avatarMiniModel,
                                updateCallback: () => safeSetState(() {}),
                                child: AvatarMiniWidget(
                                  sizeAva: 92,
                                  sizeLetter: 72,
                                  avaURL: widget!.whosReview?.photoUrl,
                                  nameLetter: widget!.whosReview!.displayName,
                                ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget!.whosReview?.displayName,
                                  'noName',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineLargeFamily,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineLargeIsCustom,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget!.whosReview?.city,
                                  'noCity',
                                ),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_half,
                                    color: FlutterFlowTheme.of(context).warning,
                                    size: 20.0,
                                  ),
                                  Text(
                                    formatNumber(
                                      widget!.whosReview!.rating,
                                      formatType: FormatType.custom,
                                      format: '#.0',
                                      locale: '',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                  Text(
                                    '(${formatNumber(
                                      widget!.whosReview?.reviews?.length,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.commaDecimal,
                                    )})',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        ReviewsWidget.routeName,
                                        queryParameters: {
                                          'whosReveiws': serializeParam(
                                            widget!.whosReview?.reference,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'k4n3c2af' /* Отзывы */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      constraints: BoxConstraints(
                        minWidth: 600.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (!widget!.whosReview!.isWorker) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ua2ledqa' /* Заказы */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineLargeFamily,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineLargeIsCustom,
                                        ),
                                  ),
                                ),
                                FutureBuilder<List<ServicesRecord>>(
                                  future: queryServicesRecordOnce(
                                    queryBuilder: (servicesRecord) =>
                                        servicesRecord.where(
                                      'who_create',
                                      isEqualTo: widget!.whosReview?.reference,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ServicesRecord>
                                        listViewServicesRecordList =
                                        snapshot.data!;

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        12.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewServicesRecordList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewServicesRecord =
                                            listViewServicesRecordList[
                                                listViewIndex];
                                        return Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
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
                                              model: _model.jobCardLiteModels1
                                                  .getModel(
                                                listViewServicesRecord
                                                    .reference.id,
                                                listViewIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: JobCardLiteWidget(
                                                key: Key(
                                                  'Keyi7a_${listViewServicesRecord.reference.id}',
                                                ),
                                                price: listViewServicesRecord
                                                    .price,
                                                titleCategory:
                                                    functions.searchCatTitles(
                                                        FFAppState()
                                                            .saveCat
                                                            .toList(),
                                                        listViewServicesRecord
                                                            .category!),
                                                orderCity:
                                                    listViewServicesRecord
                                                        .locationTitle,
                                                userData: widget!
                                                    .whosReview!.reference,
                                                jobTitle: listViewServicesRecord
                                                    .title,
                                                servDoc: listViewServicesRecord,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'p6pc6yya' /* Заказы */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineLargeFamily,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineLargeIsCustom,
                                      ),
                                ),
                                FutureBuilder<List<OrdersRecord>>(
                                  future: queryOrdersRecordOnce(
                                    queryBuilder: (ordersRecord) =>
                                        ordersRecord.where(
                                      'who_create',
                                      isEqualTo: widget!.whosReview?.reference,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<OrdersRecord>
                                        listViewOrdersRecordList =
                                        snapshot.data!;

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        12.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewOrdersRecordList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewOrdersRecord =
                                            listViewOrdersRecordList[
                                                listViewIndex];
                                        return Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
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
                                                  'orderDoc':
                                                      listViewOrdersRecord,
                                                },
                                              );
                                            },
                                            child: wrapWithModel(
                                              model: _model.jobCardLiteModels2
                                                  .getModel(
                                                listViewOrdersRecord
                                                    .reference.id,
                                                listViewIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: JobCardLiteWidget(
                                                key: Key(
                                                  'Keyocv_${listViewOrdersRecord.reference.id}',
                                                ),
                                                price:
                                                    listViewOrdersRecord.price,
                                                titleCategory:
                                                    functions.searchCatTitles(
                                                        FFAppState()
                                                            .saveCat
                                                            .toList(),
                                                        listViewOrdersRecord
                                                            .category!),
                                                orderCity: listViewOrdersRecord
                                                    .locationTitle,
                                                userData: widget!
                                                    .whosReview!.reference,
                                                jobTitle:
                                                    listViewOrdersRecord.title,
                                                orderDoc: listViewOrdersRecord,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            );
                          }
                        },
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
