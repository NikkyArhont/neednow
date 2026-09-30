import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'user_card_mini_widget.dart' show UserCardMiniWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserCardMiniModel extends FlutterFlowModel<UserCardMiniWidget> {
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
