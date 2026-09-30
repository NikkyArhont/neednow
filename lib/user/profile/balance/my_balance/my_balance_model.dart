import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/user/profile/balance/transaction/transaction_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'my_balance_widget.dart' show MyBalanceWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyBalanceModel extends FlutterFlowModel<MyBalanceWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel1;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel2;
  // Models for transaction dynamic component.
  late FlutterFlowDynamicModels<TransactionModel> transactionModels;

  @override
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel1 = createModel(context, () => BackbuttonModel());
    backbuttonModel2 = createModel(context, () => BackbuttonModel());
    transactionModels = FlutterFlowDynamicModels(() => TransactionModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    backbuttonModel1.dispose();
    backbuttonModel2.dispose();
    transactionModels.dispose();
  }
}
