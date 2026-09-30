import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/balance/outcome_incorrect/outcome_incorrect_widget.dart';
import '/user/profile/balance/trans_error/trans_error_widget.dart';
import '/user/profile/balance/transaction_correct/transaction_correct_widget.dart';
import 'dart:math';
import 'dart:ui';
import 'income_info_after_link_widget.dart' show IncomeInfoAfterLinkWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncomeInfoAfterLinkModel
    extends FlutterFlowModel<IncomeInfoAfterLinkWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (BonumAuthCreate)] action in incomeInfoAfterLink widget.
  ApiCallResponse? accessPAI;
  // Stores action output result for [Backend Call - API (BonumGetInvoiceStatus)] action in incomeInfoAfterLink widget.
  ApiCallResponse? apiChaeckPay2;
  // Stores action output result for [Backend Call - Read Document] action in incomeInfoAfterLink widget.
  TransactionsRecord? readTrans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
