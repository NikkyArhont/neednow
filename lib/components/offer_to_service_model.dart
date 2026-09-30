import '/app_components/responce_card/responce_card_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'offer_to_service_widget.dart' show OfferToServiceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OfferToServiceModel extends FlutterFlowModel<OfferToServiceWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for responceCard dynamic component.
  late FlutterFlowDynamicModels<ResponceCardModel> responceCardModels;

  @override
  void initState(BuildContext context) {
    responceCardModels = FlutterFlowDynamicModels(() => ResponceCardModel());
  }

  @override
  void dispose() {
    responceCardModels.dispose();
  }
}
