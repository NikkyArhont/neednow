import '/admin/admin_menu/admin_menu_widget.dart';
import '/admin/admin_users/admin_user_k_y_c_denied/admin_user_k_y_c_denied_widget.dart';
import '/admin/admin_users/admin_user_k_y_ccomplete/admin_user_k_y_ccomplete_widget.dart';
import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/reviews/raiting_card/raiting_card_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'admin_user_card_widget.dart' show AdminUserCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class AdminUserCardModel extends FlutterFlowModel<AdminUserCardWidget> {
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

  // Stores action output result for [Firestore Query - Query a collection] action in adminUserCard widget.
  List<ReviewsRecord>? downloadReviews;
  // Model for adminMenu component.
  late AdminMenuModel adminMenuModel;
  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;
  // Models for raitingCard dynamic component.
  late FlutterFlowDynamicModels<RaitingCardModel> raitingCardModels;

  @override
  void initState(BuildContext context) {
    adminMenuModel = createModel(context, () => AdminMenuModel());
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
    raitingCardModels = FlutterFlowDynamicModels(() => RaitingCardModel());
  }

  @override
  void dispose() {
    adminMenuModel.dispose();
    avatarMiniModel.dispose();
    raitingCardModels.dispose();
  }
}
