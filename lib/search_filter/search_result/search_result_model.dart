import '/app_components/map_button/map_button_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_search/emtpy_search_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'search_result_widget.dart' show SearchResultWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class SearchResultModel extends FlutterFlowModel<SearchResultWidget> {
  ///  Local state fields for this page.

  int? searchResult;

  bool searchActive = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<OrdersRecord> simpleSearchResults1 = [];
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels1;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels2;
  // Model for mapButton component.
  late MapButtonModel mapButtonModel1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  List<ServicesRecord> simpleSearchResults2 = [];
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels3;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels4;
  // Model for mapButton component.
  late MapButtonModel mapButtonModel2;

  @override
  void initState(BuildContext context) {
    jobCardLiteModels1 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    jobCardLiteModels2 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    mapButtonModel1 = createModel(context, () => MapButtonModel());
    jobCardLiteModels3 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    jobCardLiteModels4 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    mapButtonModel2 = createModel(context, () => MapButtonModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    jobCardLiteModels1.dispose();
    jobCardLiteModels2.dispose();
    mapButtonModel1.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    jobCardLiteModels3.dispose();
    jobCardLiteModels4.dispose();
    mapButtonModel2.dispose();
  }
}
