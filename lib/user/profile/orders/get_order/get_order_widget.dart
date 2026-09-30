import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/get_job/modal_wind_get_order_succes/modal_wind_get_order_succes_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'get_order_model.dart';
export 'get_order_model.dart';

class GetOrderWidget extends StatefulWidget {
  const GetOrderWidget({
    super.key,
    required this.orderRef,
    this.byOffer,
  });

  final OrdersRecord? orderRef;
  final WorkRecord? byOffer;

  static String routeName = 'getOrder';
  static String routePath = '/getOrder';

  @override
  State<GetOrderWidget> createState() => _GetOrderWidgetState();
}

class _GetOrderWidgetState extends State<GetOrderWidget> {
  late GetOrderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GetOrderModel());

    _model.costTextController ??= TextEditingController();
    _model.costFocusNode ??= FocusNode();

    _model.deadlineTextController ??= TextEditingController();
    _model.deadlineFocusNode ??= FocusNode();

    _model.letterTextController ??= TextEditingController();
    _model.letterFocusNode ??= FocusNode();

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
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: wrapWithModel(
                      model: _model.titlewithbackModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TitlewithbackWidget(
                        title: 'Откликнуться',
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Стоимость работы ${FFAppConstants.currency}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                      TextFormField(
                        controller: _model.costTextController,
                        focusNode: _model.costFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: FFLocalizations.of(context).getText(
                            '9c0f4tlo' /* Введите */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: Color(0xFF9E9E9E),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: EdgeInsets.all(18.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        keyboardType: TextInputType.number,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: _model.costTextControllerValidator
                            .asValidator(context),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                      ),
                    ].divide(SizedBox(height: 12.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'nw6d7bny' /* Срок выполнения работы (кол-во... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                      TextFormField(
                        controller: _model.deadlineTextController,
                        focusNode: _model.deadlineFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: FFLocalizations.of(context).getText(
                            'nmbfrkad' /* Введите */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: Color(0xFF9E9E9E),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: EdgeInsets.all(18.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        keyboardType: TextInputType.number,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: _model.deadlineTextControllerValidator
                            .asValidator(context),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                      ),
                    ].divide(SizedBox(height: 12.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'wu81inn5' /* Сопроводительное письмо */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                      TextFormField(
                        controller: _model.letterTextController,
                        focusNode: _model.letterFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: FFLocalizations.of(context).getText(
                            'jqi02hcb' /* Введите */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: Color(0xFF9E9E9E),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: EdgeInsets.all(18.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        maxLines: null,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: _model.letterTextControllerValidator
                            .asValidator(context),
                      ),
                    ].divide(SizedBox(height: 12.0)),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                  child: FFButtonWidget(
                    onPressed: ((_model.costTextController.text == null ||
                                _model.costTextController.text == '') ||
                            (_model.deadlineTextController.text == null ||
                                _model.deadlineTextController.text == '') ||
                            (_model.letterTextController.text == null ||
                                _model.letterTextController.text == ''))
                        ? null
                        : () async {
                            if (widget!.byOffer != null) {
                              // respondByOffer

                              var responceRecordReference1 =
                                  ResponceRecord.collection.doc();
                              await responceRecordReference1
                                  .set(createResponceRecordData(
                                respSender: currentUserReference,
                                respReciver: widget!.orderRef?.whoCreate,
                                respPrice: int.tryParse(
                                    _model.costTextController.text),
                                respLetter: _model.letterTextController.text,
                                respDeadline: int.tryParse(
                                    _model.deadlineTextController.text),
                                newResponce: false,
                                respOffer: OfferType.fromWorker,
                              ));
                              _model.responceByOffer =
                                  ResponceRecord.getDocumentFromData(
                                      createResponceRecordData(
                                        respSender: currentUserReference,
                                        respReciver:
                                            widget!.orderRef?.whoCreate,
                                        respPrice: int.tryParse(
                                            _model.costTextController.text),
                                        respLetter:
                                            _model.letterTextController.text,
                                        respDeadline: int.tryParse(
                                            _model.deadlineTextController.text),
                                        newResponce: false,
                                        respOffer: OfferType.fromWorker,
                                      ),
                                      responceRecordReference1);

                              await widget!.byOffer!.reference.update({
                                ...createWorkRecordData(
                                  byOffer: false,
                                ),
                                ...mapToFirestore(
                                  {
                                    'history_responces': FieldValue.arrayUnion(
                                        [_model.responceByOffer?.reference]),
                                  },
                                ),
                              });

                              await widget!.byOffer!.reference.update({
                                ...createWorkRecordData(
                                  agreedPrice: int.tryParse(
                                      _model.costTextController.text),
                                  agreedDeadline: int.tryParse(
                                      _model.deadlineTextController.text),
                                ),
                                ...mapToFirestore(
                                  {
                                    'history_responces': FieldValue.arrayUnion(
                                        [_model.responceByOffer?.reference]),
                                  },
                                ),
                              });
                              // createNotification

                              var notificationsRecordReference1 =
                                  NotificationsRecord.collection.doc();
                              await notificationsRecordReference1.set({
                                ...createNotificationsRecordData(
                                  whosNotification: widget!.orderRef?.whoCreate,
                                  title: 'Новый отклик на заказ',
                                  letter:
                                      'Новый отклик на ваш заказ ${widget!.orderRef?.title} от ${currentUserDisplayName}',
                                  unRead: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timeStapm': FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.createNotificByOffer =
                                  NotificationsRecord.getDocumentFromData({
                                ...createNotificationsRecordData(
                                  whosNotification: widget!.orderRef?.whoCreate,
                                  title: 'Новый отклик на заказ',
                                  letter:
                                      'Новый отклик на ваш заказ ${widget!.orderRef?.title} от ${currentUserDisplayName}',
                                  unRead: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timeStapm': DateTime.now(),
                                  },
                                ),
                              }, notificationsRecordReference1);
                              triggerPushNotification(
                                notificationTitle:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Новый отклик на Ваш заказ',
                                  mnText: 'Таны захиалгын шинэ хариу',
                                ),
                                notificationText:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Новый отклик на Ваш заказ',
                                  mnText: 'Таны захиалгын шинэ хариу',
                                ),
                                userRefs: [widget!.orderRef!.whoCreate!],
                                initialPageName: 'myJobs',
                                parameterData: {},
                              );

                              await widget!.byOffer!.client!.update({
                                ...createUserRecordData(
                                  hasNewNot: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'myNotifications': FieldValue.arrayUnion([
                                      _model.createNotificByOffer?.reference
                                    ]),
                                  },
                                ),
                              });
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(dialogContext).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: ModalWindGetOrderSuccesWidget(),
                                    ),
                                  );
                                },
                              );
                            } else {
                              // createResponce

                              var responceRecordReference2 =
                                  ResponceRecord.collection.doc();
                              await responceRecordReference2
                                  .set(createResponceRecordData(
                                respSender: currentUserReference,
                                respReciver: widget!.orderRef?.whoCreate,
                                respOrder: widget!.orderRef?.reference,
                                respPrice: int.tryParse(
                                    _model.costTextController.text),
                                newResponce: true,
                                respLetter: _model.letterTextController.text,
                                respDeadline: int.tryParse(
                                    _model.deadlineTextController.text),
                                respOffer: OfferType.fromWorker,
                              ));
                              _model.createRespond =
                                  ResponceRecord.getDocumentFromData(
                                      createResponceRecordData(
                                        respSender: currentUserReference,
                                        respReciver:
                                            widget!.orderRef?.whoCreate,
                                        respOrder: widget!.orderRef?.reference,
                                        respPrice: int.tryParse(
                                            _model.costTextController.text),
                                        newResponce: true,
                                        respLetter:
                                            _model.letterTextController.text,
                                        respDeadline: int.tryParse(
                                            _model.deadlineTextController.text),
                                        respOffer: OfferType.fromWorker,
                                      ),
                                      responceRecordReference2);
                              // createWork

                              var workRecordReference =
                                  WorkRecord.collection.doc();
                              await workRecordReference.set({
                                ...createWorkRecordData(
                                  order: widget!.orderRef?.reference,
                                  worker: currentUserReference,
                                  client: widget!.orderRef?.whoCreate,
                                  workStatus: ResponseType.offer,
                                  workTitle: widget!.orderRef?.title,
                                  agreedPrice: _model.createRespond?.respPrice,
                                  agreedDeadline: int.tryParse(
                                      _model.deadlineTextController.text),
                                  debateStatus: DebateStatus.notStart,
                                  byOffer: false,
                                ),
                                ...mapToFirestore(
                                  {
                                    'history_responces': [
                                      _model.createRespond?.reference
                                    ],
                                    'created_time':
                                        FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.createWork =
                                  WorkRecord.getDocumentFromData({
                                ...createWorkRecordData(
                                  order: widget!.orderRef?.reference,
                                  worker: currentUserReference,
                                  client: widget!.orderRef?.whoCreate,
                                  workStatus: ResponseType.offer,
                                  workTitle: widget!.orderRef?.title,
                                  agreedPrice: _model.createRespond?.respPrice,
                                  agreedDeadline: int.tryParse(
                                      _model.deadlineTextController.text),
                                  debateStatus: DebateStatus.notStart,
                                  byOffer: false,
                                ),
                                ...mapToFirestore(
                                  {
                                    'history_responces': [
                                      _model.createRespond?.reference
                                    ],
                                    'created_time': DateTime.now(),
                                  },
                                ),
                              }, workRecordReference);
                              // createChat

                              var chatsRecordReference =
                                  ChatsRecord.collection.doc();
                              await chatsRecordReference.set({
                                ...createChatsRecordData(
                                  work: _model.createWork?.reference,
                                  chatTitle: widget!.orderRef?.title,
                                  debateStatus: DebateStatus.notStart,
                                ),
                                ...mapToFirestore(
                                  {
                                    'members': [currentUserReference],
                                  },
                                ),
                              });
                              _model.crateChat =
                                  ChatsRecord.getDocumentFromData({
                                ...createChatsRecordData(
                                  work: _model.createWork?.reference,
                                  chatTitle: widget!.orderRef?.title,
                                  debateStatus: DebateStatus.notStart,
                                ),
                                ...mapToFirestore(
                                  {
                                    'members': [currentUserReference],
                                  },
                                ),
                              }, chatsRecordReference);
                              // createFirstMessage

                              var messagesRecordReference =
                                  MessagesRecord.collection.doc();
                              await messagesRecordReference.set({
                                ...createMessagesRecordData(
                                  chat: _model.crateChat?.reference,
                                  whoSend: currentUserReference,
                                  text: _model.letterTextController.text,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timestemp': FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.createFirstMessage =
                                  MessagesRecord.getDocumentFromData({
                                ...createMessagesRecordData(
                                  chat: _model.crateChat?.reference,
                                  whoSend: currentUserReference,
                                  text: _model.letterTextController.text,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timestemp': DateTime.now(),
                                  },
                                ),
                              }, messagesRecordReference);
                              // updateWork

                              await _model.createWork!.reference
                                  .update(createWorkRecordData(
                                workChat: _model.crateChat?.reference,
                              ));
                              triggerPushNotification(
                                notificationTitle:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Новый отклик на Ваш заказ',
                                  mnText: 'Таны захиалгын шинэ хариу',
                                ),
                                notificationText:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Новый отклик на Ваш заказ',
                                  mnText: 'Таны захиалгын шинэ хариу',
                                ),
                                userRefs: [widget!.orderRef!.whoCreate!],
                                initialPageName: 'myJobs',
                                parameterData: {},
                              );
                              // updateCHat

                              await _model.crateChat!.reference.update({
                                ...createChatsRecordData(
                                  lastMessage: _model.letterTextController.text,
                                  lastMessageSender: currentUserReference,
                                ),
                                ...mapToFirestore(
                                  {
                                    'members': FieldValue.arrayUnion(
                                        [widget!.orderRef?.whoCreate]),
                                    'messages': FieldValue.arrayUnion(
                                        [_model.createFirstMessage?.reference]),
                                    'last_message_time':
                                        FieldValue.serverTimestamp(),
                                    'last_message_seen_by':
                                        FieldValue.arrayUnion(
                                            [currentUserReference]),
                                  },
                                ),
                              });
                              // createTransaction

                              var transactionsRecordReference =
                                  TransactionsRecord.collection.doc();
                              await transactionsRecordReference.set({
                                ...createTransactionsRecordData(
                                  whosTransaction: currentUserReference,
                                  income: false,
                                  amount: FFAppState().commission,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timestamp': FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.commicionTransaction =
                                  TransactionsRecord.getDocumentFromData({
                                ...createTransactionsRecordData(
                                  whosTransaction: currentUserReference,
                                  income: false,
                                  amount: FFAppState().commission,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timestamp': DateTime.now(),
                                  },
                                ),
                              }, transactionsRecordReference);
                              // createNotification

                              var notificationsRecordReference2 =
                                  NotificationsRecord.collection.doc();
                              await notificationsRecordReference2.set({
                                ...createNotificationsRecordData(
                                  whosNotification: widget!.orderRef?.whoCreate,
                                  title: 'Новый отклик на заказ',
                                  letter:
                                      'Новый отклик на ваш заказ ${widget!.orderRef?.title} от ${currentUserDisplayName}',
                                  unRead: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timeStapm': FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.createNotific =
                                  NotificationsRecord.getDocumentFromData({
                                ...createNotificationsRecordData(
                                  whosNotification: widget!.orderRef?.whoCreate,
                                  title: 'Новый отклик на заказ',
                                  letter:
                                      'Новый отклик на ваш заказ ${widget!.orderRef?.title} от ${currentUserDisplayName}',
                                  unRead: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'timeStapm': DateTime.now(),
                                  },
                                ),
                              }, notificationsRecordReference2);
                              // updateWorker

                              await currentUserReference!.update({
                                ...createUserRecordData(
                                  email: '',
                                ),
                                ...mapToFirestore(
                                  {
                                    'transactions': FieldValue.arrayUnion([
                                      _model.commicionTransaction?.reference
                                    ]),
                                    'my_works': FieldValue.arrayUnion(
                                        [_model.createWork?.reference]),
                                    'balance': FieldValue.increment(
                                        -(FFAppState().commission)),
                                    'chats': FieldValue.arrayUnion(
                                        [_model.crateChat?.reference]),
                                  },
                                ),
                              });
                              // updateClient

                              await widget!.orderRef!.whoCreate!.update({
                                ...createUserRecordData(
                                  hasNewNot: true,
                                ),
                                ...mapToFirestore(
                                  {
                                    'my_works': FieldValue.arrayUnion(
                                        [_model.createWork?.reference]),
                                    'myNotifications': FieldValue.arrayUnion(
                                        [_model.createNotific?.reference]),
                                    'chats': FieldValue.arrayUnion(
                                        [_model.crateChat?.reference]),
                                  },
                                ),
                              });
                              // orederAddResponce

                              await widget!.orderRef!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'responces': FieldValue.arrayUnion(
                                        [_model.createRespond?.reference]),
                                  },
                                ),
                              });
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(dialogContext).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: ModalWindGetOrderSuccesWidget(),
                                    ),
                                  );
                                },
                              );
                            }

                            safeSetState(() {});
                          },
                    text: FFLocalizations.of(context).getText(
                      'reh8l8eb' /* Отправить */,
                    ),
                    options: FFButtonOptions(
                      width: 360.0,
                      height: 58.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                      disabledColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
