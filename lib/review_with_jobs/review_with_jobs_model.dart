import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/backbutton/backbutton_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'review_with_jobs_widget.dart' show ReviewWithJobsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewWithJobsModel extends FlutterFlowModel<ReviewWithJobsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels1;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels2;

  @override
  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
    jobCardLiteModels1 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    jobCardLiteModels2 = FlutterFlowDynamicModels(() => JobCardLiteModel());
  }

  @override
  void dispose() {
    backbuttonModel.dispose();
    avatarMiniModel.dispose();
    jobCardLiteModels1.dispose();
    jobCardLiteModels2.dispose();
  }
}
