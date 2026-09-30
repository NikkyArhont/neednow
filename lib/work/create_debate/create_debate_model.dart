import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import '/work/modal_wind_debate_open/modal_wind_debate_open_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_debate_widget.dart' show CreateDebateWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateDebateModel extends FlutterFlowModel<CreateDebateWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for jobCardLite component.
  late JobCardLiteModel jobCardLiteModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? debateMesChat;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    jobCardLiteModel = createModel(context, () => JobCardLiteModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    jobCardLiteModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
