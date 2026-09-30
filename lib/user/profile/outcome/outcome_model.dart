import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/user/profile/balance/outcome_incorrect/outcome_incorrect_widget.dart';
import '/user/profile/balance/outcome_info/outcome_info_widget.dart';
import 'dart:ui';
import 'outcome_widget.dart' show OutcomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OutcomeModel extends FlutterFlowModel<OutcomeWidget> {
  ///  Local state fields for this page.

  int? amount;

  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel1;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  TransactionsRecord? newTransaction;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel1 = createModel(context, () => BackbuttonModel());
    backbuttonModel2 = createModel(context, () => BackbuttonModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    backbuttonModel1.dispose();
    backbuttonModel2.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
