import '/app_components/backbutton/backbutton_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'titlewithback_model.dart';
export 'titlewithback_model.dart';

class TitlewithbackWidget extends StatefulWidget {
  const TitlewithbackWidget({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  State<TitlewithbackWidget> createState() => _TitlewithbackWidgetState();
}

class _TitlewithbackWidgetState extends State<TitlewithbackWidget> {
  late TitlewithbackModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TitlewithbackModel());

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
      children: [
        wrapWithModel(
          model: _model.backbuttonModel,
          updateCallback: () => safeSetState(() {}),
          child: BackbuttonWidget(),
        ),
        Flexible(
          child: AutoSizeText(
            valueOrDefault<String>(
              widget!.title,
              'empty',
            ),
            minFontSize: 16.0,
            style: FlutterFlowTheme.of(context).displayMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).displayMediumIsCustom,
                ),
          ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
