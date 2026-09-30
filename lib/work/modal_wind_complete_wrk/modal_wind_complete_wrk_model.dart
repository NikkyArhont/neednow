import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/work/complete_work_info/complete_work_info_widget.dart';
import 'dart:ui';
import 'modal_wind_complete_wrk_widget.dart' show ModalWindCompleteWrkWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalWindCompleteWrkModel
    extends FlutterFlowModel<ModalWindCompleteWrkWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? workComplete;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? doneWorkNotification;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
