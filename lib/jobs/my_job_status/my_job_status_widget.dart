import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_job_status_model.dart';
export 'my_job_status_model.dart';

class MyJobStatusWidget extends StatefulWidget {
  const MyJobStatusWidget({
    super.key,
    required this.jobStatus,
  });

  final JobStatus? jobStatus;

  @override
  State<MyJobStatusWidget> createState() => _MyJobStatusWidgetState();
}

class _MyJobStatusWidgetState extends State<MyJobStatusWidget> {
  late MyJobStatusModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyJobStatusModel());

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
      decoration: BoxDecoration(
        color: () {
          if (widget!.jobStatus == JobStatus.haveOffer) {
            return FlutterFlowTheme.of(context).primary;
          } else if (widget!.jobStatus == JobStatus.published) {
            return Color(0xFFA7C4FE);
          } else {
            return Color(0x00000000);
          }
        }(),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: widget!.jobStatus == JobStatus.hide
              ? FlutterFlowTheme.of(context).accent1
              : Color(0x00000000),
          width: widget!.jobStatus == JobStatus.hide ? 1.0 : 0.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: Text(
          () {
            if (widget!.jobStatus == JobStatus.haveOffer) {
              return 'Предложения';
            } else if (widget!.jobStatus == JobStatus.published) {
              return 'Опубликована';
            } else {
              return 'Снята с публикации';
            }
          }(),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: () {
                  if (widget!.jobStatus == JobStatus.haveOffer) {
                    return FlutterFlowTheme.of(context).primaryBackground;
                  } else if (widget!.jobStatus == JobStatus.published) {
                    return FlutterFlowTheme.of(context).primary;
                  } else {
                    return FlutterFlowTheme.of(context).accent1;
                  }
                }(),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
      ),
    );
  }
}
