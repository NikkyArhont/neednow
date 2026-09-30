import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/orders/modal_wind_offer_order_succes/modal_wind_offer_order_succes_widget.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'offer_order_model.dart';
export 'offer_order_model.dart';

class OfferOrderWidget extends StatefulWidget {
  const OfferOrderWidget({
    super.key,
    this.passOrder,
    required this.preferWorker,
    required this.preferService,
  });

  final OrdersRecord? passOrder;
  final DocumentReference? preferWorker;
  final DocumentReference? preferService;

  static String routeName = 'offerOrder';
  static String routePath = '/offerOrder';

  @override
  State<OfferOrderWidget> createState() => _OfferOrderWidgetState();
}

class _OfferOrderWidgetState extends State<OfferOrderWidget> {
  late OfferOrderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferOrderModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.choosenOrder = widget!.passOrder;
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 0.0, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: wrapWithModel(
                          model: _model.titlewithbackModel,
                          updateCallback: () => safeSetState(() {}),
                          child: TitlewithbackWidget(
                            title: FFLocalizations.of(context).getText(
                              'mn9xjmwt' /* Предложить заказ */,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_model.choosenOrder == null)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              ChooseOrderToOffWidget.routeName,
                              queryParameters: {
                                'prefworker': serializeParam(
                                  widget!.preferWorker,
                                  ParamType.DocumentReference,
                                ),
                                'prefServ': serializeParam(
                                  widget!.preferService,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            '9z3qfsh6' /* Выбрать заказ */,
                          ),
                          options: FFButtonOptions(
                            width: 360.0,
                            height: 58.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFE9F0FF),
                            textStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
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
                      ),
                    if (_model.choosenOrder != null)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                icon: Icon(
                                  FFIcons.kdelete,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  _model.choosenOrder = null;
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            Material(
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
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: StreamBuilder<UserRecord>(
                                          stream: UserRecord.getDocument(
                                              widget!.passOrder!.whoCreate!),
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

                                            final userCardMiniUserRecord =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model: _model.userCardMiniModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: UserCardMiniWidget(
                                                titleServOrder:
                                                    widget!.passOrder!.title,
                                                avaURL: userCardMiniUserRecord
                                                    .photoUrl,
                                                lastAchiv:
                                                    userCardMiniUserRecord
                                                        .lastAchivment,
                                                raiting: userCardMiniUserRecord
                                                    .rating,
                                                userName: userCardMiniUserRecord
                                                    .displayName,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Wrap(
                                                  spacing: 2.0,
                                                  runSpacing: 2.0,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  direction: Axis.horizontal,
                                                  runAlignment:
                                                      WrapAlignment.start,
                                                  verticalDirection:
                                                      VerticalDirection.down,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Text(
                                                      '${widget!.passOrder?.locationTitle}  -  ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Color(
                                                                0xFF757575),
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                    Text(
                                                      functions.searchCatTitles(
                                                          FFAppState()
                                                              .saveCat
                                                              .toList(),
                                                          widget!.passOrder!
                                                              .category!),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: Color(
                                                                0xFF757575),
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            AutoSizeText(
                                              '${widget!.passOrder?.price?.toString()} ${FFAppConstants.currency}',
                                              maxLines: 1,
                                              minFontSize: 10.0,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
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
                          ].divide(SizedBox(width: 12.0)),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'ha2aagv1' /* Сопроводительное письмо */,
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                      child: Container(
                        width: 800.0,
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController',
                            Duration(milliseconds: 1000),
                            () => safeSetState(() {}),
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: FFLocalizations.of(context).getText(
                              'k94dkclq' /* Введите */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsets.all(18.0),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                          maxLines: null,
                          maxLength: 400,
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              null,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: ((_model.choosenOrder == null) ||
                            (_model.textController.text == null ||
                                _model.textController.text == ''))
                        ? null
                        : () async {
                            // createResponce

                            var responceRecordReference =
                                ResponceRecord.collection.doc();
                            await responceRecordReference
                                .set(createResponceRecordData(
                              respSender: currentUserReference,
                              respReciver: widget!.preferWorker,
                              respOrder: _model.choosenOrder?.reference,
                              respPrice: _model.choosenOrder?.price,
                              newResponce: true,
                              respLetter: _model.textController.text,
                              respDeadline: _model.choosenOrder?.deadLine,
                              respOffer: OfferType.formClient,
                              respService: widget!.preferService,
                            ));
                            _model.createRespond =
                                ResponceRecord.getDocumentFromData(
                                    createResponceRecordData(
                                      respSender: currentUserReference,
                                      respReciver: widget!.preferWorker,
                                      respOrder: _model.choosenOrder?.reference,
                                      respPrice: _model.choosenOrder?.price,
                                      newResponce: true,
                                      respLetter: _model.textController.text,
                                      respDeadline:
                                          _model.choosenOrder?.deadLine,
                                      respOffer: OfferType.formClient,
                                      respService: widget!.preferService,
                                    ),
                                    responceRecordReference);
                            // createWork

                            var workRecordReference =
                                WorkRecord.collection.doc();
                            await workRecordReference.set({
                              ...createWorkRecordData(
                                order: _model.choosenOrder?.reference,
                                worker: widget!.preferWorker,
                                client: currentUserReference,
                                workStatus: ResponseType.offer,
                                workTitle: _model.choosenOrder?.title,
                                debateStatus: DebateStatus.notStart,
                                byOffer: true,
                                service: widget!.preferService,
                              ),
                              ...mapToFirestore(
                                {
                                  'history_responces': [
                                    _model.createRespond?.reference
                                  ],
                                  'created_time': FieldValue.serverTimestamp(),
                                },
                              ),
                            });
                            _model.createWork = WorkRecord.getDocumentFromData({
                              ...createWorkRecordData(
                                order: _model.choosenOrder?.reference,
                                worker: widget!.preferWorker,
                                client: currentUserReference,
                                workStatus: ResponseType.offer,
                                workTitle: _model.choosenOrder?.title,
                                debateStatus: DebateStatus.notStart,
                                byOffer: true,
                                service: widget!.preferService,
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
                                chatTitle: widget!.passOrder?.title,
                                debateStatus: DebateStatus.notStart,
                              ),
                              ...mapToFirestore(
                                {
                                  'members': [currentUserReference],
                                },
                              ),
                            });
                            _model.createChat =
                                ChatsRecord.getDocumentFromData({
                              ...createChatsRecordData(
                                work: _model.createWork?.reference,
                                chatTitle: widget!.passOrder?.title,
                                debateStatus: DebateStatus.notStart,
                              ),
                              ...mapToFirestore(
                                {
                                  'members': [currentUserReference],
                                },
                              ),
                            }, chatsRecordReference);

                            await _model.createWork!.reference
                                .update(createWorkRecordData(
                              workChat: _model.createChat?.reference,
                            ));
                            // createNotification

                            var notificationsRecordReference =
                                NotificationsRecord.collection.doc();
                            await notificationsRecordReference.set({
                              ...createNotificationsRecordData(
                                whosNotification: widget!.preferWorker,
                                title:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Предложен заказ',
                                  mnText: 'Захиалга санал болгож байна',
                                ),
                                letter:
                                    '${FFLocalizations.of(context).getVariableText(
                                  ruText: 'Предложен заказ ',
                                  mnText: 'Захиалга санал болгож байна',
                                )}${_model.choosenOrder?.title}${FFLocalizations.of(context).getVariableText(
                                  ruText: ' от ',
                                  mnText: '-аас',
                                )}${currentUserDisplayName}',
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
                                whosNotification: widget!.preferWorker,
                                title:
                                    FFLocalizations.of(context).getVariableText(
                                  ruText: 'Предложен заказ',
                                  mnText: 'Захиалга санал болгож байна',
                                ),
                                letter:
                                    '${FFLocalizations.of(context).getVariableText(
                                  ruText: 'Предложен заказ ',
                                  mnText: 'Захиалга санал болгож байна',
                                )}${_model.choosenOrder?.title}${FFLocalizations.of(context).getVariableText(
                                  ruText: ' от ',
                                  mnText: '-аас',
                                )}${currentUserDisplayName}',
                                unRead: true,
                              ),
                              ...mapToFirestore(
                                {
                                  'timeStapm': DateTime.now(),
                                },
                              ),
                            }, notificationsRecordReference);
                            triggerPushNotification(
                              notificationTitle:
                                  FFLocalizations.of(context).getVariableText(
                                ruText: 'Новое предложение по Вашей услуге',
                                mnText: 'Таны үйлчилгээнд шинэ санал',
                              ),
                              notificationText:
                                  FFLocalizations.of(context).getVariableText(
                                ruText: 'Новый отклик на Ваш заказ',
                                mnText: 'Таны захиалгын шинэ хариу',
                              ),
                              userRefs: [widget!.preferWorker!],
                              initialPageName: 'ServiceDetails',
                              parameterData: {
                                'serviceDoc': widget!.preferService,
                              },
                            );
                            // firstMessage

                            var messagesRecordReference =
                                MessagesRecord.collection.doc();
                            await messagesRecordReference.set({
                              ...createMessagesRecordData(
                                chat: _model.createChat?.reference,
                                whoSend: currentUserReference,
                                text: _model.textController.text,
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
                                chat: _model.createChat?.reference,
                                whoSend: currentUserReference,
                                text: _model.textController.text,
                              ),
                              ...mapToFirestore(
                                {
                                  'timestemp': DateTime.now(),
                                },
                              ),
                            }, messagesRecordReference);
                            // updateChat

                            await _model.createChat!.reference.update({
                              ...createChatsRecordData(
                                lastMessage: _model.textController.text,
                                lastMessageSender: currentUserReference,
                              ),
                              ...mapToFirestore(
                                {
                                  'members': FieldValue.arrayUnion(
                                      [widget!.preferWorker]),
                                  'messages': FieldValue.arrayUnion(
                                      [_model.createFirstMessage?.reference]),
                                  'last_message_time':
                                      FieldValue.serverTimestamp(),
                                  'last_message_seen_by': FieldValue.arrayUnion(
                                      [currentUserReference]),
                                },
                              ),
                            });
                            // updateCLient

                            await currentUserReference!.update({
                              ...createUserRecordData(
                                email: '',
                              ),
                              ...mapToFirestore(
                                {
                                  'my_works': FieldValue.arrayUnion(
                                      [_model.createWork?.reference]),
                                  'chats': FieldValue.arrayUnion(
                                      [_model.createChat?.reference]),
                                },
                              ),
                            });
                            // updateWorker

                            await widget!.preferWorker!.update({
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
                                      [_model.createChat?.reference]),
                                },
                              ),
                            });
                            // serviceAddResponce

                            await widget!.preferService!.update({
                              ...mapToFirestore(
                                {
                                  'responce': FieldValue.arrayUnion(
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
                                    child: ModalWindOfferOrderSuccesWidget(),
                                  ),
                                );
                              },
                            );

                            safeSetState(() {});
                          },
                    text: FFLocalizations.of(context).getText(
                      'st54c8p9' /* Отправить */,
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
