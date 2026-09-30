import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/balance/income_info_after_link/income_info_after_link_widget.dart';
import '/user/profile/balance/trans_error/trans_error_widget.dart';
import 'dart:math';
import 'dart:ui';
import 'income_info_widget.dart' show IncomeInfoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncomeInfoModel extends FlutterFlowModel<IncomeInfoWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in incomeInfo widget.
  TransactionsRecord? newTransaction;
  // Stores action output result for [Backend Call - API (BonumAuthCreate)] action in incomeInfo widget.
  ApiCallResponse? createAccessAPI;
  // Stores action output result for [Backend Call - API (BonumAuthRefresh)] action in incomeInfo widget.
  ApiCallResponse? apiRefresh;
  // Stores action output result for [Backend Call - API (BonumCreateInvoice)] action in incomeInfo widget.
  ApiCallResponse? apiInvoice;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
