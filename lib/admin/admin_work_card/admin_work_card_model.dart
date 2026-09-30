import '/admin/admin_chats/admin_complete_debate/admin_complete_debate_widget.dart';
import '/admin/admin_menu/admin_menu_widget.dart';
import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/chat/debate_banner/debate_banner_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'admin_work_card_widget.dart' show AdminWorkCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminWorkCardModel extends FlutterFlowModel<AdminWorkCardWidget> {
  ///  Local state fields for this page.

  List<double> raitingData = [];
  void addToRaitingData(double item) => raitingData.add(item);
  void removeFromRaitingData(double item) => raitingData.remove(item);
  void removeAtIndexFromRaitingData(int index) => raitingData.removeAt(index);
  void insertAtIndexInRaitingData(int index, double item) =>
      raitingData.insert(index, item);
  void updateRaitingDataAtIndex(int index, Function(double) updateFn) =>
      raitingData[index] = updateFn(raitingData[index]);

  ///  State fields for stateful widgets in this page.

  // Model for adminMenu component.
  late AdminMenuModel adminMenuModel;
  // Model for debateBanner component.
  late DebateBannerModel debateBannerModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel1;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel2;

  @override
  void initState(BuildContext context) {
    adminMenuModel = createModel(context, () => AdminMenuModel());
    debateBannerModel = createModel(context, () => DebateBannerModel());
    avatarMiniModel1 = createModel(context, () => AvatarMiniModel());
    avatarMiniModel2 = createModel(context, () => AvatarMiniModel());
  }

  @override
  void dispose() {
    adminMenuModel.dispose();
    debateBannerModel.dispose();
    avatarMiniModel1.dispose();
    avatarMiniModel2.dispose();
  }
}
