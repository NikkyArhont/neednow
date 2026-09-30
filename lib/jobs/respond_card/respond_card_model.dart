import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import 'respond_card_widget.dart' show RespondCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RespondCardModel extends FlutterFlowModel<RespondCardWidget> {
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
