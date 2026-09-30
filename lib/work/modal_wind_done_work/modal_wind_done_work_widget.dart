import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/work/done_work_info/done_work_info_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'modal_wind_done_work_model.dart';
export 'modal_wind_done_work_model.dart';

class ModalWindDoneWorkWidget extends StatefulWidget {
  const ModalWindDoneWorkWidget({
    super.key,
    required this.worker,
    required this.work,
  });

  final DocumentReference? worker;
  final WorkRecord? work;

  @override
  State<ModalWindDoneWorkWidget> createState() =>
      _ModalWindDoneWorkWidgetState();
}

class _ModalWindDoneWorkWidgetState extends State<ModalWindDoneWorkWidget> {
  late ModalWindDoneWorkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModalWindDoneWorkModel());

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
      height: 577.0,
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
                'hla2fk0c' /* Подтвердить завершение? */,
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
                '9ne8b6a3' /* Деньги за заказ будут перечисл... */,
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
                  // updateWork

                  await widget!.work!.reference.update(createWorkRecordData(
                    workStatus: ResponseType.done,
                    debateStatus: DebateStatus.notStart,
                  ));
                  // comWorkNotification

                  var notificationsRecordReference =
                      NotificationsRecord.collection.doc();
                  await notificationsRecordReference.set({
                    ...createNotificationsRecordData(
                      whosNotification: widget!.worker,
                      title: 'Работа завершена',
                      letter: 'Заказчик подтвердил выполнение',
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
                      whosNotification: widget!.worker,
                      title: 'Работа завершена',
                      letter: 'Заказчик подтвердил выполнение',
                      unRead: true,
                    ),
                    ...mapToFirestore(
                      {
                        'timeStapm': DateTime.now(),
                      },
                    ),
                  }, notificationsRecordReference);

                  await widget!.worker!.update({
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

                  var transactionsRecordReference =
                      TransactionsRecord.collection.doc();
                  await transactionsRecordReference
                      .set(createTransactionsRecordData(
                    whosTransaction: widget!.worker,
                    income: true,
                    amount: widget!.work?.agreedPrice,
                    isPaid: true,
                    timestamp: getCurrentTimestamp,
                  ));
                  _model.newtrans = TransactionsRecord.getDocumentFromData(
                      createTransactionsRecordData(
                        whosTransaction: widget!.worker,
                        income: true,
                        amount: widget!.work?.agreedPrice,
                        isPaid: true,
                        timestamp: getCurrentTimestamp,
                      ),
                      transactionsRecordReference);

                  await widget!.worker!.update({
                    ...mapToFirestore(
                      {
                        'balance':
                            FieldValue.increment(widget!.work!.agreedPrice),
                        'transactions':
                            FieldValue.arrayUnion([_model.newtrans?.reference]),
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
                        child: DoneWorkInfoWidget(),
                      );
                    },
                  );

                  safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  'dhd7y5q4' /* Подтвердить */,
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
                'zo2ca590' /* Отмена */,
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
