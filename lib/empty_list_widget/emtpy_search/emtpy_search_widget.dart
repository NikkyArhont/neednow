import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'emtpy_search_model.dart';
export 'emtpy_search_model.dart';

class EmtpySearchWidget extends StatefulWidget {
  const EmtpySearchWidget({super.key});

  @override
  State<EmtpySearchWidget> createState() => _EmtpySearchWidgetState();
}

class _EmtpySearchWidgetState extends State<EmtpySearchWidget> {
  late EmtpySearchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmtpySearchModel());

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
              'assets/images/emptySearch.png',
              fit: BoxFit.none,
            ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              'y66nsm30' /* Ничего не найдено */,
            ),
            style: FlutterFlowTheme.of(context).displayMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).displayMediumIsCustom,
                ),
          ),
        ].divide(SizedBox(height: 24.0)),
      ),
    );
  }
}
