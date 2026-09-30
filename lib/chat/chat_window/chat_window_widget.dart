import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/debate_banner/debate_banner_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'chat_window_model.dart';
export 'chat_window_model.dart';

class ChatWindowWidget extends StatefulWidget {
  const ChatWindowWidget({
    super.key,
    required this.chatDoc,
  });

  final ChatsRecord? chatDoc;

  static String routeName = 'chatWindow';
  static String routePath = '/chatWindow';

  @override
  State<ChatWindowWidget> createState() => _ChatWindowWidgetState();
}

class _ChatWindowWidgetState extends State<ChatWindowWidget> {
  late ChatWindowModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatWindowModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await widget!.chatDoc!.reference.update({
        ...mapToFirestore(
          {
            'last_message_seen_by':
                FieldValue.arrayUnion([currentUserReference]),
          },
        ),
      });
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      await widget!.chatDoc!.reference.update({
        ...mapToFirestore(
          {
            'last_message_seen_by':
                FieldValue.arrayUnion([currentUserReference]),
          },
        ),
      });
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: wrapWithModel(
                  model: _model.titlewithbackModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TitlewithbackWidget(
                    title: widget!.chatDoc!.chatTitle,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<WorkRecord>(
                      stream: WorkRecord.getDocument(widget!.chatDoc!.work!),
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

                        final containerWorkRecord = snapshot.data!;

                        return Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          constraints: BoxConstraints(
                            maxWidth: 600.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 24.0, 12.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  WorkPageWidget.routeName,
                                  queryParameters: {
                                    'workRef': serializeParam(
                                      containerWorkRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (containerWorkRecord.hasFinishedTime())
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '4lwrmjch' /* Дата окончания */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            dateTimeFormat(
                                              "dd.MM.yy",
                                              containerWorkRecord.finishedTime,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .labelMediumIsCustom,
                                              ),
                                        ),
                                      ],
                                    ),
                                  Text(
                                    valueOrDefault<String>(
                                      widget!.chatDoc?.chatTitle,
                                      'errTitle',
                                    ),
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelMediumIsCustom,
                                        ),
                                  ),
                                  if ((widget!.chatDoc?.debateStatus != null) &&
                                      (containerWorkRecord.debateStatus !=
                                          DebateStatus.notStart))
                                    wrapWithModel(
                                      model: _model.debateBannerModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: DebateBannerWidget(
                                        disputeBanner:
                                            widget!.chatDoc!.debateStatus!,
                                      ),
                                    ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  child: StreamBuilder<List<MessagesRecord>>(
                    stream: queryMessagesRecord(
                      queryBuilder: (messagesRecord) => messagesRecord
                          .where(
                            'chat',
                            isEqualTo: widget!.chatDoc?.reference,
                          )
                          .orderBy('timestemp', descending: true),
                    ),
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
                      List<MessagesRecord> listViewMessagesRecordList =
                          snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          12.0,
                          0,
                          12.0,
                        ),
                        reverse: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewMessagesRecordList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewMessagesRecord =
                              listViewMessagesRecordList[listViewIndex];
                          return Builder(
                            builder: (context) {
                              if (listViewMessagesRecord.whoSend !=
                                  currentUserReference) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder<UserRecord>(
                                          stream: UserRecord.getDocument(
                                              listViewMessagesRecord.whoSend!),
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

                                            final avatarMiniUserRecord =
                                                snapshot.data!;

                                            return AvatarMiniWidget(
                                              key: Key(
                                                  'Keymbr_${listViewIndex}_of_${listViewMessagesRecordList.length}'),
                                              sizeAva: 32,
                                              sizeLetter: 24,
                                              avaURL:
                                                  avatarMiniUserRecord.photoUrl,
                                              nameLetter: avatarMiniUserRecord
                                                  .displayName,
                                            );
                                          },
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .accent4,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                              )
                                            ],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16.0),
                                              bottomRight:
                                                  Radius.circular(16.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(16.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 200.0,
                                                  ),
                                                  decoration: BoxDecoration(),
                                                  child: Text(
                                                    listViewMessagesRecord.text,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 15,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                if (listViewMessagesRecord
                                                            .document !=
                                                        null &&
                                                    listViewMessagesRecord
                                                            .document !=
                                                        '')
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        FlutterFlowIconButton(
                                                          borderRadius: 100.0,
                                                          buttonSize: 48.0,
                                                          fillColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          icon: Icon(
                                                            FFIcons.kdocument2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            await downloadFile(
                                                              filename:
                                                                  listViewMessagesRecord
                                                                      .document,
                                                              url:
                                                                  listViewMessagesRecord
                                                                      .document,
                                                            );
                                                          },
                                                        ),
                                                        ClipRRect(
                                                          child: Container(
                                                            width: 200.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Text(
                                                              listViewMessagesRecord
                                                                  .document
                                                                  .maybeHandleOverflow(
                                                                maxChars: 30,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                if (listViewMessagesRecord
                                                    .image.isNotEmpty)
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final mediaInMessage =
                                                            listViewMessagesRecord
                                                                .image
                                                                .toList();

                                                        return Wrap(
                                                          spacing: 12.0,
                                                          runSpacing: 12.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: List.generate(
                                                              mediaInMessage
                                                                  .length,
                                                              (mediaInMessageIndex) {
                                                            final mediaInMessageItem =
                                                                mediaInMessage[
                                                                    mediaInMessageIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        FlutterFlowExpandedImageView(
                                                                      image: Image
                                                                          .network(
                                                                        mediaInMessageItem,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag:
                                                                          mediaInMessageItem,
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag:
                                                                    mediaInMessageItem,
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    mediaInMessageItem,
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        100.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                              "yMd",
                                                              listViewMessagesRecord
                                                                  .timestemp,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) ==
                                                            dateTimeFormat(
                                                              "yMd",
                                                              getCurrentTimestamp,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                        ? dateTimeFormat(
                                                            "Hm",
                                                            listViewMessagesRecord
                                                                .timestemp!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )
                                                        : dateTimeFormat(
                                                            "dd.MM.yy",
                                                            listViewMessagesRecord
                                                                .timestemp!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF5089FD),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                              )
                                            ],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16.0),
                                              bottomRight:
                                                  Radius.circular(16.0),
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 200.0,
                                                  ),
                                                  decoration: BoxDecoration(),
                                                  child: Text(
                                                    listViewMessagesRecord.text,
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                if (listViewMessagesRecord
                                                            .document !=
                                                        null &&
                                                    listViewMessagesRecord
                                                            .document !=
                                                        '')
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await downloadFile(
                                                        filename:
                                                            listViewMessagesRecord
                                                                .document,
                                                        url:
                                                            listViewMessagesRecord
                                                                .document,
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        FlutterFlowIconButton(
                                                          borderRadius: 100.0,
                                                          buttonSize: 48.0,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          icon: Icon(
                                                            FFIcons.kdocument2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            await downloadFile(
                                                              filename:
                                                                  listViewMessagesRecord
                                                                      .document,
                                                              url:
                                                                  listViewMessagesRecord
                                                                      .document,
                                                            );
                                                          },
                                                        ),
                                                        Container(
                                                          width: 200.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            listViewMessagesRecord
                                                                .document
                                                                .maybeHandleOverflow(
                                                              maxChars: 30,
                                                              replacement: '…',
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 12.0)),
                                                    ),
                                                  ),
                                                if (listViewMessagesRecord
                                                    .image.isNotEmpty)
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final mediaInMessage =
                                                            listViewMessagesRecord
                                                                .image
                                                                .toList();

                                                        return Wrap(
                                                          spacing: 12.0,
                                                          runSpacing: 12.0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: List.generate(
                                                              mediaInMessage
                                                                  .length,
                                                              (mediaInMessageIndex) {
                                                            final mediaInMessageItem =
                                                                mediaInMessage[
                                                                    mediaInMessageIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        FlutterFlowExpandedImageView(
                                                                      image: Image
                                                                          .network(
                                                                        mediaInMessageItem,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag:
                                                                          mediaInMessageItem,
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag:
                                                                    mediaInMessageItem,
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    mediaInMessageItem,
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        100.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                              "yMd",
                                                              listViewMessagesRecord
                                                                  .timestemp,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) ==
                                                            dateTimeFormat(
                                                              "yMd",
                                                              getCurrentTimestamp,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                        ? dateTimeFormat(
                                                            "Hm",
                                                            listViewMessagesRecord
                                                                .timestemp!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )
                                                        : dateTimeFormat(
                                                            "dd.MM.yy",
                                                            listViewMessagesRecord
                                                                .timestemp!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              if (_model.uploadedPhoto.isNotEmpty)
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  constraints: BoxConstraints(
                    minWidth: 600.0,
                    maxHeight: 300.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(
                          0.0,
                          -2.0,
                        ),
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                    child: Builder(
                      builder: (context) {
                        final uploadCard =
                            _model.uploadedPhoto.toList().take(5).toList();

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(uploadCard.length,
                                    (uploadCardIndex) {
                              final uploadCardItem =
                                  uploadCard[uploadCardIndex];
                              return Container(
                                width: 86.0,
                                height: 86.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.memory(
                                        uploadCardItem.bytes ??
                                            Uint8List.fromList([]),
                                        width: 86.0,
                                        height: 86.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 30.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        icon: Icon(
                                          Icons.close,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 14.0,
                                        ),
                                        onPressed: () async {
                                          _model.removeFromUploadedPhoto(
                                              uploadCardItem);
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                                .divide(SizedBox(width: 12.0))
                                .addToStart(SizedBox(width: 12.0))
                                .addToEnd(SizedBox(width: 12.0)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (_model.showMenu)
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: 360.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 100.0,
                                  buttonSize: 72.0,
                                  fillColor: Color(0x33A7C4FE),
                                  disabledColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  disabledIconColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  icon: Icon(
                                    FFIcons.kdocument2,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 32.0,
                                  ),
                                  onPressed: (_model.uploadedPhoto.length > 4)
                                      ? null
                                      : () async {
                                          final selectedFiles =
                                              await selectFiles(
                                            multiFile: false,
                                          );
                                          if (selectedFiles != null) {
                                            safeSetState(() => _model
                                                    .isDataUploading_uploadDataDOCMob =
                                                true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              selectedUploadedFiles =
                                                  selectedFiles
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                              ))
                                                      .toList();

                                              downloadUrls = (await Future.wait(
                                                selectedFiles.map(
                                                  (f) async => await uploadData(
                                                      f.storagePath, f.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              _model.isDataUploading_uploadDataDOCMob =
                                                  false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedFiles.length &&
                                                downloadUrls.length ==
                                                    selectedFiles.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile_uploadDataDOCMob =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl_uploadDataDOCMob =
                                                    downloadUrls.first;
                                              });
                                            } else {
                                              safeSetState(() {});
                                              return;
                                            }
                                          }

                                          var messagesRecordReference =
                                              MessagesRecord.collection.doc();
                                          await messagesRecordReference
                                              .set(createMessagesRecordData(
                                            chat: widget!.chatDoc?.reference,
                                            whoSend: currentUserReference,
                                            timestemp: getCurrentTimestamp,
                                            document: _model
                                                .uploadedFileUrl_uploadDataDOCMob,
                                          ));
                                          _model.newMessDoc = MessagesRecord
                                              .getDocumentFromData(
                                                  createMessagesRecordData(
                                                    chat: widget!
                                                        .chatDoc?.reference,
                                                    whoSend:
                                                        currentUserReference,
                                                    timestemp:
                                                        getCurrentTimestamp,
                                                    document: _model
                                                        .uploadedFileUrl_uploadDataDOCMob,
                                                  ),
                                                  messagesRecordReference);
                                          triggerPushNotification(
                                            notificationTitle:
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              ruText: 'У вас новое сообщение',
                                              mnText: 'Танд захидал байна',
                                            ),
                                            notificationText: '',
                                            userRefs: widget!.chatDoc!.members
                                                .toList(),
                                            initialPageName: 'chatWindow',
                                            parameterData: {
                                              'chatDoc': widget!.chatDoc,
                                            },
                                          );

                                          await widget!.chatDoc!.reference
                                              .update({
                                            ...createChatsRecordData(
                                              lastMessage:
                                                  _model.newMessDoc?.document,
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSender:
                                                  currentUserReference,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'last_message_seen_by':
                                                    FieldValue.delete(),
                                                'messages':
                                                    FieldValue.arrayUnion([
                                                  _model.newMessDoc?.reference
                                                ]),
                                              },
                                            ),
                                          });
                                          _model.showMenu = false;
                                          safeSetState(() {});

                                          await widget!.chatDoc!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'last_message_seen_by':
                                                    FieldValue.arrayUnion(
                                                        [currentUserReference]),
                                              },
                                            ),
                                          });

                                          safeSetState(() {});
                                        },
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'l1nafdle' /* Документ */,
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
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                            if (() {
                              if (MediaQuery.sizeOf(context).width <
                                  kBreakpointSmall) {
                                return true;
                              } else if (MediaQuery.sizeOf(context).width <
                                  kBreakpointMedium) {
                                return true;
                              } else if (MediaQuery.sizeOf(context).width <
                                  kBreakpointLarge) {
                                return false;
                              } else {
                                return false;
                              }
                            }())
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 100.0,
                                    buttonSize: 72.0,
                                    fillColor: Color(0x33A7C4FE),
                                    disabledColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    disabledIconColor:
                                        FlutterFlowTheme.of(context).accent1,
                                    icon: Icon(
                                      FFIcons.kcamera2,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 32.0,
                                    ),
                                    onPressed: (_model.uploadedPhoto.length > 4)
                                        ? null
                                        : () async {
                                            final selectedMedia =
                                                await selectMedia(
                                              maxWidth: 1920.00,
                                              maxHeight: 1920.00,
                                              multiImage: false,
                                            );
                                            if (selectedMedia != null &&
                                                selectedMedia.every((m) =>
                                                    validateFileFormat(
                                                        m.storagePath,
                                                        context))) {
                                              safeSetState(() => _model
                                                      .isDataUploading_uploadDataCameraMob =
                                                  true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              try {
                                                selectedUploadedFiles =
                                                    selectedMedia
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                            ))
                                                        .toList();
                                              } finally {
                                                _model.isDataUploading_uploadDataCameraMob =
                                                    false;
                                              }
                                              if (selectedUploadedFiles
                                                      .length ==
                                                  selectedMedia.length) {
                                                safeSetState(() {
                                                  _model.uploadedLocalFile_uploadDataCameraMob =
                                                      selectedUploadedFiles
                                                          .first;
                                                });
                                              } else {
                                                safeSetState(() {});
                                                return;
                                              }
                                            }

                                            _model.addToUploadedPhoto(_model
                                                .uploadedLocalFile_uploadDataCameraMob);
                                            _model.showMenu = false;
                                            safeSetState(() {});
                                            triggerPushNotification(
                                              notificationTitle:
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                ruText: 'У вас новое сообщение',
                                                mnText: 'Танд захидал байна',
                                              ),
                                              notificationText: '',
                                              userRefs: widget!.chatDoc!.members
                                                  .toList(),
                                              initialPageName: 'chatWindow',
                                              parameterData: {
                                                'chatDoc': widget!.chatDoc,
                                              },
                                            );
                                            safeSetState(() {
                                              _model.isDataUploading_uploadDataCameraMob =
                                                  false;
                                              _model.uploadedLocalFile_uploadDataCameraMob =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                            });
                                          },
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '85q46ni2' /* Камера */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 100.0,
                                  buttonSize: 72.0,
                                  fillColor: Color(0x33A7C4FE),
                                  icon: Icon(
                                    Icons.image_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 32.0,
                                  ),
                                  onPressed: (_model.uploadedPhoto.length > 4)
                                      ? null
                                      : () async {
                                          final selectedMedia =
                                              await selectMedia(
                                            maxWidth: 1920.00,
                                            maxHeight: 1920.00,
                                            mediaSource:
                                                MediaSource.photoGallery,
                                            multiImage: false,
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) =>
                                                  validateFileFormat(
                                                      m.storagePath,
                                                      context))) {
                                            safeSetState(() => _model
                                                    .isDataUploading_uploadDataGalleryMob =
                                                true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            try {
                                              selectedUploadedFiles =
                                                  selectedMedia
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                      .toList();
                                            } finally {
                                              _model.isDataUploading_uploadDataGalleryMob =
                                                  false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                selectedMedia.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile_uploadDataGalleryMob =
                                                    selectedUploadedFiles.first;
                                              });
                                            } else {
                                              safeSetState(() {});
                                              return;
                                            }
                                          }

                                          _model.addToUploadedPhoto(_model
                                              .uploadedLocalFile_uploadDataGalleryMob);
                                          _model.showMenu = false;
                                          safeSetState(() {});
                                          triggerPushNotification(
                                            notificationTitle:
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              ruText: 'У вас новое сообщение',
                                              mnText: 'Танд захидал байна',
                                            ),
                                            notificationText: '',
                                            userRefs: widget!.chatDoc!.members
                                                .toList(),
                                            initialPageName: 'chatWindow',
                                            parameterData: {
                                              'chatDoc': widget!.chatDoc,
                                            },
                                          );
                                          safeSetState(() {
                                            _model.isDataUploading_uploadDataGalleryMob =
                                                false;
                                            _model.uploadedLocalFile_uploadDataGalleryMob =
                                                FFUploadedFile(
                                                    bytes:
                                                        Uint8List.fromList([]));
                                          });
                                        },
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'hnb61xpf' /* Галерея */,
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
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ].divide(SizedBox(width: 24.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                constraints: BoxConstraints(
                  maxWidth: 1000.0,
                  maxHeight: 300.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(
                        0.0,
                        -2.0,
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController',
                            Duration(milliseconds: 10),
                            () async {
                              safeSetState(() {
                                _model.textController?.text =
                                    (_model.textController.text.trim());
                              });
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: FFLocalizations.of(context).getText(
                              'svqvd7tv' /* Напишите... */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            hoverColor: FlutterFlowTheme.of(context).secondary,
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
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          maxLength: 600,
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
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.attach_file,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          _model.showMenu = !_model.showMenu;
                          safeSetState(() {});
                        },
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 100.0,
                        buttonSize: 56.0,
                        fillColor: FlutterFlowTheme.of(context).primary,
                        disabledColor: FlutterFlowTheme.of(context).secondary,
                        icon: Icon(
                          FFIcons.ksend,
                          color: FlutterFlowTheme.of(context).info,
                          size: 24.0,
                        ),
                        showLoadingIndicator: true,
                        onPressed: ((_model.textController.text == null ||
                                    _model.textController.text == '') &&
                                !(_model.uploadedPhoto.isNotEmpty))
                            ? null
                            : () async {
                                {
                                  safeSetState(() => _model
                                          .isDataUploading_uploadPhotoMessInFirebaseMob =
                                      true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];
                                  var selectedMedia = <SelectedFile>[];
                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles =
                                        _model.uploadedPhoto;
                                    selectedMedia =
                                        selectedFilesFromUploadedFiles(
                                      selectedUploadedFiles,
                                      isMultiData: true,
                                    );
                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(
                                            m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    _model.isDataUploading_uploadPhotoMessInFirebaseMob =
                                        false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    safeSetState(() {
                                      _model.uploadedLocalFiles_uploadPhotoMessInFirebaseMob =
                                          selectedUploadedFiles;
                                      _model.uploadedFileUrls_uploadPhotoMessInFirebaseMob =
                                          downloadUrls;
                                    });
                                  } else {
                                    safeSetState(() {});
                                    return;
                                  }
                                }

                                var messagesRecordReference =
                                    MessagesRecord.collection.doc();
                                await messagesRecordReference.set({
                                  ...createMessagesRecordData(
                                    chat: widget!.chatDoc?.reference,
                                    whoSend: currentUserReference,
                                    timestemp: getCurrentTimestamp,
                                    text: _model.textController.text,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'image': _model
                                          .uploadedFileUrls_uploadPhotoMessInFirebaseMob,
                                    },
                                  ),
                                });
                                _model.newMessTextOrPhoto =
                                    MessagesRecord.getDocumentFromData({
                                  ...createMessagesRecordData(
                                    chat: widget!.chatDoc?.reference,
                                    whoSend: currentUserReference,
                                    timestemp: getCurrentTimestamp,
                                    text: _model.textController.text,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'image': _model
                                          .uploadedFileUrls_uploadPhotoMessInFirebaseMob,
                                    },
                                  ),
                                }, messagesRecordReference);
                                _model.showMenu = false;
                                _model.uploadedPhoto = [];
                                safeSetState(() {});

                                await widget!.chatDoc!.reference.update({
                                  ...createChatsRecordData(
                                    lastMessage: _model.textController.text,
                                    lastMessageTime: getCurrentTimestamp,
                                    lastMessageSender: currentUserReference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'last_message_seen_by':
                                          FieldValue.delete(),
                                      'messages': FieldValue.arrayUnion([
                                        _model.newMessTextOrPhoto?.reference
                                      ]),
                                    },
                                  ),
                                });
                                triggerPushNotification(
                                  notificationTitle: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'У вас новое сообщение',
                                    mnText: 'Танд захидал байна',
                                  ),
                                  notificationText: '',
                                  userRefs: widget!.chatDoc!.members.toList(),
                                  initialPageName: 'chatWindow',
                                  parameterData: {
                                    'chatDoc': widget!.chatDoc,
                                  },
                                );

                                await widget!.chatDoc!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'last_message_seen_by':
                                          FieldValue.arrayUnion(
                                              [currentUserReference]),
                                    },
                                  ),
                                });
                                safeSetState(() {
                                  _model.textController?.clear();
                                });

                                safeSetState(() {});
                              },
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
              ),
            ].addToStart(SizedBox(height: 40.0)),
          ),
        ),
      ),
    );
  }
}
