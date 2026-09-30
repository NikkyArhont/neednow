import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/work/complete_work_info/complete_work_info_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'modal_wind_complete_wrk_model.dart';
export 'modal_wind_complete_wrk_model.dart';

class ModalWindCompleteWrkWidget extends StatefulWidget {
  const ModalWindCompleteWrkWidget({
    super.key,
    required this.client,
    required this.work,
  });

  final DocumentReference? client;
  final DocumentReference? work;

  @override
  State<ModalWindCompleteWrkWidget> createState() =>
      _ModalWindCompleteWrkWidgetState();
}

class _ModalWindCompleteWrkWidgetState
    extends State<ModalWindCompleteWrkWidget> {
  late ModalWindCompleteWrkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModalWindCompleteWrkModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.0,
      height: 640.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(44.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/modalDialogSingup.png',
                width: 180.0,
                height: 180.0,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                'mws8encx' /* Запросить завершение */,
              ),
              textAlign: TextAlign.center,
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
                'st51hun4' /* Вы выполнили все условия заказ... */,
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
            Builder(
              builder: (context) => FFButtonWidget(
                onPressed: () async {
                  // workComplete

                  var responceRecordReference = ResponceRecord.collection.doc();
                  await responceRecordReference.set(createResponceRecordData(
                    respSender: currentUserReference,
                    respReciver: widget!.client,
                    newResponce: true,
                  ));
                  _model.workComplete = ResponceRecord.getDocumentFromData(
                      createResponceRecordData(
                        respSender: currentUserReference,
                        respReciver: widget!.client,
                        newResponce: true,
                      ),
                      responceRecordReference);
                  // updateWork

                  await widget!.work!.update({
                    ...createWorkRecordData(
                      workStatus: ResponseType.workComplete,
                    ),
                    ...mapToFirestore(
                      {
                        'accompleshedDate': FieldValue.serverTimestamp(),
                      },
                    ),
                  });
                  // doneWorkNotification

                  var notificationsRecordReference =
                      NotificationsRecord.collection.doc();
                  await notificationsRecordReference.set({
                    ...createNotificationsRecordData(
                      whosNotification: widget!.client,
                      title: 'Работа завершена',
                      letter: 'Подтвердите выполнение заказа',
                      unRead: true,
                    ),
                    ...mapToFirestore(
                      {
                        'timeStapm': FieldValue.serverTimestamp(),
                      },
                    ),
                  });
                  _model.doneWorkNotification =
                      NotificationsRecord.getDocumentFromData({
                    ...createNotificationsRecordData(
                      whosNotification: widget!.client,
                      title: 'Работа завершена',
                      letter: 'Подтвердите выполнение заказа',
                      unRead: true,
                    ),
                    ...mapToFirestore(
                      {
                        'timeStapm': DateTime.now(),
                      },
                    ),
                  }, notificationsRecordReference);

                  await widget!.client!.update({
                    ...createUserRecordData(
                      hasNewNot: true,
                    ),
                    ...mapToFirestore(
                      {
                        'myNotifications': FieldValue.arrayUnion(
                            [_model.doneWorkNotification?.reference]),
                      },
                    ),
                  });
                  Navigator.pop(context);
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: CompleteWorkInfoWidget(),
                      );
                    },
                  );

                  safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  '5zshmb82' /* Отправить запрос */,
                ),
                options: FFButtonOptions(
                  width: 360.0,
                  height: 58.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
            ),
            FFButtonWidget(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: FFLocalizations.of(context).getText(
                'sqq92dak' /* Отмена */,
              ),
              options: FFButtonOptions(
                width: 360.0,
                height: 58.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFE9F0FF),
                textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: 'involve',
                      color: FlutterFlowTheme.of(context).primary,
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
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
