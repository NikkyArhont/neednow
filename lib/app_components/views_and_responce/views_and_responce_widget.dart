import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'views_and_responce_model.dart';
export 'views_and_responce_model.dart';

class ViewsAndResponceWidget extends StatefulWidget {
  const ViewsAndResponceWidget({
    super.key,
    this.views,
    this.responces,
    required this.isHide,
  });

  final int? views;
  final int? responces;
  final JobStatus? isHide;

  @override
  State<ViewsAndResponceWidget> createState() => _ViewsAndResponceWidgetState();
}

class _ViewsAndResponceWidgetState extends State<ViewsAndResponceWidget> {
  late ViewsAndResponceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewsAndResponceModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget!.isHide == JobStatus.hide)
          FaIcon(
            FontAwesomeIcons.eyeSlash,
            color: FlutterFlowTheme.of(context).accent1,
            size: 20.0,
          ),
        if ((widget!.isHide != JobStatus.hide) && (widget!.views != null))
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.eye,
                color: FlutterFlowTheme.of(context).accent1,
                size: 20.0,
              ),
              Text(
                valueOrDefault<String>(
                  widget!.views?.toString(),
                  '0',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).accent1,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
        if ((widget!.isHide != JobStatus.hide) && (widget!.responces != null))
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FFIcons.kprofile,
                color: FlutterFlowTheme.of(context).accent1,
                size: 20.0,
              ),
              Text(
                valueOrDefault<String>(
                  widget!.responces?.toString(),
                  '0',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).accent1,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
