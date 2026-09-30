import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'emtpy_no_notification_model.dart';
export 'emtpy_no_notification_model.dart';

class EmtpyNoNotificationWidget extends StatefulWidget {
  const EmtpyNoNotificationWidget({super.key});

  @override
  State<EmtpyNoNotificationWidget> createState() =>
      _EmtpyNoNotificationWidgetState();
}

class _EmtpyNoNotificationWidgetState extends State<EmtpyNoNotificationWidget> {
  late EmtpyNoNotificationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmtpyNoNotificationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/noNotification.png',
              fit: BoxFit.none,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  'x7ygjzw0' /* Нет уведомлений */,
                ),
                style: FlutterFlowTheme.of(context).displayMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displayMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displayMediumIsCustom,
                    ),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  '4wvbu86s' /* У Вас пока нет уведомлений */,
                ),
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleMediumIsCustom,
                    ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ].divide(SizedBox(height: 24.0)),
      ),
    );
  }
}
