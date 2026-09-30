import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'startpage_model.dart';
export 'startpage_model.dart';

class StartpageWidget extends StatefulWidget {
  const StartpageWidget({super.key});

  static String routeName = 'startpage';
  static String routePath = '/startpage';

  @override
  State<StartpageWidget> createState() => _StartpageWidgetState();
}

class _StartpageWidgetState extends State<StartpageWidget> {
  late StartpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartpageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await requestPermission(notificationsPermission);
        }(),
      );
      setAppLanguage(context, 'mn');
      FFAppState().notifPermiss =
          await getPermissionStatus(notificationsPermission);
      _model.queryCat = await queryCategoryRecordOnce(
        queryBuilder: (categoryRecord) => categoryRecord.where(
          'show',
          isEqualTo: true,
        ),
      );
      _model.queryCommission = await queryGlobalDataRecordOnce(
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      FFAppState().updateMainFilterStruct(
        (e) => e
          ..cityPlaceId = null
          ..locationRadius = null
          ..userPoint = functions.reternZeroLoc()
          ..cityTitle = valueOrDefault(currentUserDocument?.city, '')
          ..categories = [],
      );
      safeSetState(() {});
      FFAppState().saveCat = functions
          .savingCat(_model.queryCat?.toList())!
          .toList()
          .cast<DownloadCatStruct>();
      FFAppState().commission = _model.queryCommission!.comission;
      safeSetState(() {});
      await Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
      );
      if (FFAppState().firstTime == true) {
        context.goNamed(OnboardingWidget.routeName);
      } else {
        if ((currentUserDocument?.essence == UserStatus.admin) ||
            (currentUserDocument?.essence == UserStatus.emploee)) {
          context.goNamed(AdminMainProfileWidget.routeName);
        } else {
          context.goNamed(MainWidget.routeName);
        }
      }
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primary,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Asset_2@4x-8.png',
                      width: 200.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
