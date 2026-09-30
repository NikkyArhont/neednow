import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'respond_card_model.dart';
export 'respond_card_model.dart';

class RespondCardWidget extends StatefulWidget {
  const RespondCardWidget({
    super.key,
    required this.userData,
    required this.respondStatus,
    required this.orderTitle,
  });

  final DocumentReference? userData;
  final ResponseType? respondStatus;
  final String? orderTitle;

  @override
  State<RespondCardWidget> createState() => _RespondCardWidgetState();
}

class _RespondCardWidgetState extends State<RespondCardWidget> {
  late RespondCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RespondCardModel());

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
        constraints: BoxConstraints(
          maxWidth: 800.0,
          maxHeight: 200.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
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
                        titleServOrder: widget!.orderTitle!,
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
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: () {
                      if (widget!.respondStatus == ResponseType.offer) {
                        return FlutterFlowTheme.of(context).secondary;
                      } else if (widget!.respondStatus ==
                          ResponseType.confirmed) {
                        return Color(0x1E4ADE80);
                      } else if (widget!.respondStatus == ResponseType.denied) {
                        return Color(0x1EF75555);
                      } else if (widget!.respondStatus ==
                          ResponseType.dispute) {
                        return Color(0x1EFACC15);
                      } else {
                        return Color(0x1F757575);
                      }
                    }(),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        () {
                          if (widget!.respondStatus == ResponseType.offer) {
                            return (valueOrDefault<bool>(
                                    currentUserDocument?.isWorker, false)
                                ? FFLocalizations.of(context).getVariableText(
                                    ruText: 'Отклик отправлен',
                                    mnText: 'Хариу илгээсэн',
                                  )
                                : FFLocalizations.of(context).getVariableText(
                                    ruText: 'С откликом',
                                    mnText: 'Хариултаар',
                                  ));
                          } else if (widget!.respondStatus ==
                              ResponseType.confirmed) {
                            return (valueOrDefault<bool>(
                                    currentUserDocument?.isWorker, false)
                                ? FFLocalizations.of(context).getVariableText(
                                    ruText: 'Подтвержден',
                                    mnText: 'Батлагдсан',
                                  )
                                : FFLocalizations.of(context).getVariableText(
                                    ruText: 'Исполнитель подтвержден',
                                    mnText: 'Гүйцэтгэгч нь батлагдсан',
                                  ));
                          } else if (widget!.respondStatus ==
                              ResponseType.denied) {
                            return (valueOrDefault<bool>(
                                    currentUserDocument?.isWorker, false)
                                ? 'Отклонен'
                                : 'Исполнитель отклонен');
                          } else if (widget!.respondStatus ==
                              ResponseType.dispute) {
                            return FFLocalizations.of(context).getVariableText(
                              ruText: 'Открыт спор',
                              mnText: 'Маргаан нээсэн',
                            );
                          } else {
                            return FFLocalizations.of(context).getVariableText(
                              ruText: 'Завершен',
                              mnText: 'Дууссан',
                            );
                          }
                        }(),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: () {
                                if (widget!.respondStatus ==
                                    ResponseType.offer) {
                                  return FlutterFlowTheme.of(context).primary;
                                } else if (widget!.respondStatus ==
                                    ResponseType.confirmed) {
                                  return FlutterFlowTheme.of(context).success;
                                } else if (widget!.respondStatus ==
                                    ResponseType.denied) {
                                  return FlutterFlowTheme.of(context).error;
                                } else if (widget!.respondStatus ==
                                    ResponseType.dispute) {
                                  return FlutterFlowTheme.of(context)
                                      .primaryText;
                                } else {
                                  return FlutterFlowTheme.of(context).warning;
                                }
                              }(),
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
