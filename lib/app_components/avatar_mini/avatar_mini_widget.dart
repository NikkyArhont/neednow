import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'avatar_mini_model.dart';
export 'avatar_mini_model.dart';

class AvatarMiniWidget extends StatefulWidget {
  const AvatarMiniWidget({
    super.key,
    required this.sizeAva,
    required this.sizeLetter,
    this.avaURL,
    required this.nameLetter,
  });

  final int? sizeAva;
  final int? sizeLetter;
  final String? avaURL;
  final String? nameLetter;

  @override
  State<AvatarMiniWidget> createState() => _AvatarMiniWidgetState();
}

class _AvatarMiniWidgetState extends State<AvatarMiniWidget> {
  late AvatarMiniModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvatarMiniModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Builder(
          builder: (context) {
            if (widget!.avaURL != null && widget!.avaURL != '') {
              return Container(
                width: widget!.sizeAva?.toDouble(),
                height: widget!.sizeAva?.toDouble(),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  widget!.avaURL!,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return Container(
                width: widget!.sizeAva?.toDouble(),
                height: widget!.sizeAva?.toDouble(),
                decoration: BoxDecoration(
                  color: FFAppConstants.avatarcolor
                      .elementAtOrNull(FFAppState().colorNumber),
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      functions.firstCharacter(widget!.nameLetter),
                      'E',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontSize: widget!.sizeLetter?.toDouble(),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
