import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_card_mini_model.dart';
export 'user_card_mini_model.dart';

class UserCardMiniWidget extends StatefulWidget {
  const UserCardMiniWidget({
    super.key,
    required this.titleServOrder,
    this.avaURL,
    this.lastAchiv,
    required this.raiting,
    required this.userName,
  });

  final String? titleServOrder;
  final String? avaURL;
  final String? lastAchiv;
  final double? raiting;
  final String? userName;

  @override
  State<UserCardMiniWidget> createState() => _UserCardMiniWidgetState();
}

class _UserCardMiniWidgetState extends State<UserCardMiniWidget> {
  late UserCardMiniModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserCardMiniModel());

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        wrapWithModel(
          model: _model.avatarMiniModel,
          updateCallback: () => safeSetState(() {}),
          child: AvatarMiniWidget(
            sizeAva: 54,
            sizeLetter: 42,
            avaURL: widget!.avaURL,
            nameLetter: widget!.userName!,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: () {
                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                    return 200.0;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointMedium) {
                    return 600.0;
                  } else if (MediaQuery.sizeOf(context).width <
                      kBreakpointLarge) {
                    return 1000.0;
                  } else {
                    return 600.0;
                  }
                }(),
                decoration: BoxDecoration(),
                child: AutoSizeText(
                  valueOrDefault<String>(
                    widget!.titleServOrder,
                    'emptyTitlei',
                  ),
                  minFontSize: 10.0,
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineLargeFamily,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineLargeIsCustom,
                      ),
                ),
              ),
            ),
            Wrap(
              spacing: 4.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget!.userName,
                    'errorNameUser',
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleMediumFamily,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).titleMediumIsCustom,
                      ),
                ),
                Icon(
                  Icons.star_half,
                  color: FlutterFlowTheme.of(context).warning,
                  size: 12.0,
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.raiting?.toString(),
                    'errorRaiting',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ],
            ),
          ].divide(SizedBox(height: 4.0)),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
