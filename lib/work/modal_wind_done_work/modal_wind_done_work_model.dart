import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/work/done_work_info/done_work_info_widget.dart';
import 'dart:ui';
import 'modal_wind_done_work_widget.dart' show ModalWindDoneWorkWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalWindDoneWorkModel extends FlutterFlowModel<ModalWindDoneWorkWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? doneWorkNotification;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? newtrans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
