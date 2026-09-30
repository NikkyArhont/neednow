import '/app_components/menu/menu_widget.dart';
import '/app_components/top_avatar_nnotific/top_avatar_nnotific_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/chat_card/chat_card_widget.dart';
import '/empty_list_widget/emtpy_no_chats/emtpy_no_chats_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'chat_list_widget.dart' show ChatListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatListModel extends FlutterFlowModel<ChatListWidget> {
  ///  Local state fields for this page.

  DebateStatus? choosenFilter;

  ///  State fields for stateful widgets in this page.

  // Model for topAvatarNnotific component.
  late TopAvatarNnotificModel topAvatarNnotificModel;
  // Models for chatCard dynamic component.
  late FlutterFlowDynamicModels<ChatCardModel> chatCardModels;
  // Model for menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    topAvatarNnotificModel =
        createModel(context, () => TopAvatarNnotificModel());
    chatCardModels = FlutterFlowDynamicModels(() => ChatCardModel());
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    topAvatarNnotificModel.dispose();
    chatCardModels.dispose();
    menuModel.dispose();
  }
}
