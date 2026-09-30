import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'map_button_model.dart';
export 'map_button_model.dart';

class MapButtonWidget extends StatefulWidget {
  const MapButtonWidget({super.key});

  @override
  State<MapButtonWidget> createState() => _MapButtonWidgetState();
}

class _MapButtonWidgetState extends State<MapButtonWidget> {
  late MapButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: FlutterFlowIconButton(
        borderRadius: 100.0,
        buttonSize: 56.0,
        fillColor: FlutterFlowTheme.of(context).primary,
        icon: Icon(
          FFIcons.kadditionalIcons,
          color: FlutterFlowTheme.of(context).info,
          size: 24.0,
        ),
        onPressed: () async {
          context.pushNamed(MapFilterWidget.routeName);
        },
      ),
    );
  }
}
