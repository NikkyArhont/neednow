import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'last_achivment_model.dart';
export 'last_achivment_model.dart';

class LastAchivmentWidget extends StatefulWidget {
  const LastAchivmentWidget({super.key});

  @override
  State<LastAchivmentWidget> createState() => _LastAchivmentWidgetState();
}

class _LastAchivmentWidgetState extends State<LastAchivmentWidget> {
  late LastAchivmentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LastAchivmentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: valueOrDefault(currentUserDocument?.lastAchivment, '') != null &&
          valueOrDefault(currentUserDocument?.lastAchivment, '') != '',
      child: AuthUserStreamWidget(
        builder: (context) => Container(
          height: 21.0,
          decoration: BoxDecoration(
            color: Color(0x15246BFD),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Text(
              valueOrDefault(currentUserDocument?.lastAchivment, ''),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
