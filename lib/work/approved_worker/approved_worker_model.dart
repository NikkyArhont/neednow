import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/info_fact_deal/info_fact_deal_widget.dart';
import '/app_components/info_safe_deal/info_safe_deal_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/get_job/modal_wind_not_money/modal_wind_not_money_widget.dart';
import '/work/modal_wind_approved_worker/modal_wind_approved_worker_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'approved_worker_widget.dart' show ApprovedWorkerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ApprovedWorkerModel extends FlutterFlowModel<ApprovedWorkerWidget> {
  ///  Local state fields for this page.

  bool safeDeal = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in approvedWorker widget.
  GlobalDataRecord? queryComission;
  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? safeDealTransaction;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? respondAgreed;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? agreedNotific;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    avatarMiniModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
