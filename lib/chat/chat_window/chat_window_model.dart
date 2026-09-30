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
import 'chat_window_widget.dart' show ChatWindowWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChatWindowModel extends FlutterFlowModel<ChatWindowWidget> {
  ///  Local state fields for this page.

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

  bool showMenu = false;

  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for debateBanner component.
  late DebateBannerModel debateBannerModel;
  bool isDataUploading_uploadDataDOCMob = false;
  FFUploadedFile uploadedLocalFile_uploadDataDOCMob =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDOCMob = '';

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessagesRecord? newMessDoc;
  bool isDataUploading_uploadDataCameraMob = false;
  FFUploadedFile uploadedLocalFile_uploadDataCameraMob =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_uploadDataGalleryMob = false;
  FFUploadedFile uploadedLocalFile_uploadDataGalleryMob =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadPhotoMessInFirebaseMob = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadPhotoMessInFirebaseMob = [];
  List<String> uploadedFileUrls_uploadPhotoMessInFirebaseMob = [];

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessagesRecord? newMessTextOrPhoto;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    debateBannerModel = createModel(context, () => DebateBannerModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    debateBannerModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
