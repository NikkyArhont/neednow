import '/admin/admin_chats/admin_complete_debate/admin_complete_debate_widget.dart';
import '/admin/admin_chats/admin_debate_close/admin_debate_close_widget.dart';
import '/admin/admin_chats/admin_incorrect_separate/admin_incorrect_separate_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_complete_debate_separate_model.dart';
export 'admin_complete_debate_separate_model.dart';

class AdminCompleteDebateSeparateWidget extends StatefulWidget {
  const AdminCompleteDebateSeparateWidget({
    super.key,
    required this.workDoc,
  });

  final WorkRecord? workDoc;

  @override
  State<AdminCompleteDebateSeparateWidget> createState() =>
      _AdminCompleteDebateSeparateWidgetState();
}

class _AdminCompleteDebateSeparateWidgetState
    extends State<AdminCompleteDebateSeparateWidget> {
  late AdminCompleteDebateSeparateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminCompleteDebateSeparateModel());

    _model.workerAmountTextController ??= TextEditingController();
    _model.workerAmountFocusNode ??= FocusNode();

    _model.clientAmountTextController ??= TextEditingController();
    _model.clientAmountFocusNode ??= FocusNode();

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
      width: 430.0,
      height: 380.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 16.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '95sbgr7m' /* Разделить сумму */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).displayMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayMediumIsCustom,
                              ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            RichText(
              textScaler: MediaQuery.of(context).textScaler,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: FFLocalizations.of(context).getText(
                      '0r8l6zoq' /* Сумма по заказу ( */,
                    ),
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: valueOrDefault<String>(
                      widget!.workDoc?.agreedPrice?.toString(),
                      '0',
                    ),
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: FFAppConstants.currency,
                    style: TextStyle(),
                  ),
                  TextSpan(
                    text: FFLocalizations.of(context).getText(
                      'b1zp5emg' /* ) будет перечислена лицу, в чь... */,
                    ),
                    style: TextStyle(),
                  )
                ],
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'tpnl5ekd' /* Сумма исполнителю */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                child: TextFormField(
                  controller: _model.workerAmountTextController,
                  focusNode: _model.workerAmountFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.workerAmountTextController',
                    Duration(milliseconds: 1000),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: FFLocalizations.of(context).getText(
                      'tyvhqo02' /* Введите */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: Color(0xFF9E9E9E),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: EdgeInsets.all(18.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  maxLines: null,
                  maxLength: 10,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  keyboardType: TextInputType.number,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator: _model.workerAmountTextControllerValidator
                      .asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '3du6t0bc' /* Сумма заказчику */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                child: TextFormField(
                  controller: _model.clientAmountTextController,
                  focusNode: _model.clientAmountFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.clientAmountTextController',
                    Duration(milliseconds: 1000),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: FFLocalizations.of(context).getText(
                      'v5maechf' /* Введите */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: Color(0xFF9E9E9E),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: EdgeInsets.all(18.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                  maxLines: null,
                  maxLength: 10,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  keyboardType: TextInputType.number,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator: _model.clientAmountTextControllerValidator
                      .asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Builder(
                  builder: (context) => InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
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
                            child: AdminCompleteDebateWidget(
                              workDoc: widget!.workDoc!,
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'dk1f8msg' /* Назад */,
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleMediumIsCustom,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        if (int.parse(_model.clientAmountTextController.text) +
                                int.parse(
                                    _model.workerAmountTextController.text) ==
                            widget!.workDoc!.agreedPrice) {
                          var transactionsRecordReference1 =
                              TransactionsRecord.collection.doc();
                          await transactionsRecordReference1
                              .set(createTransactionsRecordData(
                            whosTransaction: widget!.workDoc?.client,
                            income: true,
                            amount: int.tryParse(
                                _model.clientAmountTextController.text),
                            isPaid: true,
                            timestamp: getCurrentTimestamp,
                          ));
                          _model.clientMoney =
                              TransactionsRecord.getDocumentFromData(
                                  createTransactionsRecordData(
                                    whosTransaction: widget!.workDoc?.client,
                                    income: true,
                                    amount: int.tryParse(
                                        _model.clientAmountTextController.text),
                                    isPaid: true,
                                    timestamp: getCurrentTimestamp,
                                  ),
                                  transactionsRecordReference1);

                          var notificationsRecordReference1 =
                              NotificationsRecord.collection.doc();
                          await notificationsRecordReference1
                              .set(createNotificationsRecordData(
                            whosNotification: widget!.workDoc?.client,
                            title: 'Спор по заказу закрыт',
                            timeStapm: getCurrentTimestamp,
                            letter:
                                'Спор по заказу ${widget!.workDoc?.workTitle} закрыт. Ожидайте поступления средств.',
                            unRead: true,
                          ));
                          _model.clientNot =
                              NotificationsRecord.getDocumentFromData(
                                  createNotificationsRecordData(
                                    whosNotification: widget!.workDoc?.client,
                                    title: 'Спор по заказу закрыт',
                                    timeStapm: getCurrentTimestamp,
                                    letter:
                                        'Спор по заказу ${widget!.workDoc?.workTitle} закрыт. Ожидайте поступления средств.',
                                    unRead: true,
                                  ),
                                  notificationsRecordReference1);

                          await widget!.workDoc!.reference
                              .update(createWorkRecordData(
                            workStatus: ResponseType.done,
                          ));

                          await widget!.workDoc!.client!.update({
                            ...createUserRecordData(
                              hasNewNot: true,
                            ),
                            ...mapToFirestore(
                              {
                                'transactions': FieldValue.arrayUnion(
                                    [_model.clientMoney?.reference]),
                                'balance': FieldValue.increment(int.parse(
                                    _model.clientAmountTextController.text)),
                                'myNotifications': FieldValue.arrayUnion(
                                    [_model.clientNot?.reference]),
                              },
                            ),
                          });

                          var transactionsRecordReference2 =
                              TransactionsRecord.collection.doc();
                          await transactionsRecordReference2
                              .set(createTransactionsRecordData(
                            whosTransaction: widget!.workDoc?.worker,
                            income: true,
                            amount: int.tryParse(
                                _model.workerAmountTextController.text),
                            isPaid: true,
                            timestamp: getCurrentTimestamp,
                          ));
                          _model.workerMoney =
                              TransactionsRecord.getDocumentFromData(
                                  createTransactionsRecordData(
                                    whosTransaction: widget!.workDoc?.worker,
                                    income: true,
                                    amount: int.tryParse(
                                        _model.workerAmountTextController.text),
                                    isPaid: true,
                                    timestamp: getCurrentTimestamp,
                                  ),
                                  transactionsRecordReference2);

                          var notificationsRecordReference2 =
                              NotificationsRecord.collection.doc();
                          await notificationsRecordReference2
                              .set(createNotificationsRecordData(
                            whosNotification: widget!.workDoc?.worker,
                            title: 'Спор по заказу закрыт',
                            timeStapm: getCurrentTimestamp,
                            letter:
                                'Спор по заказу ${widget!.workDoc?.workTitle} закрыт. Ожидайте поступления средств.',
                            unRead: true,
                          ));
                          _model.workerNot =
                              NotificationsRecord.getDocumentFromData(
                                  createNotificationsRecordData(
                                    whosNotification: widget!.workDoc?.worker,
                                    title: 'Спор по заказу закрыт',
                                    timeStapm: getCurrentTimestamp,
                                    letter:
                                        'Спор по заказу ${widget!.workDoc?.workTitle} закрыт. Ожидайте поступления средств.',
                                    unRead: true,
                                  ),
                                  notificationsRecordReference2);
                          triggerPushNotification(
                            notificationTitle:
                                FFLocalizations.of(context).getVariableText(
                              ruText: 'Новое решение по вашему спору',
                              mnText: 'Таны маргаантай холбоотой шинэ шийдвэр',
                            ),
                            notificationText:
                                FFLocalizations.of(context).getVariableText(
                              ruText: 'Новое решение по вашему спору',
                              mnText: 'Таны маргаантай холбоотой шинэ шийдвэр',
                            ),
                            userRefs: [widget!.workDoc!.client!],
                            initialPageName: 'myNotification',
                            parameterData: {},
                          );
                          triggerPushNotification(
                            notificationTitle:
                                FFLocalizations.of(context).getVariableText(
                              ruText: 'Новое решение по вашему спору',
                              mnText: 'Таны маргаантай холбоотой шинэ шийдвэр',
                            ),
                            notificationText:
                                FFLocalizations.of(context).getVariableText(
                              ruText: 'Новое решение по вашему спору',
                              mnText: 'Таны маргаантай холбоотой шинэ шийдвэр',
                            ),
                            userRefs: [widget!.workDoc!.worker!],
                            initialPageName: 'myNotification',
                            parameterData: {},
                          );

                          await widget!.workDoc!.worker!.update({
                            ...createUserRecordData(
                              hasNewNot: true,
                            ),
                            ...mapToFirestore(
                              {
                                'transactions': FieldValue.arrayUnion(
                                    [_model.workerMoney?.reference]),
                                'balance': FieldValue.increment(int.parse(
                                    _model.workerAmountTextController.text)),
                                'myNotifications': FieldValue.arrayUnion(
                                    [_model.workerNot?.reference]),
                              },
                            ),
                          });

                          await widget!.workDoc!.reference
                              .update(createWorkRecordData(
                            accompleshedDate: getCurrentTimestamp,
                            debateStatus: DebateStatus.separate,
                            workStatus: ResponseType.workComplete,
                          ));

                          var messagesRecordReference =
                              MessagesRecord.collection.doc();
                          await messagesRecordReference
                              .set(createMessagesRecordData(
                            chat: widget!.workDoc?.workChat,
                            whoSend: currentUserReference,
                            text: 'Спор закрыт в пользу исполнителя/заказчика',
                            timestemp: getCurrentTimestamp,
                          ));
                          _model.closeDebMessSeparate =
                              MessagesRecord.getDocumentFromData(
                                  createMessagesRecordData(
                                    chat: widget!.workDoc?.workChat,
                                    whoSend: currentUserReference,
                                    text:
                                        'Спор закрыт в пользу исполнителя/заказчика',
                                    timestemp: getCurrentTimestamp,
                                  ),
                                  messagesRecordReference);

                          await widget!.workDoc!.workChat!.update({
                            ...createChatsRecordData(
                              lastMessage:
                                  'Спор закрыт в пользу исолнителя/заказчика',
                              lastMessageTime:
                                  _model.closeDebMessSeparate?.timestemp,
                              debateStatus: DebateStatus.separate,
                            ),
                            ...mapToFirestore(
                              {
                                'messages': FieldValue.arrayUnion(
                                    [_model.closeDebMessSeparate?.reference]),
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
                                child: AdminDebateCloseWidget(
                                  debateResult: DebateStatus.separate,
                                ),
                              );
                            },
                          );
                        } else {
                          safeSetState(() {
                            _model.workerAmountTextController?.clear();
                            _model.clientAmountTextController?.clear();
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
                                child: AdminIncorrectSeparateWidget(),
                              );
                            },
                          );
                        }

                        safeSetState(() {});
                      },
                      text: FFLocalizations.of(context).getText(
                        '0pi67gli' /* Применить */,
                      ),
                      options: FFButtonOptions(
                        width: 160.0,
                        height: 58.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).labelLarge.override(
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
              ].divide(SizedBox(width: 24.0)),
            ),
          ],
        ),
      ),
    );
  }
}
