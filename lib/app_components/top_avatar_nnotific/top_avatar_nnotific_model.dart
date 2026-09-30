import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/onboarding/bot_shet_choose_role/bot_shet_choose_role_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'top_avatar_nnotific_widget.dart' show TopAvatarNnotificWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopAvatarNnotificModel extends FlutterFlowModel<TopAvatarNnotificWidget> {
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
