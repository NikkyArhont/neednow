import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'job_card_history_widget.dart' show JobCardHistoryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobCardHistoryModel extends FlutterFlowModel<JobCardHistoryWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for userCardMini component.
  late UserCardMiniModel userCardMiniModel;

  @override
  void initState(BuildContext context) {
    userCardMiniModel = createModel(context, () => UserCardMiniModel());
  }

  @override
  void dispose() {
    userCardMiniModel.dispose();
  }
}
