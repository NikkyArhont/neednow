import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/orders/modal_wind_offer_order_succes/modal_wind_offer_order_succes_widget.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'offer_order_widget.dart' show OfferOrderWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OfferOrderModel extends FlutterFlowModel<OfferOrderWidget> {
  ///  Local state fields for this page.

  OrdersRecord? choosenOrder;

  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Model for userCardMini component.
  late UserCardMiniModel userCardMiniModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ResponceRecord? createRespond;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  WorkRecord? createWork;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? createChat;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  NotificationsRecord? createNotific;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessagesRecord? createFirstMessage;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    userCardMiniModel = createModel(context, () => UserCardMiniModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    userCardMiniModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
