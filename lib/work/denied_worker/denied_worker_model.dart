import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/work/modal_wind_denied_worker/modal_wind_denied_worker_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'denied_worker_widget.dart' show DeniedWorkerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeniedWorkerModel extends FlutterFlowModel<DeniedWorkerWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? respondAgreed;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? agreedNotific;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    avatarMiniModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
