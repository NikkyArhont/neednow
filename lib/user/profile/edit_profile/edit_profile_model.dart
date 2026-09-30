import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/delete_account/delete_account_widget.dart';
import '/app_components/log_out/log_out_widget.dart';
import '/app_components/profile_image/profile_image_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // Model for profileImage component.
  late ProfileImageModel profileImageModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel = createModel(context, () => BackbuttonModel());
    profileImageModel = createModel(context, () => ProfileImageModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    backbuttonModel.dispose();
    profileImageModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
