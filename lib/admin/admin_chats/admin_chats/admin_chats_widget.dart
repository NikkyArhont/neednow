import '/admin/admin_menu/admin_menu_widget.dart';
import '/admin/admin_top/admin_top_widget.dart';
import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/chat_card/chat_card_widget.dart';
import '/chat/debate_banner/debate_banner_widget.dart';
import '/empty_list_widget/emtpy_no_chats/emtpy_no_chats_widget.dart';
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
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'admin_chats_model.dart';
export 'admin_chats_model.dart';

class AdminChatsWidget extends StatefulWidget {
  const AdminChatsWidget({super.key});

  static String routeName = 'adminChats';
  static String routePath = '/adminChats';

  @override
  State<AdminChatsWidget> createState() => _AdminChatsWidgetState();
}

class _AdminChatsWidgetState extends State<AdminChatsWidget>
    with TickerProviderStateMixin {
  late AdminChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminChatsModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        SingleActivator(
          LogicalKeyboardKey.enter,
        ): VoidCallbackIntent(() async {
          {
            safeSetState(() =>
                _model.isDataUploading_uploadPhotoMessInFirebaseEnter = true);
            var selectedUploadedFiles = <FFUploadedFile>[];
            var selectedMedia = <SelectedFile>[];
            var downloadUrls = <String>[];
            try {
              selectedUploadedFiles = _model.uploadedPhoto;
              selectedMedia = selectedFilesFromUploadedFiles(
                selectedUploadedFiles,
                isMultiData: true,
              );
              downloadUrls = (await Future.wait(
                selectedMedia.map(
                  (m) async => await uploadData(m.storagePath, m.bytes),
                ),
              ))
                  .where((u) => u != null)
                  .map((u) => u!)
                  .toList();
            } finally {
              _model.isDataUploading_uploadPhotoMessInFirebaseEnter = false;
            }
            if (selectedUploadedFiles.length == selectedMedia.length &&
                downloadUrls.length == selectedMedia.length) {
              safeSetState(() {
                _model.uploadedLocalFiles_uploadPhotoMessInFirebaseEnter =
                    selectedUploadedFiles;
                _model.uploadedFileUrls_uploadPhotoMessInFirebaseEnter =
                    downloadUrls;
              });
            } else {
              safeSetState(() {});
              return;
            }
          }

          var messagesRecordReference = MessagesRecord.collection.doc();
          await messagesRecordReference.set({
            ...createMessagesRecordData(
              chat: _model.choosenChat?.reference,
              whoSend: currentUserReference,
              timestemp: getCurrentTimestamp,
              text: valueOrDefault<String>(
                _model.textController2.text,
                'Файл',
              ),
            ),
            ...mapToFirestore(
              {
                'image': _model.uploadedFileUrls_uploadPhotoMessInFirebase,
              },
            ),
          });
          _model.newMessTextOrPhotoCopy = MessagesRecord.getDocumentFromData({
            ...createMessagesRecordData(
              chat: _model.choosenChat?.reference,
              whoSend: currentUserReference,
              timestemp: getCurrentTimestamp,
              text: valueOrDefault<String>(
                _model.textController2.text,
                'Файл',
              ),
            ),
            ...mapToFirestore(
              {
                'image': _model.uploadedFileUrls_uploadPhotoMessInFirebase,
              },
            ),
          }, messagesRecordReference);
          triggerPushNotification(
            notificationTitle: FFLocalizations.of(context).getVariableText(
              ruText: 'У вас новое сообщение',
              mnText: 'Танд захидал байна',
            ),
            notificationText: '',
            userRefs: _model.choosenChat!.members.toList(),
            initialPageName: 'chatWindow',
            parameterData: {
              'chatDoc': _model.choosenChat,
            },
          );

          await _model.choosenChat!.reference.update({
            ...createChatsRecordData(
              lastMessage: _model.textController2.text,
              lastMessageTime: getCurrentTimestamp,
              lastMessageSender: currentUserReference,
            ),
            ...mapToFirestore(
              {
                'last_message_seen_by': FieldValue.delete(),
                'messages': FieldValue.arrayUnion(
                    [_model.newMessTextOrPhotoCopy?.reference]),
              },
            ),
          });

          await _model.choosenChat!.reference.update({
            ...mapToFirestore(
              {
                'last_message_seen_by':
                    FieldValue.arrayUnion([currentUserReference]),
              },
            ),
          });
          _model.showMenu = false;
          safeSetState(() {});
          safeSetState(() {
            _model.isDataUploading_uploadDataDOCW = false;
            _model.uploadedLocalFile_uploadDataDOCW =
                FFUploadedFile(bytes: Uint8List.fromList([]));
            _model.uploadedFileUrl_uploadDataDOCW = '';
          });

          safeSetState(() {
            _model.isDataUploading_uploadDataGallery = false;
            _model.uploadedLocalFile_uploadDataGallery =
                FFUploadedFile(bytes: Uint8List.fromList([]));
          });

          safeSetState(() {
            _model.isDataUploading_uploadPhotoMessInFirebaseEnter = false;
            _model.uploadedLocalFiles_uploadPhotoMessInFirebaseEnter = [];
            _model.uploadedFileUrls_uploadPhotoMessInFirebaseEnter = [];
          });

          safeSetState(() {
            _model.textController2?.clear();
          });

          safeSetState(() {});
        }),
      },
      child: Actions(
        actions: {
          VoidCallbackIntent: CallbackAction<VoidCallbackIntent>(
            onInvoke: (intent) => intent.callback(),
          ),
        },
        child: Focus(
            autofocus: isShortcutsSupported,
            focusNode: _model.shortcutsFocusNode,
            child: GestureDetector(
              onTap: () {
                if (isShortcutsSupported &&
                    _model.shortcutsFocusNode.canRequestFocus) {
                  FocusScope.of(context)
                      .requestFocus(_model.shortcutsFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: SafeArea(
                  top: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: wrapWithModel(
                          model: _model.adminMenuModel,
                          updateCallback: () => safeSetState(() {}),
                          child: AdminMenuWidget(
                            currentAdminPage: AdminMenu.chats,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: StreamBuilder<List<ChatsRecord>>(
                          stream: queryChatsRecord(
                            queryBuilder: (chatsRecord) => chatsRecord.where(
                              'members',
                              arrayContains: currentUserReference,
                            ),
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
                            List<ChatsRecord> containerChatsRecordList =
                                snapshot.data!;

                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    wrapWithModel(
                                      model: _model.adminTopModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: AdminTopWidget(
                                        title:
                                            FFLocalizations.of(context).getText(
                                          'ug243g79' /* Чаты */,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment(0.0, 0),
                                            child: TabBar(
                                              labelColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              unselectedLabelColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMediumIsCustom,
                                                      ),
                                              unselectedLabelStyle: TextStyle(),
                                              indicatorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              tabs: [
                                                Tab(
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'pjlr98ea' /* Мои чаты */,
                                                  ),
                                                ),
                                                Tab(
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'kwkj2935' /* Открытые споры */,
                                                  ),
                                                ),
                                              ],
                                              controller:
                                                  _model.tabBarController,
                                              onTap: (i) async {
                                                [() async {}, () async {}][i]();
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              controller:
                                                  _model.tabBarController,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 24.0, 0.0, 0.0),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 1440.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 4,
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 1.0),
                                                            child: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth: 400.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            24.0),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            360.0,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _model.textController1,
                                                                          focusNode:
                                                                              _model.textFieldFocusNode1,
                                                                          onChanged: (_) =>
                                                                              EasyDebounce.debounce(
                                                                            '_model.textController1',
                                                                            Duration(milliseconds: 100),
                                                                            () async {
                                                                              safeSetState(() {
                                                                                _model.simpleSearchResults = TextSearch(
                                                                                  containerChatsRecordList
                                                                                      .map(
                                                                                        (record) => TextSearchItem.fromTerms(record, [
                                                                                          record.chatTitle!
                                                                                        ]),
                                                                                      )
                                                                                      .toList(),
                                                                                ).search(_model.textController1.text).map((r) => r.object).toList();
                                                                                ;
                                                                              });
                                                                              _model.searchActive = true;
                                                                              safeSetState(() {});
                                                                            },
                                                                          ),
                                                                          autofocus:
                                                                              false,
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            isDense:
                                                                                false,
                                                                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                                ),
                                                                            hintText:
                                                                                FFLocalizations.of(context).getText(
                                                                              '7sh74fzc' /* Поиск */,
                                                                            ),
                                                                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                  color: Color(0xFFBDBDBD),
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                                ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color(0x00000000),
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color(0x00000000),
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            focusedErrorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor: (_model.textFieldFocusNode1?.hasFocus ?? false)
                                                                                ? FlutterFlowTheme.of(context).secondary
                                                                                : FlutterFlowTheme.of(context).accent4,
                                                                            prefixIcon:
                                                                                Icon(
                                                                              Icons.search,
                                                                              size: 20.0,
                                                                            ),
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                              ),
                                                                          maxLength:
                                                                              40,
                                                                          buildCounter: (context, {required currentLength, required isFocused, maxLength}) =>
                                                                              null,
                                                                          cursorColor:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          validator: _model
                                                                              .textController1Validator
                                                                              .asValidator(context),
                                                                        ),
                                                                      ),
                                                                      if (!_model
                                                                          .searchActive)
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final mychats =
                                                                                containerChatsRecordList.where((e) => e.members.contains(currentUserReference)).toList().sortedList(keyOf: (e) => e.lastMessageTime!, desc: true).toList();
                                                                            if (mychats.isEmpty) {
                                                                              return EmtpyNoChatsWidget();
                                                                            }

                                                                            return ListView.separated(
                                                                              padding: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                12.0,
                                                                                0,
                                                                                12.0,
                                                                              ),
                                                                              primary: false,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: mychats.length,
                                                                              separatorBuilder: (_, __) => SizedBox(height: 12.0),
                                                                              itemBuilder: (context, mychatsIndex) {
                                                                                final mychatsItem = mychats[mychatsIndex];
                                                                                return Container(
                                                                                  width: 390.0,
                                                                                  height: 90.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: _model.choosenChat?.reference == mychatsItem.reference ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryBackground,
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await mychatsItem.reference.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'last_message_seen_by': FieldValue.arrayUnion([
                                                                                                currentUserReference
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.choosenWork = mychatsItem.work;
                                                                                        _model.choosenChat = mychatsItem;
                                                                                        safeSetState(() {});
                                                                                      },
                                                                                      child: ChatCardWidget(
                                                                                        key: Key('Keye2v_${mychatsIndex}_of_${mychats.length}'),
                                                                                        lastmessageText: mychatsItem.lastMessage,
                                                                                        chatTitle: mychatsItem.chatTitle,
                                                                                        newMess: mychatsItem.lastMessageSeenBy.contains(currentUserReference),
                                                                                        last: mychatsItem.lastMessageSender!,
                                                                                        lastMessageTime: mychatsItem.lastMessageTime!,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                      if (_model
                                                                          .searchActive)
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final mychatsSearch =
                                                                                _model.simpleSearchResults.where((e) => e.members.contains(currentUserReference)).toList().sortedList(keyOf: (e) => e.lastMessageTime!, desc: false).toList();
                                                                            if (mychatsSearch.isEmpty) {
                                                                              return EmtpyNoChatsWidget();
                                                                            }

                                                                            return ListView.separated(
                                                                              padding: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                12.0,
                                                                                0,
                                                                                12.0,
                                                                              ),
                                                                              primary: false,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: mychatsSearch.length,
                                                                              separatorBuilder: (_, __) => SizedBox(height: 12.0),
                                                                              itemBuilder: (context, mychatsSearchIndex) {
                                                                                final mychatsSearchItem = mychatsSearch[mychatsSearchIndex];
                                                                                return Container(
                                                                                  width: 390.0,
                                                                                  height: 90.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: _model.choosenChat?.reference == mychatsSearchItem.reference ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryBackground,
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await mychatsSearchItem.reference.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'last_message_seen_by': FieldValue.arrayUnion([
                                                                                                currentUserReference
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.choosenWork = mychatsSearchItem.work;
                                                                                        _model.choosenChat = mychatsSearchItem;
                                                                                        safeSetState(() {});
                                                                                      },
                                                                                      child: ChatCardWidget(
                                                                                        key: Key('Keykwt_${mychatsSearchIndex}_of_${mychatsSearch.length}'),
                                                                                        lastmessageText: mychatsSearchItem.lastMessage,
                                                                                        chatTitle: mychatsSearchItem.chatTitle,
                                                                                        newMess: mychatsSearchItem.lastMessageSeenBy.contains(currentUserReference),
                                                                                        last: mychatsSearchItem.lastMessageSender!,
                                                                                        lastMessageTime: mychatsSearchItem.lastMessageTime!,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (_model
                                                                .choosenChat !=
                                                            null)
                                                          Flexible(
                                                            flex: 10,
                                                            child: StreamBuilder<
                                                                List<
                                                                    MessagesRecord>>(
                                                              stream:
                                                                  queryMessagesRecord(
                                                                queryBuilder:
                                                                    (messagesRecord) =>
                                                                        messagesRecord
                                                                            .where(
                                                                  'chat',
                                                                  isEqualTo: _model
                                                                      .choosenChat
                                                                      ?.reference,
                                                                ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<MessagesRecord>
                                                                    containerMessagesRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          WorkRecord>(
                                                                        stream:
                                                                            WorkRecord.getDocument(_model.choosenWork!),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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

                                                                          final headWorkRecord =
                                                                              snapshot.data!;

                                                                          return Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                1.0,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      AdminWorkCardWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'workCard': serializeParam(
                                                                                          headWorkRecord,
                                                                                          ParamType.Document,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                      extra: <String, dynamic>{
                                                                                        'workCard': headWorkRecord,
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        headWorkRecord.workTitle,
                                                                                        maxLines: 1,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 16.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
                                                                                            ),
                                                                                      ),
                                                                                      wrapWithModel(
                                                                                        model: _model.debateBannerModel,
                                                                                        updateCallback: () => safeSetState(() {}),
                                                                                        child: DebateBannerWidget(
                                                                                          disputeBanner: headWorkRecord.debateStatus!,
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 12.0)).addToStart(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              12.0,
                                                                              0.0,
                                                                              12.0,
                                                                              0.0),
                                                                          child:
                                                                              Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final loadingMessagesWindow = containerMessagesRecordList.map((e) => e).toList().sortedList(keyOf: (e) => e.timestemp!, desc: true).toList();

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
                                                                                itemCount: loadingMessagesWindow.length,
                                                                                separatorBuilder: (_, __) => SizedBox(height: 12.0),
                                                                                itemBuilder: (context, loadingMessagesWindowIndex) {
                                                                                  final loadingMessagesWindowItem = loadingMessagesWindow[loadingMessagesWindowIndex];
                                                                                  return Builder(
                                                                                    builder: (context) {
                                                                                      if (currentUserReference != currentUserReference) {
                                                                                        return Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                StreamBuilder<UserRecord>(
                                                                                                  stream: UserRecord.getDocument(loadingMessagesWindowItem.whoSend!),
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

                                                                                                    final avatarMiniUserRecord = snapshot.data!;

                                                                                                    return AvatarMiniWidget(
                                                                                                      key: Key('Keynss_${loadingMessagesWindowIndex}_of_${loadingMessagesWindow.length}'),
                                                                                                      sizeAva: 32,
                                                                                                      sizeLetter: 24,
                                                                                                      avaURL: avatarMiniUserRecord.photoUrl,
                                                                                                      nameLetter: avatarMiniUserRecord.displayName,
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                                Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).accent4,
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
                                                                                                      bottomRight: Radius.circular(16.0),
                                                                                                      topLeft: Radius.circular(0.0),
                                                                                                      topRight: Radius.circular(16.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.all(12.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          constraints: BoxConstraints(
                                                                                                            maxWidth: 400.0,
                                                                                                          ),
                                                                                                          decoration: BoxDecoration(),
                                                                                                          child: Text(
                                                                                                            loadingMessagesWindowItem.text,
                                                                                                            textAlign: TextAlign.start,
                                                                                                            maxLines: 15,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                  fontSize: 18.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        if (loadingMessagesWindowItem.document != null && loadingMessagesWindowItem.document != '')
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                                              children: [
                                                                                                                FlutterFlowIconButton(
                                                                                                                  borderRadius: 100.0,
                                                                                                                  buttonSize: 48.0,
                                                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  icon: Icon(
                                                                                                                    FFIcons.kdocument2,
                                                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                                                    size: 24.0,
                                                                                                                  ),
                                                                                                                  onPressed: () async {
                                                                                                                    await downloadFile(
                                                                                                                      filename: loadingMessagesWindowItem.document,
                                                                                                                      url: loadingMessagesWindowItem.document,
                                                                                                                    );
                                                                                                                  },
                                                                                                                ),
                                                                                                                ClipRRect(
                                                                                                                  child: Container(
                                                                                                                    constraints: BoxConstraints(
                                                                                                                      maxWidth: 300.0,
                                                                                                                    ),
                                                                                                                    decoration: BoxDecoration(),
                                                                                                                    child: Text(
                                                                                                                      loadingMessagesWindowItem.document.maybeHandleOverflow(
                                                                                                                        maxChars: 60,
                                                                                                                        replacement: '…',
                                                                                                                      ),
                                                                                                                      maxLines: 2,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                            fontSize: 16.0,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ].divide(SizedBox(width: 12.0)),
                                                                                                            ),
                                                                                                          ),
                                                                                                        if (loadingMessagesWindowItem.image.isNotEmpty)
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: Builder(
                                                                                                              builder: (context) {
                                                                                                                final mediaInMessage = loadingMessagesWindowItem.image.toList();

                                                                                                                return Wrap(
                                                                                                                  spacing: 12.0,
                                                                                                                  runSpacing: 12.0,
                                                                                                                  alignment: WrapAlignment.start,
                                                                                                                  crossAxisAlignment: WrapCrossAlignment.start,
                                                                                                                  direction: Axis.horizontal,
                                                                                                                  runAlignment: WrapAlignment.start,
                                                                                                                  verticalDirection: VerticalDirection.down,
                                                                                                                  clipBehavior: Clip.none,
                                                                                                                  children: List.generate(mediaInMessage.length, (mediaInMessageIndex) {
                                                                                                                    final mediaInMessageItem = mediaInMessage[mediaInMessageIndex];
                                                                                                                    return InkWell(
                                                                                                                      splashColor: Colors.transparent,
                                                                                                                      focusColor: Colors.transparent,
                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                      onTap: () async {
                                                                                                                        await Navigator.push(
                                                                                                                          context,
                                                                                                                          PageTransition(
                                                                                                                            type: PageTransitionType.fade,
                                                                                                                            child: FlutterFlowExpandedImageView(
                                                                                                                              image: Image.network(
                                                                                                                                mediaInMessageItem,
                                                                                                                                fit: BoxFit.contain,
                                                                                                                              ),
                                                                                                                              allowRotation: false,
                                                                                                                              tag: mediaInMessageItem,
                                                                                                                              useHeroAnimation: true,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                      child: Hero(
                                                                                                                        tag: mediaInMessageItem,
                                                                                                                        transitionOnUserGestures: true,
                                                                                                                        child: ClipRRect(
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                          child: Image.network(
                                                                                                                            mediaInMessageItem,
                                                                                                                            width: 100.0,
                                                                                                                            height: 100.0,
                                                                                                                            fit: BoxFit.cover,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  }),
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        Text(
                                                                                                          dateTimeFormat(
                                                                                                                    "yMd",
                                                                                                                    loadingMessagesWindowItem.timestemp,
                                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                                  ) ==
                                                                                                                  dateTimeFormat(
                                                                                                                    "yMd",
                                                                                                                    getCurrentTimestamp,
                                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                                  )
                                                                                                              ? dateTimeFormat(
                                                                                                                  "Hm",
                                                                                                                  loadingMessagesWindowItem.timestemp!,
                                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                                )
                                                                                                              : dateTimeFormat(
                                                                                                                  "dd.MM.yy",
                                                                                                                  loadingMessagesWindowItem.timestemp!,
                                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                                ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                                                              children: [
                                                                                                Container(
                                                                                                  constraints: BoxConstraints(
                                                                                                    maxWidth: 400.0,
                                                                                                  ),
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
                                                                                                      bottomRight: Radius.circular(16.0),
                                                                                                      topLeft: Radius.circular(16.0),
                                                                                                      topRight: Radius.circular(0.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.all(12.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          constraints: BoxConstraints(
                                                                                                            maxWidth: 400.0,
                                                                                                          ),
                                                                                                          decoration: BoxDecoration(),
                                                                                                          child: Text(
                                                                                                            loadingMessagesWindowItem.text,
                                                                                                            textAlign: TextAlign.start,
                                                                                                            maxLines: 15,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  fontSize: 18.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        if (loadingMessagesWindowItem.document != null && loadingMessagesWindowItem.document != '')
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: InkWell(
                                                                                                              splashColor: Colors.transparent,
                                                                                                              focusColor: Colors.transparent,
                                                                                                              hoverColor: Colors.transparent,
                                                                                                              highlightColor: Colors.transparent,
                                                                                                              onTap: () async {
                                                                                                                await downloadFile(
                                                                                                                  filename: loadingMessagesWindowItem.document,
                                                                                                                  url: loadingMessagesWindowItem.document,
                                                                                                                );
                                                                                                              },
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                children: [
                                                                                                                  FlutterFlowIconButton(
                                                                                                                    borderRadius: 100.0,
                                                                                                                    buttonSize: 48.0,
                                                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                    icon: Icon(
                                                                                                                      FFIcons.kdocument2,
                                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                                      size: 24.0,
                                                                                                                    ),
                                                                                                                    onPressed: () async {
                                                                                                                      await downloadFile(
                                                                                                                        filename: loadingMessagesWindowItem.document,
                                                                                                                        url: loadingMessagesWindowItem.document,
                                                                                                                      );
                                                                                                                    },
                                                                                                                  ),
                                                                                                                  ClipRRect(
                                                                                                                    child: Container(
                                                                                                                      constraints: BoxConstraints(
                                                                                                                        maxWidth: 300.0,
                                                                                                                      ),
                                                                                                                      decoration: BoxDecoration(),
                                                                                                                      child: Text(
                                                                                                                        loadingMessagesWindowItem.document.maybeHandleOverflow(
                                                                                                                          maxChars: 30,
                                                                                                                          replacement: '…',
                                                                                                                        ),
                                                                                                                        maxLines: 2,
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                              fontSize: 16.0,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ].divide(SizedBox(width: 12.0)),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        if (loadingMessagesWindowItem.image.isNotEmpty)
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: Builder(
                                                                                                              builder: (context) {
                                                                                                                final mediaInMessage = loadingMessagesWindowItem.image.toList();

                                                                                                                return Wrap(
                                                                                                                  spacing: 12.0,
                                                                                                                  runSpacing: 12.0,
                                                                                                                  alignment: WrapAlignment.start,
                                                                                                                  crossAxisAlignment: WrapCrossAlignment.start,
                                                                                                                  direction: Axis.horizontal,
                                                                                                                  runAlignment: WrapAlignment.start,
                                                                                                                  verticalDirection: VerticalDirection.down,
                                                                                                                  clipBehavior: Clip.none,
                                                                                                                  children: List.generate(mediaInMessage.length, (mediaInMessageIndex) {
                                                                                                                    final mediaInMessageItem = mediaInMessage[mediaInMessageIndex];
                                                                                                                    return InkWell(
                                                                                                                      splashColor: Colors.transparent,
                                                                                                                      focusColor: Colors.transparent,
                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                      onTap: () async {
                                                                                                                        await Navigator.push(
                                                                                                                          context,
                                                                                                                          PageTransition(
                                                                                                                            type: PageTransitionType.fade,
                                                                                                                            child: FlutterFlowExpandedImageView(
                                                                                                                              image: Image.network(
                                                                                                                                mediaInMessageItem,
                                                                                                                                fit: BoxFit.contain,
                                                                                                                              ),
                                                                                                                              allowRotation: false,
                                                                                                                              tag: mediaInMessageItem,
                                                                                                                              useHeroAnimation: true,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      },
                                                                                                                      child: Hero(
                                                                                                                        tag: mediaInMessageItem,
                                                                                                                        transitionOnUserGestures: true,
                                                                                                                        child: ClipRRect(
                                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                                          child: Image.network(
                                                                                                                            mediaInMessageItem,
                                                                                                                            width: 100.0,
                                                                                                                            height: 100.0,
                                                                                                                            fit: BoxFit.cover,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  }),
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                        Text(
                                                                                                          dateTimeFormat(
                                                                                                                    "yMd",
                                                                                                                    loadingMessagesWindowItem.timestemp,
                                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                                  ) ==
                                                                                                                  dateTimeFormat(
                                                                                                                    "yMd",
                                                                                                                    getCurrentTimestamp,
                                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                                  )
                                                                                                              ? dateTimeFormat(
                                                                                                                  "Hm",
                                                                                                                  loadingMessagesWindowItem.timestemp!,
                                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                                )
                                                                                                              : dateTimeFormat(
                                                                                                                  "dd.MM.yy",
                                                                                                                  loadingMessagesWindowItem.timestemp!,
                                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                                ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                                      if (_model
                                                                          .uploadedPhoto
                                                                          .isNotEmpty)
                                                                        Container(
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            minWidth:
                                                                                600.0,
                                                                            maxHeight:
                                                                                300.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                12.0,
                                                                                0.0,
                                                                                12.0),
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) {
                                                                                final uploadCard = _model.uploadedPhoto.toList().take(5).toList();

                                                                                return Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: List.generate(uploadCard.length, (uploadCardIndex) {
                                                                                    final uploadCardItem = uploadCard[uploadCardIndex];
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
                                                                                              uploadCardItem.bytes ?? Uint8List.fromList([]),
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
                                                                                              fillColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              icon: Icon(
                                                                                                Icons.close,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 14.0,
                                                                                              ),
                                                                                              onPressed: () async {
                                                                                                _model.removeFromUploadedPhoto(uploadCardItem);
                                                                                                safeSetState(() {});
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  }).divide(SizedBox(width: 12.0)).addToStart(SizedBox(width: 12.0)).addToEnd(SizedBox(width: 12.0)),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                          .showMenu)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                6.0,
                                                                                0.0,
                                                                                6.0),
                                                                            child:
                                                                                Material(
                                                                              color: Colors.transparent,
                                                                              elevation: 6.0,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                              ),
                                                                              child: Container(
                                                                                width: 240.0,
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
                                                                                          disabledColor: FlutterFlowTheme.of(context).alternate,
                                                                                          disabledIconColor: FlutterFlowTheme.of(context).accent1,
                                                                                          icon: Icon(
                                                                                            FFIcons.kdocument2,
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            size: 32.0,
                                                                                          ),
                                                                                          onPressed: (_model.uploadedPhoto.length > 4)
                                                                                              ? null
                                                                                              : () async {
                                                                                                  final selectedFiles = await selectFiles(
                                                                                                    multiFile: false,
                                                                                                  );
                                                                                                  if (selectedFiles != null) {
                                                                                                    safeSetState(() => _model.isDataUploading_uploadDataDOCW = true);
                                                                                                    var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                    var downloadUrls = <String>[];
                                                                                                    try {
                                                                                                      selectedUploadedFiles = selectedFiles
                                                                                                          .map((m) => FFUploadedFile(
                                                                                                                name: m.storagePath.split('/').last,
                                                                                                                bytes: m.bytes,
                                                                                                              ))
                                                                                                          .toList();

                                                                                                      downloadUrls = (await Future.wait(
                                                                                                        selectedFiles.map(
                                                                                                          (f) async => await uploadData(f.storagePath, f.bytes),
                                                                                                        ),
                                                                                                      ))
                                                                                                          .where((u) => u != null)
                                                                                                          .map((u) => u!)
                                                                                                          .toList();
                                                                                                    } finally {
                                                                                                      _model.isDataUploading_uploadDataDOCW = false;
                                                                                                    }
                                                                                                    if (selectedUploadedFiles.length == selectedFiles.length && downloadUrls.length == selectedFiles.length) {
                                                                                                      safeSetState(() {
                                                                                                        _model.uploadedLocalFile_uploadDataDOCW = selectedUploadedFiles.first;
                                                                                                        _model.uploadedFileUrl_uploadDataDOCW = downloadUrls.first;
                                                                                                      });
                                                                                                    } else {
                                                                                                      safeSetState(() {});
                                                                                                      return;
                                                                                                    }
                                                                                                  }

                                                                                                  var messagesRecordReference = MessagesRecord.collection.doc();
                                                                                                  await messagesRecordReference.set(createMessagesRecordData(
                                                                                                    chat: _model.choosenChat?.reference,
                                                                                                    whoSend: currentUserReference,
                                                                                                    timestemp: getCurrentTimestamp,
                                                                                                    document: _model.uploadedFileUrl_uploadDataDOCW,
                                                                                                  ));
                                                                                                  _model.newMessDoc = MessagesRecord.getDocumentFromData(
                                                                                                      createMessagesRecordData(
                                                                                                        chat: _model.choosenChat?.reference,
                                                                                                        whoSend: currentUserReference,
                                                                                                        timestemp: getCurrentTimestamp,
                                                                                                        document: _model.uploadedFileUrl_uploadDataDOCW,
                                                                                                      ),
                                                                                                      messagesRecordReference);
                                                                                                  triggerPushNotification(
                                                                                                    notificationTitle: FFLocalizations.of(context).getVariableText(
                                                                                                      ruText: 'У вас новое сообщение',
                                                                                                      mnText: 'Танд захидал байна',
                                                                                                    ),
                                                                                                    notificationText: '',
                                                                                                    userRefs: _model.choosenChat!.members.toList(),
                                                                                                    initialPageName: 'chatWindow',
                                                                                                    parameterData: {
                                                                                                      'chatDoc': _model.choosenChat,
                                                                                                    },
                                                                                                  );

                                                                                                  await _model.choosenChat!.reference.update({
                                                                                                    ...createChatsRecordData(
                                                                                                      lastMessage: _model.newMessDoc?.document,
                                                                                                      lastMessageTime: getCurrentTimestamp,
                                                                                                      lastMessageSender: currentUserReference,
                                                                                                    ),
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'last_message_seen_by': FieldValue.delete(),
                                                                                                        'messages': FieldValue.arrayUnion([
                                                                                                          _model.newMessDoc?.reference
                                                                                                        ]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });

                                                                                                  await _model.choosenChat!.reference.update({
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'last_message_seen_by': FieldValue.arrayUnion([currentUserReference]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });

                                                                                                  safeSetState(() {});
                                                                                                },
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'fdhzg96x' /* Документ */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                fontSize: 16.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                                                                  final selectedMedia = await selectMedia(
                                                                                                    maxWidth: 1920.00,
                                                                                                    maxHeight: 1920.00,
                                                                                                    mediaSource: MediaSource.photoGallery,
                                                                                                    multiImage: false,
                                                                                                  );
                                                                                                  if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                                    safeSetState(() => _model.isDataUploading_uploadDataGallery = true);
                                                                                                    var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                    try {
                                                                                                      selectedUploadedFiles = selectedMedia
                                                                                                          .map((m) => FFUploadedFile(
                                                                                                                name: m.storagePath.split('/').last,
                                                                                                                bytes: m.bytes,
                                                                                                                height: m.dimensions?.height,
                                                                                                                width: m.dimensions?.width,
                                                                                                                blurHash: m.blurHash,
                                                                                                              ))
                                                                                                          .toList();
                                                                                                    } finally {
                                                                                                      _model.isDataUploading_uploadDataGallery = false;
                                                                                                    }
                                                                                                    if (selectedUploadedFiles.length == selectedMedia.length) {
                                                                                                      safeSetState(() {
                                                                                                        _model.uploadedLocalFile_uploadDataGallery = selectedUploadedFiles.first;
                                                                                                      });
                                                                                                    } else {
                                                                                                      safeSetState(() {});
                                                                                                      return;
                                                                                                    }
                                                                                                  }

                                                                                                  _model.addToUploadedPhoto(_model.uploadedLocalFile_uploadDataGallery);
                                                                                                  triggerPushNotification(
                                                                                                    notificationTitle: FFLocalizations.of(context).getVariableText(
                                                                                                      ruText: 'У вас новое сообщение',
                                                                                                      mnText: 'Танд захидал байна',
                                                                                                    ),
                                                                                                    notificationText: '',
                                                                                                    userRefs: _model.choosenChat!.members.toList(),
                                                                                                    initialPageName: 'chatWindow',
                                                                                                    parameterData: {
                                                                                                      'chatDoc': _model.choosenChat,
                                                                                                    },
                                                                                                  );
                                                                                                  safeSetState(() {
                                                                                                    _model.isDataUploading_uploadDataGallery = false;
                                                                                                    _model.uploadedLocalFile_uploadDataGallery = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                                  });
                                                                                                },
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'wrunanlh' /* Галерея */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                fontSize: 16.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxWidth:
                                                                              1000.0,
                                                                          maxHeight:
                                                                              300.0,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
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
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(10.0),
                                                                            bottomRight:
                                                                                Radius.circular(10.0),
                                                                            topLeft:
                                                                                Radius.circular(0.0),
                                                                            topRight:
                                                                                Radius.circular(0.0),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(24.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children:
                                                                                [
                                                                              Expanded(
                                                                                child: TextFormField(
                                                                                  controller: _model.textController2,
                                                                                  focusNode: _model.textFieldFocusNode2,
                                                                                  onChanged: (_) => EasyDebounce.debounce(
                                                                                    '_model.textController2',
                                                                                    Duration(milliseconds: 1000),
                                                                                    () => safeSetState(() {}),
                                                                                  ),
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: FFLocalizations.of(context).getText(
                                                                                      'avsgn5j8' /* Напишите... */,
                                                                                    ),
                                                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                                                                          color: FlutterFlowTheme.of(context).accent1,
                                                                                          letterSpacing: 0.0,
                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).labelMediumIsCustom,
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
                                                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    hoverColor: FlutterFlowTheme.of(context).secondary,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                  textAlign: TextAlign.start,
                                                                                  maxLines: 3,
                                                                                  maxLength: 600,
                                                                                  buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.textController2Validator.asValidator(context),
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
                                                                                onPressed: ((_model.textController2.text == null || _model.textController2.text == '') && !(_model.uploadedPhoto.isNotEmpty))
                                                                                    ? null
                                                                                    : () async {
                                                                                        {
                                                                                          safeSetState(() => _model.isDataUploading_uploadPhotoMessInFirebase = true);
                                                                                          var selectedUploadedFiles = <FFUploadedFile>[];
                                                                                          var selectedMedia = <SelectedFile>[];
                                                                                          var downloadUrls = <String>[];
                                                                                          try {
                                                                                            selectedUploadedFiles = _model.uploadedPhoto;
                                                                                            selectedMedia = selectedFilesFromUploadedFiles(
                                                                                              selectedUploadedFiles,
                                                                                              isMultiData: true,
                                                                                            );
                                                                                            downloadUrls = (await Future.wait(
                                                                                              selectedMedia.map(
                                                                                                (m) async => await uploadData(m.storagePath, m.bytes),
                                                                                              ),
                                                                                            ))
                                                                                                .where((u) => u != null)
                                                                                                .map((u) => u!)
                                                                                                .toList();
                                                                                          } finally {
                                                                                            _model.isDataUploading_uploadPhotoMessInFirebase = false;
                                                                                          }
                                                                                          if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                            safeSetState(() {
                                                                                              _model.uploadedLocalFiles_uploadPhotoMessInFirebase = selectedUploadedFiles;
                                                                                              _model.uploadedFileUrls_uploadPhotoMessInFirebase = downloadUrls;
                                                                                            });
                                                                                          } else {
                                                                                            safeSetState(() {});
                                                                                            return;
                                                                                          }
                                                                                        }

                                                                                        var messagesRecordReference = MessagesRecord.collection.doc();
                                                                                        await messagesRecordReference.set({
                                                                                          ...createMessagesRecordData(
                                                                                            chat: _model.choosenChat?.reference,
                                                                                            whoSend: currentUserReference,
                                                                                            timestemp: getCurrentTimestamp,
                                                                                            text: valueOrDefault<String>(
                                                                                              _model.textController2.text,
                                                                                              'Файл',
                                                                                            ),
                                                                                          ),
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'image': _model.uploadedFileUrls_uploadPhotoMessInFirebase,
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.newMessTextOrPhoto = MessagesRecord.getDocumentFromData({
                                                                                          ...createMessagesRecordData(
                                                                                            chat: _model.choosenChat?.reference,
                                                                                            whoSend: currentUserReference,
                                                                                            timestemp: getCurrentTimestamp,
                                                                                            text: valueOrDefault<String>(
                                                                                              _model.textController2.text,
                                                                                              'Файл',
                                                                                            ),
                                                                                          ),
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'image': _model.uploadedFileUrls_uploadPhotoMessInFirebase,
                                                                                            },
                                                                                          ),
                                                                                        }, messagesRecordReference);
                                                                                        triggerPushNotification(
                                                                                          notificationTitle: FFLocalizations.of(context).getVariableText(
                                                                                            ruText: 'У вас новое сообщение',
                                                                                            mnText: 'Танд захидал байна',
                                                                                          ),
                                                                                          notificationText: '',
                                                                                          userRefs: _model.choosenChat!.members.toList(),
                                                                                          initialPageName: 'chatWindow',
                                                                                          parameterData: {
                                                                                            'chatDoc': _model.choosenChat,
                                                                                          },
                                                                                        );

                                                                                        await _model.choosenChat!.reference.update({
                                                                                          ...createChatsRecordData(
                                                                                            lastMessage: _model.textController2.text,
                                                                                            lastMessageTime: getCurrentTimestamp,
                                                                                            lastMessageSender: currentUserReference,
                                                                                          ),
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'last_message_seen_by': FieldValue.delete(),
                                                                                              'messages': FieldValue.arrayUnion([
                                                                                                _model.newMessTextOrPhoto?.reference
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });

                                                                                        await _model.choosenChat!.reference.update({
                                                                                          ...mapToFirestore(
                                                                                            {
                                                                                              'last_message_seen_by': FieldValue.arrayUnion([
                                                                                                currentUserReference
                                                                                              ]),
                                                                                            },
                                                                                          ),
                                                                                        });
                                                                                        _model.showMenu = false;
                                                                                        safeSetState(() {});
                                                                                        safeSetState(() {
                                                                                          _model.isDataUploading_uploadDataDOCW = false;
                                                                                          _model.uploadedLocalFile_uploadDataDOCW = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                          _model.uploadedFileUrl_uploadDataDOCW = '';
                                                                                        });

                                                                                        safeSetState(() {
                                                                                          _model.isDataUploading_uploadDataGallery = false;
                                                                                          _model.uploadedLocalFile_uploadDataGallery = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                        });

                                                                                        safeSetState(() {
                                                                                          _model.isDataUploading_uploadPhotoMessInFirebase = false;
                                                                                          _model.uploadedLocalFiles_uploadPhotoMessInFirebase = [];
                                                                                          _model.uploadedFileUrls_uploadPhotoMessInFirebase = [];
                                                                                        });

                                                                                        safeSetState(() {
                                                                                          _model.textController2?.clear();
                                                                                        });

                                                                                        safeSetState(() {});
                                                                                      },
                                                                              ),
                                                                            ].divide(SizedBox(width: 8.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          width: 24.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 24.0, 0.0, 0.0),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 1440.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        24.0,
                                                                        0.0,
                                                                        12.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'fmr44d6p' /* Название */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 2.0,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                        ),
                                                        StreamBuilder<
                                                            List<WorkRecord>>(
                                                          stream:
                                                              queryWorkRecord(
                                                            queryBuilder:
                                                                (workRecord) =>
                                                                    workRecord
                                                                        .where(
                                                              'work_status',
                                                              isEqualTo:
                                                                  ResponseType
                                                                      .dispute
                                                                      .serialize(),
                                                              isNull: (ResponseType
                                                                      .dispute
                                                                      .serialize()) ==
                                                                  null,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<WorkRecord>
                                                                listViewWorkRecordList =
                                                                snapshot.data!;
                                                            if (listViewWorkRecordList
                                                                .isEmpty) {
                                                              return Image
                                                                  .asset(
                                                                'assets/images/emptySearch.png',
                                                              );
                                                            }

                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  listViewWorkRecordList
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  listViewIndex) {
                                                                final listViewWorkRecord =
                                                                    listViewWorkRecordList[
                                                                        listViewIndex];
                                                                return Visibility(
                                                                  visible: listViewWorkRecord
                                                                          .debateRefery !=
                                                                      currentUserReference,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  listViewWorkRecord.workTitle,
                                                                                  textAlign: TextAlign.start,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  listViewWorkRecord.dabateMessage,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        letterSpacing: 0.0,
                                                                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 12.0)),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    context.pushNamed(
                                                                                      AdminWorkCardWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'workCard': serializeParam(
                                                                                          listViewWorkRecord,
                                                                                          ParamType.Document,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                      extra: <String, dynamic>{
                                                                                        'workCard': listViewWorkRecord,
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  text: FFLocalizations.of(context).getText(
                                                                                    'kvqhvpd9' /* Подробнее */,
                                                                                  ),
                                                                                  options: FFButtonOptions(
                                                                                    height: 32.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          fontFamily: 'involve',
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                    elevation: 0.0,
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(100.0),
                                                                                      bottomRight: Radius.circular(100.0),
                                                                                      topLeft: Radius.circular(100.0),
                                                                                      topRight: Radius.circular(100.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 24.0)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            2.0,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                12.0))
                                                                        .addToStart(SizedBox(
                                                                            height:
                                                                                12.0))
                                                                        .addToEnd(SizedBox(
                                                                            height:
                                                                                12.0)),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 24.0)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
