import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/safe_fact_deal/safe_fact_deal_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/respond_card/respond_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/work/debate_menu/debate_menu_widget.dart';
import '/work/modal_wind_complete_wrk/modal_wind_complete_wrk_widget.dart';
import '/work/modal_wind_done_work/modal_wind_done_work_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'work_page_widget.dart' show WorkPageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkPageModel extends FlutterFlowModel<WorkPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // Model for respondCard component.
  late RespondCardModel respondCardModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel2;
  // Model for safeFactDeal component.
  late SafeFactDealModel safeFactDealModel;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? respondAgreedCopy;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? agreedNotific;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    backbuttonModel = createModel(context, () => BackbuttonModel());
    respondCardModel = createModel(context, () => RespondCardModel());
    avatarMiniModel2 = createModel(context, () => AvatarMiniModel());
    safeFactDealModel = createModel(context, () => SafeFactDealModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    titlewithbackModel.dispose();
    backbuttonModel.dispose();
    respondCardModel.dispose();
    avatarMiniModel2.dispose();
    safeFactDealModel.dispose();
  }
}
