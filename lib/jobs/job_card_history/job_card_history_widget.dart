import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'job_card_history_model.dart';
export 'job_card_history_model.dart';

class JobCardHistoryWidget extends StatefulWidget {
  const JobCardHistoryWidget({
    super.key,
    required this.userData,
    required this.price,
    required this.doneDate,
    required this.haveReview,
    required this.workRef,
  });

  final DocumentReference? userData;
  final int? price;
  final DateTime? doneDate;
  final bool? haveReview;
  final DocumentReference? workRef;

  @override
  State<JobCardHistoryWidget> createState() => _JobCardHistoryWidgetState();
}

class _JobCardHistoryWidgetState extends State<JobCardHistoryWidget> {
  late JobCardHistoryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobCardHistoryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        height: 160.0,
        constraints: BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
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
                        titleServOrder: widget!.doneDate!.toString(),
                        avaURL: userCardMiniUserRecord.photoUrl,
                        lastAchiv: userCardMiniUserRecord.lastAchivment,
                        raiting: userCardMiniUserRecord.rating,
                        userName: userCardMiniUserRecord.displayName,
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${FFLocalizations.of(context).getVariableText(
                      ruText: 'Завершен',
                      mnText: 'Дууссан',
                    )}  ${widget!.doneDate?.toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: Color(0xFF757575),
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                  Text(
                    '${formatNumber(
                      widget!.price,
                      formatType: FormatType.decimal,
                      decimalType: DecimalType.commaDecimal,
                    )} ${FFAppConstants.currency}',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleMediumFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleMediumIsCustom,
                        ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
              if (!widget!.haveReview!)
                AuthUserStreamWidget(
                  builder: (context) => FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(
                        TakeReviewWidget.routeName,
                        queryParameters: {
                          'reviewReciver': serializeParam(
                            widget!.userData,
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
                        ? 'Оценить заказчика'
                        : 'Оценить исполнителя',
                    options: FFButtonOptions(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'involve',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
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
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
