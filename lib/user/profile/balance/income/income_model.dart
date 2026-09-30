import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/user/profile/balance/income_info/income_info_widget.dart';
import '/user/profile/balance/income_info_after_link/income_info_after_link_widget.dart';
import 'dart:ui';
import 'income_widget.dart' show IncomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncomeModel extends FlutterFlowModel<IncomeWidget> {
  ///  Local state fields for this page.

  int? amount = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Income widget.
  GlobalDataRecord? readDocs;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel1;
  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    backbuttonModel1 = createModel(context, () => BackbuttonModel());
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel2 = createModel(context, () => BackbuttonModel());
  }

  @override
  void dispose() {
    backbuttonModel1.dispose();
    webMenuModel.dispose();
    backbuttonModel2.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
