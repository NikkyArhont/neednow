import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/get_job/modal_wind_not_money/modal_wind_not_money_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'modal_wind_get_order_widget.dart' show ModalWindGetOrderWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalWindGetOrderModel extends FlutterFlowModel<ModalWindGetOrderWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in modalWindGetOrder widget.
  GlobalDataRecord? queryComission;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
