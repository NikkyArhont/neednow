import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_code_sent_model.dart';
export 'new_code_sent_model.dart';

class NewCodeSentWidget extends StatefulWidget {
  const NewCodeSentWidget({super.key});

  @override
  State<NewCodeSentWidget> createState() => _NewCodeSentWidgetState();
}

class _NewCodeSentWidgetState extends State<NewCodeSentWidget> {
  late NewCodeSentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewCodeSentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 247.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Color(0xFFEEEEEE),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterFlowIconButton(
            borderRadius: 100.0,
            buttonSize: 28.0,
            fillColor: FlutterFlowTheme.of(context).primary,
            icon: Icon(
              Icons.done,
              color: FlutterFlowTheme.of(context).info,
              size: 12.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          Text(
            FFLocalizations.of(context).getText(
              'zpki3k3l' /* Новый код выслан */,
            ),
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).titleMediumIsCustom,
                ),
          ),
        ].divide(SizedBox(width: 16.0)),
      ),
    );
  }
}
