import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/views_and_responce/views_and_responce_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/my_job_status/my_job_status_widget.dart';
import 'dart:ui';
import 'my_job_card_widget.dart' show MyJobCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyJobCardModel extends FlutterFlowModel<MyJobCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;
  // Model for viewsAndResponce component.
  late ViewsAndResponceModel viewsAndResponceModel;
  // Model for myJobStatus component.
  late MyJobStatusModel myJobStatusModel;

  @override
  void initState(BuildContext context) {
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
    viewsAndResponceModel = createModel(context, () => ViewsAndResponceModel());
    myJobStatusModel = createModel(context, () => MyJobStatusModel());
  }

  @override
  void dispose() {
    avatarMiniModel.dispose();
    viewsAndResponceModel.dispose();
    myJobStatusModel.dispose();
  }
}
