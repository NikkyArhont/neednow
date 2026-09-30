import '/app_components/info_fact_deal/info_fact_deal_widget.dart';
import '/app_components/info_safe_deal/info_safe_deal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'safe_fact_deal_model.dart';
export 'safe_fact_deal_model.dart';

class SafeFactDealWidget extends StatefulWidget {
  const SafeFactDealWidget({
    super.key,
    required this.safeDeal,
  });

  final bool? safeDeal;

  @override
  State<SafeFactDealWidget> createState() => _SafeFactDealWidgetState();
}

class _SafeFactDealWidgetState extends State<SafeFactDealWidget> {
  late SafeFactDealModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SafeFactDealModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget!.safeDeal ?? false) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FFIcons.kshieldDone,
                color: FlutterFlowTheme.of(context).success,
                size: 20.0,
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'g7l3z7uz' /* Безопасная сделка */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: InfoSafeDealWidget(),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FFIcons.kshieldFail,
                color: FlutterFlowTheme.of(context).error,
                size: 20.0,
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'g9q2h1y0' /* По факту выполнения заказа */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: InfoFactDealWidget(),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          );
        }
      },
    );
  }
}
