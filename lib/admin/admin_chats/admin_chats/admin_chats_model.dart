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
import 'admin_chats_widget.dart' show AdminChatsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class AdminChatsModel extends FlutterFlowModel<AdminChatsWidget> {
  ///  Local state fields for this page.

  KycStatus? filter;

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
  bool isDataUploading_uploadPhotoMessInFirebaseEnter = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadPhotoMessInFirebaseEnter = [];
  List<String> uploadedFileUrls_uploadPhotoMessInFirebaseEnter = [];

  // Stores action output result for [Backend Call - Create Document] action in adminChats widget.
  MessagesRecord? newMessTextOrPhotoCopy;
  // Model for adminMenu component.
  late AdminMenuModel adminMenuModel;
  // Model for adminTop component.
  late AdminTopModel adminTopModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<ChatsRecord> simpleSearchResults = [];
  // Model for debateBanner component.
  late DebateBannerModel debateBannerModel;
  bool isDataUploading_uploadDataDOCW = false;
  FFUploadedFile uploadedLocalFile_uploadDataDOCW =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDOCW = '';

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessagesRecord? newMessDoc;
  bool isDataUploading_uploadDataGallery = false;
  FFUploadedFile uploadedLocalFile_uploadDataGallery =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  bool isDataUploading_uploadPhotoMessInFirebase = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadPhotoMessInFirebase = [];
  List<String> uploadedFileUrls_uploadPhotoMessInFirebase = [];

  // Stores action output result for [Backend Call - Create Document] action in send widget.
  MessagesRecord? newMessTextOrPhoto;

  @override
  void initState(BuildContext context) {
    shortcutsFocusNode.requestFocus();
    adminMenuModel = createModel(context, () => AdminMenuModel());
    adminTopModel = createModel(context, () => AdminTopModel());
    debateBannerModel = createModel(context, () => DebateBannerModel());
  }

  @override
  void dispose() {
    adminMenuModel.dispose();
    adminTopModel.dispose();
    tabBarController?.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    debateBannerModel.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
