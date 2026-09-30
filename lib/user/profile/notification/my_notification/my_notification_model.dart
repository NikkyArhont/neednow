import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/empty_list_widget/emtpy_no_notification/emtpy_no_notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/notification/notification_card/notification_card_widget.dart';
import 'dart:ui';
import 'my_notification_widget.dart' show MyNotificationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyNotificationModel extends FlutterFlowModel<MyNotificationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // Models for notificationCard dynamic component.
  late FlutterFlowDynamicModels<NotificationCardModel> notificationCardModels;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
    notificationCardModels =
        FlutterFlowDynamicModels(() => NotificationCardModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    notificationCardModels.dispose();
  }
}
