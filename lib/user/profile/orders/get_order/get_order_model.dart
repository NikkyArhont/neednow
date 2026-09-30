import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/get_job/modal_wind_get_order_succes/modal_wind_get_order_succes_widget.dart';
import 'dart:ui';
import 'get_order_widget.dart' show GetOrderWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GetOrderModel extends FlutterFlowModel<GetOrderWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // State field(s) for cost widget.
  FocusNode? costFocusNode;
  TextEditingController? costTextController;
  String? Function(BuildContext, String?)? costTextControllerValidator;
  // State field(s) for deadline widget.
  FocusNode? deadlineFocusNode;
  TextEditingController? deadlineTextController;
  String? Function(BuildContext, String?)? deadlineTextControllerValidator;
  // State field(s) for letter widget.
  FocusNode? letterFocusNode;
  TextEditingController? letterTextController;
  String? Function(BuildContext, String?)? letterTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? responceByOffer;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? createNotificByOffer;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? createRespond;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  WorkRecord? createWork;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? crateChat;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? createFirstMessage;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? commicionTransaction;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? createNotific;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    costFocusNode?.dispose();
    costTextController?.dispose();

    deadlineFocusNode?.dispose();
    deadlineTextController?.dispose();

    letterFocusNode?.dispose();
    letterTextController?.dispose();
  }
}
