import '/admin/admin_chats/admin_complete_debate/admin_complete_debate_widget.dart';
import '/admin/admin_chats/admin_debate_close/admin_debate_close_widget.dart';
import '/admin/admin_chats/admin_incorrect_separate/admin_incorrect_separate_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'admin_complete_debate_separate_widget.dart'
    show AdminCompleteDebateSeparateWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminCompleteDebateSeparateModel
    extends FlutterFlowModel<AdminCompleteDebateSeparateWidget> {
  ///  Local state fields for this component.

  DebateStatus? debateStatus;

  int? clientCash;

  int? workerCash;

  ///  State fields for stateful widgets in this component.

  // State field(s) for workerAmount widget.
  FocusNode? workerAmountFocusNode;
  TextEditingController? workerAmountTextController;
  String? Function(BuildContext, String?)? workerAmountTextControllerValidator;
  // State field(s) for clientAmount widget.
  FocusNode? clientAmountFocusNode;
  TextEditingController? clientAmountTextController;
  String? Function(BuildContext, String?)? clientAmountTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? clientMoney;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? clientNot;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? workerMoney;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? workerNot;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? closeDebMessSeparate;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    workerAmountFocusNode?.dispose();
    workerAmountTextController?.dispose();

    clientAmountFocusNode?.dispose();
    clientAmountTextController?.dispose();
  }
}
