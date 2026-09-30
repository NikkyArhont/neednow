import '/admin/admin_chats/admin_complete_debate_separate/admin_complete_debate_separate_widget.dart';
import '/admin/admin_chats/admin_debate_close/admin_debate_close_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'admin_complete_debate_widget.dart' show AdminCompleteDebateWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminCompleteDebateModel
    extends FlutterFlowModel<AdminCompleteDebateWidget> {
  ///  Local state fields for this component.

  DebateStatus? debateStatus;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? cashbackClient;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? notificClient;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? notificWorker;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? closeDebMess;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? cashbackWorker;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? notificClien;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? notificWorke;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? closeDebMessWorker;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
