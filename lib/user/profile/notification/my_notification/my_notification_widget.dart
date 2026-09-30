import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/empty_list_widget/emtpy_no_notification/emtpy_no_notification_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/notification/notification_card/notification_card_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_notification_model.dart';
export 'my_notification_model.dart';

class MyNotificationWidget extends StatefulWidget {
  const MyNotificationWidget({super.key});

  static String routeName = 'myNotification';
  static String routePath = '/myNotification';

  @override
  State<MyNotificationWidget> createState() => _MyNotificationWidgetState();
}

class _MyNotificationWidgetState extends State<MyNotificationWidget> {
  late MyNotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyNotificationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await currentUserReference!.update(createUserRecordData(
        hasNewNot: false,
      ));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationsRecord>>(
      stream: queryNotificationsRecord(
        queryBuilder: (notificationsRecord) => notificationsRecord
            .where(
              'whos_notification',
              isEqualTo: currentUserReference,
            )
            .orderBy('timeStapm', descending: true),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<NotificationsRecord> myNotificationNotificationsRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: wrapWithModel(
                      model: _model.titlewithbackModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TitlewithbackWidget(
                        title: FFLocalizations.of(context).getText(
                          't5bbcdk7' /* Уведомления */,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 800.0,
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Builder(
                        builder: (context) {
                          final myNotificationVar =
                              myNotificationNotificationsRecordList.toList();
                          if (myNotificationVar.isEmpty) {
                            return Center(
                              child: EmtpyNoNotificationWidget(),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: myNotificationVar.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.0),
                            itemBuilder: (context, myNotificationVarIndex) {
                              final myNotificationVarItem =
                                  myNotificationVar[myNotificationVarIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await myNotificationVarItem.reference
                                      .update(createNotificationsRecordData(
                                    unRead: false,
                                  ));
                                },
                                child: wrapWithModel(
                                  model: _model.notificationCardModels.getModel(
                                    myNotificationVarItem.reference.id,
                                    myNotificationVarIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: NotificationCardWidget(
                                    key: Key(
                                      'Keyghm_${myNotificationVarItem.reference.id}',
                                    ),
                                    notification: myNotificationVarItem,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 24.0))
                    .addToStart(SizedBox(height: 60.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
