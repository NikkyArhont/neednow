import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'debate_banner_model.dart';
export 'debate_banner_model.dart';

class DebateBannerWidget extends StatefulWidget {
  const DebateBannerWidget({
    super.key,
    required this.disputeBanner,
  });

  final DebateStatus? disputeBanner;

  @override
  State<DebateBannerWidget> createState() => _DebateBannerWidgetState();
}

class _DebateBannerWidgetState extends State<DebateBannerWidget> {
  late DebateBannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DebateBannerModel());

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
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widget!.disputeBanner == DebateStatus.open
              ? FlutterFlowTheme.of(context).error
              : FlutterFlowTheme.of(context).secondaryText,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          () {
            if (widget!.disputeBanner == DebateStatus.open) {
              return FFLocalizations.of(context).getVariableText(
                ruText: 'Открыт спор',
                mnText: 'Маргаан нээсэн',
              );
            } else if (widget!.disputeBanner == DebateStatus.client) {
              return FFLocalizations.of(context).getVariableText(
                ruText: 'Закрыт спор в пользу заказчика',
                mnText: 'Маргаан нь үйлчлүүлэгчийн талд хаагдсан',
              );
            } else if (widget!.disputeBanner == DebateStatus.worker) {
              return FFLocalizations.of(context).getVariableText(
                ruText: 'Закрыт спор в пользу исполнителя',
                mnText: 'Маргаан жүжигчний талд хаагдсан',
              );
            } else if (widget!.disputeBanner == DebateStatus.separate) {
              return FFLocalizations.of(context).getVariableText(
                ruText: 'Закрыт спор в пользу исполнителя/заказчика',
                mnText: 'Маргааныг гүйцэтгэгч/захиалагчийн талд шийдвэрлэсэн',
              );
            } else {
              return '';
            }
          }(),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: widget!.disputeBanner == DebateStatus.open
                    ? FlutterFlowTheme.of(context).error
                    : FlutterFlowTheme.of(context).secondaryText,
                fontSize: 10.0,
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
