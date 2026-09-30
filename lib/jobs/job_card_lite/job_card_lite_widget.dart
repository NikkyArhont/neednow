import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'job_card_lite_model.dart';
export 'job_card_lite_model.dart';

class JobCardLiteWidget extends StatefulWidget {
  const JobCardLiteWidget({
    super.key,
    required this.userData,
    required this.price,
    required this.titleCategory,
    required this.orderCity,
    required this.jobTitle,
    this.servDoc,
    this.orderDoc,
  });

  final DocumentReference? userData;
  final int? price;
  final String? titleCategory;
  final String? orderCity;
  final String? jobTitle;
  final ServicesRecord? servDoc;
  final OrdersRecord? orderDoc;

  @override
  State<JobCardLiteWidget> createState() => _JobCardLiteWidgetState();
}

class _JobCardLiteWidgetState extends State<JobCardLiteWidget> {
  late JobCardLiteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobCardLiteModel());

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

    return Material(
      color: Colors.transparent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 840.0,
        constraints: BoxConstraints(
          minWidth: 240.0,
          maxWidth: 840.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (FFAppState().choosenRoleWorker) {
                if (() {
                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                    return true;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointMedium) {
                    return false;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointLarge) {
                    return false;
                  } else {
                    return false;
                  }
                }()) {
                  context.pushNamed(
                    OrderDetailsWidget.routeName,
                    queryParameters: {
                      'orderDoc': serializeParam(
                        widget!.orderDoc,
                        ParamType.Document,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      'orderDoc': widget!.orderDoc,
                    },
                  );
                } else {
                  context.pushNamed(
                    WebOrderDetailsWidget.routeName,
                    queryParameters: {
                      'orderDoc': serializeParam(
                        widget!.orderDoc,
                        ParamType.Document,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      'orderDoc': widget!.orderDoc,
                    },
                  );
                }
              } else {
                if (() {
                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                    return true;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointMedium) {
                    return false;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointLarge) {
                    return false;
                  } else {
                    return false;
                  }
                }()) {
                  context.pushNamed(
                    ServiceDetailsWidget.routeName,
                    queryParameters: {
                      'serviceDoc': serializeParam(
                        widget!.servDoc,
                        ParamType.Document,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      'serviceDoc': widget!.servDoc,
                    },
                  );
                } else {
                  context.pushNamed(
                    WebServiceDetailsWidget.routeName,
                    queryParameters: {
                      'serviceDoc': serializeParam(
                        widget!.servDoc,
                        ParamType.Document,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      'serviceDoc': widget!.servDoc,
                    },
                  );
                }
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                  child: StreamBuilder<UserRecord>(
                    stream: UserRecord.getDocument(widget!.userData!),
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

                      final userCardMiniUserRecord = snapshot.data!;

                      return wrapWithModel(
                        model: _model.userCardMiniModel,
                        updateCallback: () => safeSetState(() {}),
                        child: UserCardMiniWidget(
                          titleServOrder: widget!.jobTitle!,
                          avaURL: userCardMiniUserRecord.photoUrl,
                          lastAchiv: userCardMiniUserRecord.lastAchivment,
                          raiting: userCardMiniUserRecord.rating,
                          userName: userCardMiniUserRecord.displayName,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Wrap(
                            spacing: 2.0,
                            runSpacing: 2.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Text(
                                '${valueOrDefault<String>(
                                  widget!.orderCity,
                                  'Удаленно',
                                )}  -  ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: Color(0xFF757575),
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget!.titleCategory,
                                  'category',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: Color(0xFF757575),
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AutoSizeText(
                        '${formatNumber(
                          widget!.price,
                          formatType: FormatType.decimal,
                          decimalType: DecimalType.commaDecimal,
                        )} ${FFAppConstants.currency}',
                        maxLines: 1,
                        minFontSize: 10.0,
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
