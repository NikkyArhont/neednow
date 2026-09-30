import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/menu/menu_widget.dart';
import '/app_components/top_avatar_nnotific/top_avatar_nnotific_widget.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/modal_wind_sing_up/modal_wind_sing_up_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'my_profile_widget.dart' show MyProfileWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProfileModel extends FlutterFlowModel<MyProfileWidget> {
  ///  Local state fields for this page.

  bool notificationAllowed = false;

  bool showInvoice = false;

  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for topAvatarNnotific component.
  late TopAvatarNnotificModel topAvatarNnotificModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel1;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel2;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Model for menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    topAvatarNnotificModel =
        createModel(context, () => TopAvatarNnotificModel());
    avatarMiniModel1 = createModel(context, () => AvatarMiniModel());
    avatarMiniModel2 = createModel(context, () => AvatarMiniModel());
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    topAvatarNnotificModel.dispose();
    avatarMiniModel1.dispose();
    avatarMiniModel2.dispose();
    menuModel.dispose();
  }
}
