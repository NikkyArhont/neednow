import '/app_components/backbutton/backbutton_widget.dart';
import '/app_components/new_job_button/new_job_button_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/empty_list_widget/emtpy_new_works/emtpy_new_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/my_job_card/my_job_card_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'my_jobs_widget.dart' show MyJobsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyJobsModel extends FlutterFlowModel<MyJobsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel1;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel2;
  // Models for myJobCard dynamic component.
  late FlutterFlowDynamicModels<MyJobCardModel> myJobCardModels1;
  // Models for myJobCard dynamic component.
  late FlutterFlowDynamicModels<MyJobCardModel> myJobCardModels2;
  // Model for newJobButton component.
  late NewJobButtonModel newJobButtonModel;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel1 = createModel(context, () => BackbuttonModel());
    backbuttonModel2 = createModel(context, () => BackbuttonModel());
    myJobCardModels1 = FlutterFlowDynamicModels(() => MyJobCardModel());
    myJobCardModels2 = FlutterFlowDynamicModels(() => MyJobCardModel());
    newJobButtonModel = createModel(context, () => NewJobButtonModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    backbuttonModel1.dispose();
    backbuttonModel2.dispose();
    myJobCardModels1.dispose();
    myJobCardModels2.dispose();
    newJobButtonModel.dispose();
  }
}
