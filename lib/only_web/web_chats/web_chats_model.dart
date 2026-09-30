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
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'web_chats_widget.dart' show WebChatsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class WebChatsModel extends FlutterFlowModel<WebChatsWidget> {
  ///  Local state fields for this page.

  ChatsRecord? choosenChat;

  List<MessagesRecord> loadMessages = [];
  void addToLoadMessages(MessagesRecord item) => loadMessages.add(item);
  void removeFromLoadMessages(MessagesRecord item) => loadMessages.remove(item);
  void removeAtIndexFromLoadMessages(int index) => loadMessages.removeAt(index);
  void insertAtIndexInLoadMessages(int index, MessagesRecord item) =>
      loadMessages.insert(index, item);
  void updateLoadMessagesAtIndex(
          int index, Function(MessagesRecord) updateFn) =>
      loadMessages[index] = updateFn(loadMessages[index]);

  bool showMenu = false;

  List<FFUploadedFile> uploadedPhoto = [];
  void addToUploadedPhoto(FFUploadedFile item) => uploadedPhoto.add(item);
  void removeFromUploadedPhoto(FFUploadedFile item) =>
      uploadedPhoto.remove(item);
  void removeAtIndexFromUploadedPhoto(int index) =>
      uploadedPhoto.removeAt(index);
  void insertAtIndexInUploadedPhoto(int index, FFUploadedFile item) =>
      uploadedPhoto.insert(index, item);
  void updateUploadedPhotoAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      uploadedPhoto[index] = updateFn(uploadedPhoto[index]);

  DocumentReference? choosenWork;

  bool searchActive = false;

  ///  State fields for stateful widgets in this page.

  final shortcutsFocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in webChats widget.
  List<ChatsRecord>? loadChats;
  bool isDataUploading_uploadPhotoMessInFirebaseWEnter = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadPhotoMessInFirebaseWEnter = [];
  List<String> uploadedFileUrls_uploadPhotoMessInFirebaseWEnter = [];

  // Stores action output result for [Backend Call - Create Document] action in webChats widget.
  MessagesRecord? newMessTextOrPhotoCopy;
  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<ChatsRecord> simpleSearchResults = [];
  // Model for debateBanner component.
  late DebateBannerModel debateBannerModel;
  bool isDataUploading_uploadDataDOC = false;
  FFUploadedFile uploadedLocalFile_uploadDataDOC =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDOC = '';

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessagesRecord? newMessDoc;
  bool isDataUploading_uploadDataGalleryW = false;
  FFUploadedFile uploadedLocalFile_uploadDataGalleryW =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  bool isDataUploading_uploadPhotoMessInFirebaseW = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadPhotoMessInFirebaseW = [];
  List<String> uploadedFileUrls_uploadPhotoMessInFirebaseW = [];

  // Stores action output result for [Backend Call - Create Document] action in send widget.
  MessagesRecord? newMessTextOrPhoto;

  @override
  void initState(BuildContext context) {
    shortcutsFocusNode.requestFocus();
    webMenuModel = createModel(context, () => WebMenuModel());
    debateBannerModel = createModel(context, () => DebateBannerModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    debateBannerModel.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
