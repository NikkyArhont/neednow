import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import '/work/modal_wind_debate_open/modal_wind_debate_open_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_debate_model.dart';
export 'create_debate_model.dart';

class CreateDebateWidget extends StatefulWidget {
  const CreateDebateWidget({
    super.key,
    required this.workDoc,
  });

  final WorkRecord? workDoc;

  static String routeName = 'createDebate';
  static String routePath = '/createDebate';

  @override
  State<CreateDebateWidget> createState() => _CreateDebateWidgetState();
}

class _CreateDebateWidgetState extends State<CreateDebateWidget> {
  late CreateDebateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateDebateModel());

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
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      child: wrapWithModel(
                        model: _model.titlewithbackModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TitlewithbackWidget(
                          title: FFLocalizations.of(context).getText(
                            '6xh4482h' /* Открыть спор */,
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<OrdersRecord>(
                      stream: OrdersRecord.getDocument(widget!.workDoc!.order!),
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

                        final jobCardLiteOrdersRecord = snapshot.data!;

                        return wrapWithModel(
                          model: _model.jobCardLiteModel,
                          updateCallback: () => safeSetState(() {}),
                          child: JobCardLiteWidget(
                            price: widget!.workDoc!.agreedPrice,
                            titleCategory: functions.searchCatTitles(
                                FFAppState().saveCat.toList(),
                                jobCardLiteOrdersRecord.category!),
                            orderCity: jobCardLiteOrdersRecord.locationTitle,
                            jobTitle: jobCardLiteOrdersRecord.title,
                            userData: widget!.workDoc!.client!,
                            orderDoc: jobCardLiteOrdersRecord,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'o71y4sk0' /* Обращение */,
                              ),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 80.0,
                              constraints: BoxConstraints(
                                maxWidth: 600.0,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Container(
                                width: 360.0,
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '74v9fy2b' /* Введите */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
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
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
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
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                  maxLines: null,
                                  maxLength: 300,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: FFLocalizations.of(context).getText(
                          'apeb3jqc' /* Отменить */,
                        ),
                        options: FFButtonOptions(
                          width: 360.0,
                          height: 58.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFE9F0FF),
                          textStyle:
                              FlutterFlowTheme.of(context).labelLarge.override(
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
                    Flexible(
                      child: Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: (_model.textController.text == null ||
                                  _model.textController.text == '')
                              ? null
                              : () async {
                                  await widget!.workDoc!.reference
                                      .update(createWorkRecordData(
                                    workStatus: ResponseType.dispute,
                                    debateStatus: DebateStatus.open,
                                    dabateMessage: _model.textController.text,
                                    debateAuthor: currentUserReference,
                                  ));

                                  var messagesRecordReference =
                                      MessagesRecord.collection.doc();
                                  await messagesRecordReference
                                      .set(createMessagesRecordData(
                                    chat: widget!.workDoc?.workChat,
                                    whoSend: currentUserReference,
                                    text:
                                        '${FFLocalizations.of(context).getVariableText(
                                      ruText: 'Претензия: ',
                                      mnText: 'Нэхэмжлэл: ',
                                    )}${_model.textController.text}',
                                    timestemp: getCurrentTimestamp,
                                    debateMess: DebateStatus.open,
                                  ));
                                  _model.debateMesChat =
                                      MessagesRecord.getDocumentFromData(
                                          createMessagesRecordData(
                                            chat: widget!.workDoc?.workChat,
                                            whoSend: currentUserReference,
                                            text:
                                                '${FFLocalizations.of(context).getVariableText(
                                              ruText: 'Претензия: ',
                                              mnText: 'Нэхэмжлэл: ',
                                            )}${_model.textController.text}',
                                            timestemp: getCurrentTimestamp,
                                            debateMess: DebateStatus.open,
                                          ),
                                          messagesRecordReference);

                                  await widget!.workDoc!.workChat!.update({
                                    ...createChatsRecordData(
                                      lastMessage: _model.debateMesChat?.text,
                                      lastMessageTime:
                                          _model.debateMesChat?.timestemp,
                                      debateStatus: DebateStatus.open,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'messages': FieldValue.arrayUnion(
                                            [_model.debateMesChat?.reference]),
                                      },
                                    ),
                                  });
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: ModalWindDebateOpenWidget(
                                            workRef: widget!.workDoc!.reference,
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  safeSetState(() {});
                                },
                          text: FFLocalizations.of(context).getText(
                            '36caeo49' /* Отправить */,
                          ),
                          options: FFButtonOptions(
                            width: 360.0,
                            height: 58.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
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
                            disabledColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 24.0)),
                ),
              ),
            ].divide(SizedBox(height: 40.0)).addToStart(SizedBox(height: 40.0)),
          ),
        ),
      ),
    );
  }
}
