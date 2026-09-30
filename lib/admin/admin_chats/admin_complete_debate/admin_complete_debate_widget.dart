import '/admin/admin_chats/admin_complete_debate_separate/admin_complete_debate_separate_widget.dart';
import '/admin/admin_chats/admin_debate_close/admin_debate_close_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_complete_debate_model.dart';
export 'admin_complete_debate_model.dart';

class AdminCompleteDebateWidget extends StatefulWidget {
  const AdminCompleteDebateWidget({
    super.key,
    required this.workDoc,
  });

  final WorkRecord? workDoc;

  @override
  State<AdminCompleteDebateWidget> createState() =>
      _AdminCompleteDebateWidgetState();
}

class _AdminCompleteDebateWidgetState extends State<AdminCompleteDebateWidget> {
  late AdminCompleteDebateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminCompleteDebateModel());

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
                        'crjvqvco' /* Решить спор */,
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
                      'ka5bzx4i' /* Сумма по заказу ( */,
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
                      'lh09x2t8' /* ) будет перечислена лицу, в чь... */,
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
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.debateStatus = DebateStatus.worker;
                safeSetState(() {});
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if ((_model.debateStatus != DebateStatus.worker) ||
                      (_model.debateStatus == null))
                    FaIcon(
                      FontAwesomeIcons.circle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  if (_model.debateStatus == DebateStatus.worker)
                    FaIcon(
                      FontAwesomeIcons.dotCircle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'vjsyt8x5' /* Исполнитель */,
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
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.debateStatus = DebateStatus.client;
                safeSetState(() {});
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if ((_model.debateStatus != DebateStatus.client) ||
                      (_model.debateStatus == null))
                    FaIcon(
                      FontAwesomeIcons.circle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  if (_model.debateStatus == DebateStatus.client)
                    FaIcon(
                      FontAwesomeIcons.dotCircle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '4joxkxzp' /* Заказчик */,
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
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.debateStatus = DebateStatus.separate;
                safeSetState(() {});
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if ((_model.debateStatus != DebateStatus.separate) ||
                      (_model.debateStatus == null))
                    FaIcon(
                      FontAwesomeIcons.circle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  if (_model.debateStatus == DebateStatus.separate)
                    FaIcon(
                      FontAwesomeIcons.dotCircle,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'ulzv1jjx' /* Разделить сумму */,
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
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Builder(
                builder: (context) => FFButtonWidget(
                  onPressed: () async {
                    if (_model.debateStatus == DebateStatus.separate) {
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
                            child: AdminCompleteDebateSeparateWidget(
                              workDoc: widget!.workDoc!,
                            ),
                          );
                        },
                      );
                    } else {
                      if (_model.debateStatus == DebateStatus.client) {
                        var transactionsRecordReference1 =
                            TransactionsRecord.collection.doc();
                        await transactionsRecordReference1
                            .set(createTransactionsRecordData(
                          whosTransaction: widget!.workDoc?.client,
                          income: true,
                          amount: widget!.workDoc?.agreedPrice,
                          isPaid: true,
                          timestamp: getCurrentTimestamp,
                        ));
                        _model.cashbackClient =
                            TransactionsRecord.getDocumentFromData(
                                createTransactionsRecordData(
                                  whosTransaction: widget!.workDoc?.client,
                                  income: true,
                                  amount: widget!.workDoc?.agreedPrice,
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
                              'Спор по заказу ${widget!.workDoc?.workTitle} закрыт в вашу пользу. Ожидайте поступления средств на ваш счет.',
                        ));
                        _model.notificClient =
                            NotificationsRecord.getDocumentFromData(
                                createNotificationsRecordData(
                                  whosNotification: widget!.workDoc?.client,
                                  title: 'Спор по заказу закрыт',
                                  timeStapm: getCurrentTimestamp,
                                  letter:
                                      'Спор по заказу ${widget!.workDoc?.workTitle} закрыт в вашу пользу. Ожидайте поступления средств на ваш счет.',
                                ),
                                notificationsRecordReference1);
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

                        var notificationsRecordReference2 =
                            NotificationsRecord.collection.doc();
                        await notificationsRecordReference2
                            .set(createNotificationsRecordData(
                          whosNotification: widget!.workDoc?.worker,
                          title: 'Спор по заказу закрыт',
                          timeStapm: getCurrentTimestamp,
                          letter:
                              'Спор по заказу ${widget!.workDoc?.workTitle} закрыт не в вашу пользу.',
                        ));
                        _model.notificWorker =
                            NotificationsRecord.getDocumentFromData(
                                createNotificationsRecordData(
                                  whosNotification: widget!.workDoc?.worker,
                                  title: 'Спор по заказу закрыт',
                                  timeStapm: getCurrentTimestamp,
                                  letter:
                                      'Спор по заказу ${widget!.workDoc?.workTitle} закрыт не в вашу пользу.',
                                ),
                                notificationsRecordReference2);

                        await widget!.workDoc!.reference
                            .update(createWorkRecordData(
                          workStatus: ResponseType.done,
                        ));

                        await widget!.workDoc!.reference
                            .update(createWorkRecordData(
                          debateStatus: DebateStatus.client,
                          accompleshedDate: getCurrentTimestamp,
                          workStatus: ResponseType.workComplete,
                        ));

                        await widget!.workDoc!.client!.update({
                          ...createUserRecordData(
                            hasNewNot: true,
                          ),
                          ...mapToFirestore(
                            {
                              'transactions': FieldValue.arrayUnion(
                                  [_model.cashbackClient?.reference]),
                              'myNotifications': FieldValue.arrayUnion(
                                  [_model.notificClient?.reference]),
                            },
                          ),
                        });

                        await widget!.workDoc!.client!.update({
                          ...createUserRecordData(
                            hasNewNot: true,
                          ),
                          ...mapToFirestore(
                            {
                              'myNotifications': FieldValue.arrayUnion(
                                  [_model.notificWorker?.reference]),
                              'balance': FieldValue.increment(
                                  widget!.workDoc!.agreedPrice),
                            },
                          ),
                        });

                        var messagesRecordReference1 =
                            MessagesRecord.collection.doc();
                        await messagesRecordReference1
                            .set(createMessagesRecordData(
                          chat: widget!.workDoc?.workChat,
                          whoSend: currentUserReference,
                          text: 'Спор закрыт в пользу клиента',
                          timestemp: getCurrentTimestamp,
                        ));
                        _model.closeDebMess =
                            MessagesRecord.getDocumentFromData(
                                createMessagesRecordData(
                                  chat: widget!.workDoc?.workChat,
                                  whoSend: currentUserReference,
                                  text: 'Спор закрыт в пользу клиента',
                                  timestemp: getCurrentTimestamp,
                                ),
                                messagesRecordReference1);

                        await widget!.workDoc!.workChat!.update({
                          ...createChatsRecordData(
                            lastMessage: 'Спор закрыт в пользу клиента',
                            lastMessageTime: _model.closeDebMess?.timestemp,
                            debateStatus: DebateStatus.client,
                          ),
                          ...mapToFirestore(
                            {
                              'messages': FieldValue.arrayUnion(
                                  [_model.closeDebMess?.reference]),
                            },
                          ),
                        });
                      } else {
                        var transactionsRecordReference2 =
                            TransactionsRecord.collection.doc();
                        await transactionsRecordReference2
                            .set(createTransactionsRecordData(
                          whosTransaction: widget!.workDoc?.worker,
                          income: true,
                          amount: widget!.workDoc?.agreedPrice,
                          isPaid: true,
                          timestamp: getCurrentTimestamp,
                        ));
                        _model.cashbackWorker =
                            TransactionsRecord.getDocumentFromData(
                                createTransactionsRecordData(
                                  whosTransaction: widget!.workDoc?.worker,
                                  income: true,
                                  amount: widget!.workDoc?.agreedPrice,
                                  isPaid: true,
                                  timestamp: getCurrentTimestamp,
                                ),
                                transactionsRecordReference2);

                        var notificationsRecordReference3 =
                            NotificationsRecord.collection.doc();
                        await notificationsRecordReference3
                            .set(createNotificationsRecordData(
                          whosNotification: widget!.workDoc?.client,
                          title: 'Спор по заказу закрыт',
                          timeStapm: getCurrentTimestamp,
                          letter:
                              'Спор по заказу ${widget!.workDoc?.workTitle} закрыт не в вашу пользу.',
                        ));
                        _model.notificClien =
                            NotificationsRecord.getDocumentFromData(
                                createNotificationsRecordData(
                                  whosNotification: widget!.workDoc?.client,
                                  title: 'Спор по заказу закрыт',
                                  timeStapm: getCurrentTimestamp,
                                  letter:
                                      'Спор по заказу ${widget!.workDoc?.workTitle} закрыт не в вашу пользу.',
                                ),
                                notificationsRecordReference3);

                        var notificationsRecordReference4 =
                            NotificationsRecord.collection.doc();
                        await notificationsRecordReference4
                            .set(createNotificationsRecordData(
                          whosNotification: widget!.workDoc?.worker,
                          title: 'Спор по заказу закрыт',
                          timeStapm: getCurrentTimestamp,
                          letter:
                              'Спор по заказу ${widget!.workDoc?.workTitle} закрыт в вашу пользу. Ожидайте поступления средств на ваш счет.',
                        ));
                        _model.notificWorke =
                            NotificationsRecord.getDocumentFromData(
                                createNotificationsRecordData(
                                  whosNotification: widget!.workDoc?.worker,
                                  title: 'Спор по заказу закрыт',
                                  timeStapm: getCurrentTimestamp,
                                  letter:
                                      'Спор по заказу ${widget!.workDoc?.workTitle} закрыт в вашу пользу. Ожидайте поступления средств на ваш счет.',
                                ),
                                notificationsRecordReference4);
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

                        await widget!.workDoc!.reference
                            .update(createWorkRecordData(
                          workStatus: ResponseType.done,
                        ));

                        await widget!.workDoc!.reference
                            .update(createWorkRecordData(
                          debateStatus: DebateStatus.worker,
                          accompleshedDate: getCurrentTimestamp,
                          workStatus: ResponseType.workComplete,
                        ));

                        await widget!.workDoc!.worker!.update({
                          ...createUserRecordData(
                            hasNewNot: true,
                          ),
                          ...mapToFirestore(
                            {
                              'transactions': FieldValue.arrayUnion(
                                  [_model.cashbackWorker?.reference]),
                              'myNotifications': FieldValue.arrayUnion(
                                  [_model.notificWorke?.reference]),
                            },
                          ),
                        });

                        await widget!.workDoc!.client!.update({
                          ...createUserRecordData(
                            hasNewNot: true,
                          ),
                          ...mapToFirestore(
                            {
                              'myNotifications': FieldValue.arrayUnion(
                                  [_model.notificClien?.reference]),
                              'balance': FieldValue.increment(
                                  widget!.workDoc!.agreedPrice),
                            },
                          ),
                        });

                        var messagesRecordReference2 =
                            MessagesRecord.collection.doc();
                        await messagesRecordReference2
                            .set(createMessagesRecordData(
                          chat: widget!.workDoc?.workChat,
                          whoSend: currentUserReference,
                          text: 'Спор закрыт в пользу исполнителя',
                          timestemp: getCurrentTimestamp,
                        ));
                        _model.closeDebMessWorker =
                            MessagesRecord.getDocumentFromData(
                                createMessagesRecordData(
                                  chat: widget!.workDoc?.workChat,
                                  whoSend: currentUserReference,
                                  text: 'Спор закрыт в пользу исполнителя',
                                  timestemp: getCurrentTimestamp,
                                ),
                                messagesRecordReference2);

                        await widget!.workDoc!.workChat!.update({
                          ...createChatsRecordData(
                            lastMessage: 'Спор закрыт в пользу клиента',
                            lastMessageTime:
                                _model.closeDebMessWorker?.timestemp,
                            debateStatus: DebateStatus.worker,
                          ),
                          ...mapToFirestore(
                            {
                              'messages': FieldValue.arrayUnion(
                                  [_model.closeDebMessWorker?.reference]),
                            },
                          ),
                        });
                      }

                      Navigator.pop(context);
                      await Future.delayed(
                        Duration(
                          milliseconds: 1000,
                        ),
                      );
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
                              debateResult: _model.debateStatus!,
                            ),
                          );
                        },
                      );
                    }

                    safeSetState(() {});
                  },
                  text: FFLocalizations.of(context).getText(
                    'vea39vdi' /* Далее */,
                  ),
                  options: FFButtonOptions(
                    width: 160.0,
                    height: 58.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
