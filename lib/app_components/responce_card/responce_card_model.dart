import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'responce_card_widget.dart' show ResponceCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResponceCardModel extends FlutterFlowModel<ResponceCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;

  @override
  void initState(BuildContext context) {
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
  }

  @override
  void dispose() {
    avatarMiniModel.dispose();
  }
}
