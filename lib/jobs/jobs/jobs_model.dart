import '/app_components/menu/menu_widget.dart';
import '/app_components/top_avatar_nnotific/top_avatar_nnotific_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_new_works/emtpy_new_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/respond_card/respond_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'jobs_widget.dart' show JobsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JobsModel extends FlutterFlowModel<JobsWidget> {
  ///  Local state fields for this page.

  ResponseType? choosenStatus;

  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for topAvatarNnotific component.
  late TopAvatarNnotificModel topAvatarNnotificModel;
  // Models for respondCard dynamic component.
  late FlutterFlowDynamicModels<RespondCardModel> respondCardModels1;
  // Models for respondCard dynamic component.
  late FlutterFlowDynamicModels<RespondCardModel> respondCardModels2;
  // Model for menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    topAvatarNnotificModel =
        createModel(context, () => TopAvatarNnotificModel());
    respondCardModels1 = FlutterFlowDynamicModels(() => RespondCardModel());
    respondCardModels2 = FlutterFlowDynamicModels(() => RespondCardModel());
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    topAvatarNnotificModel.dispose();
    respondCardModels1.dispose();
    respondCardModels2.dispose();
    menuModel.dispose();
  }
}
