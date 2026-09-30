import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_done_works/emtpy_done_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_history/job_card_history_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'my_work_history_widget.dart' show MyWorkHistoryWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyWorkHistoryModel extends FlutterFlowModel<MyWorkHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Models for jobCardHistory dynamic component.
  late FlutterFlowDynamicModels<JobCardHistoryModel> jobCardHistoryModels1;
  // Models for jobCardHistory dynamic component.
  late FlutterFlowDynamicModels<JobCardHistoryModel> jobCardHistoryModels2;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    jobCardHistoryModels1 =
        FlutterFlowDynamicModels(() => JobCardHistoryModel());
    jobCardHistoryModels2 =
        FlutterFlowDynamicModels(() => JobCardHistoryModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    jobCardHistoryModels1.dispose();
    jobCardHistoryModels2.dispose();
  }
}
