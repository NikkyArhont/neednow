import '/admin/admin_menu/admin_menu_widget.dart';
import '/admin/admin_profile/admin_del_acc/admin_del_acc_widget.dart';
import '/admin/admin_profile/admin_logout/admin_logout_widget.dart';
import '/admin/admin_top/admin_top_widget.dart';
import '/app_components/profile_image/profile_image_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'admin_main_profile_widget.dart' show AdminMainProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminMainProfileModel extends FlutterFlowModel<AdminMainProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for adminMenu component.
  late AdminMenuModel adminMenuModel;
  // Model for adminTop component.
  late AdminTopModel adminTopModel;
  // Model for profileImage component.
  late ProfileImageModel profileImageModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  bool isDataUploading_uploadDataB4e = false;
  FFUploadedFile uploadedLocalFile_uploadDataB4e =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataB4e = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GlobalDataRecord? loadCommission;

  @override
  void initState(BuildContext context) {
    adminMenuModel = createModel(context, () => AdminMenuModel());
    adminTopModel = createModel(context, () => AdminTopModel());
    profileImageModel = createModel(context, () => ProfileImageModel());
  }

  @override
  void dispose() {
    adminMenuModel.dispose();
    adminTopModel.dispose();
    profileImageModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
