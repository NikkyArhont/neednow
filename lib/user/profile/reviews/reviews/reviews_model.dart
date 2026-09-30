import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/empty_list_widget/emtpy_reviews/emtpy_reviews_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/user/profile/reviews/raiting_card/raiting_card_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'reviews_widget.dart' show ReviewsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ReviewsModel extends FlutterFlowModel<ReviewsWidget> {
  ///  Local state fields for this page.

  List<double> raitingData = [];
  void addToRaitingData(double item) => raitingData.add(item);
  void removeFromRaitingData(double item) => raitingData.remove(item);
  void removeAtIndexFromRaitingData(int index) => raitingData.removeAt(index);
  void insertAtIndexInRaitingData(int index, double item) =>
      raitingData.insert(index, item);
  void updateRaitingDataAtIndex(int index, Function(double) updateFn) =>
      raitingData[index] = updateFn(raitingData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Reviews widget.
  List<ReviewsRecord>? downloadReviews;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel1;
  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel2;
  // Models for raitingCard dynamic component.
  late FlutterFlowDynamicModels<RaitingCardModel> raitingCardModels;
  // Model for emtpyReviews component.
  late EmtpyReviewsModel emtpyReviewsModel;

  @override
  void initState(BuildContext context) {
    backbuttonModel1 = createModel(context, () => BackbuttonModel());
    webMenuModel = createModel(context, () => WebMenuModel());
    backbuttonModel2 = createModel(context, () => BackbuttonModel());
    raitingCardModels = FlutterFlowDynamicModels(() => RaitingCardModel());
    emtpyReviewsModel = createModel(context, () => EmtpyReviewsModel());
  }

  @override
  void dispose() {
    backbuttonModel1.dispose();
    webMenuModel.dispose();
    backbuttonModel2.dispose();
    raitingCardModels.dispose();
    emtpyReviewsModel.dispose();
  }
}
