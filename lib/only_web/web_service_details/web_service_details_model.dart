import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/responce_card/responce_card_widget.dart';
import '/app_components/views_and_responce/views_and_responce_widget.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/modal_wind_sing_up/modal_wind_sing_up_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/user/service/edit_service_menu/edit_service_menu_widget.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'web_service_details_widget.dart' show WebServiceDetailsWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class WebServiceDetailsModel extends FlutterFlowModel<WebServiceDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // Model for viewsAndResponce component.
  late ViewsAndResponceModel viewsAndResponceModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for userCardMini component.
  late UserCardMiniModel userCardMiniModel;
  // Models for responceCard dynamic component.
  late FlutterFlowDynamicModels<ResponceCardModel> responceCardModels;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel = createModel(context, () => BackbuttonModel());
    viewsAndResponceModel = createModel(context, () => ViewsAndResponceModel());
    userCardMiniModel = createModel(context, () => UserCardMiniModel());
    responceCardModels = FlutterFlowDynamicModels(() => ResponceCardModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    backbuttonModel.dispose();
    viewsAndResponceModel.dispose();
    userCardMiniModel.dispose();
    responceCardModels.dispose();
  }
}
