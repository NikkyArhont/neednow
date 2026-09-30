import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'raiting_card_model.dart';
export 'raiting_card_model.dart';

class RaitingCardWidget extends StatefulWidget {
  const RaitingCardWidget({
    super.key,
    required this.nameSender,
    required this.photoSender,
    required this.reviewDate,
    required this.reviewStar,
    required this.reveiwText,
  });

  final String? nameSender;
  final String? photoSender;
  final DateTime? reviewDate;
  final int? reviewStar;
  final String? reveiwText;

  @override
  State<RaitingCardWidget> createState() => _RaitingCardWidgetState();
}

class _RaitingCardWidgetState extends State<RaitingCardWidget> {
  late RaitingCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RaitingCardModel());

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
      width: MediaQuery.sizeOf(context).width * 1.0,
      constraints: BoxConstraints(
        maxWidth: 800.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  wrapWithModel(
                    model: _model.avatarMiniModel,
                    updateCallback: () => safeSetState(() {}),
                    child: AvatarMiniWidget(
                      sizeAva: 54,
                      sizeLetter: 42,
                      avaURL: widget!.photoSender,
                      nameLetter: widget!.nameSender!,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget!.nameSender,
                          'nameSender',
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleMediumFamily,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleMediumIsCustom,
                                ),
                      ),
                      Text(
                        dateTimeFormat(
                          "dd/MM/yyyy",
                          widget!.reviewDate,
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: FlutterFlowTheme.of(context).customer,
                ),
                direction: Axis.horizontal,
                rating: widget!.reviewStar!.toDouble(),
                unratedColor: FlutterFlowTheme.of(context).accent2,
                itemCount: 5,
                itemSize: 14.0,
              ),
            ].divide(SizedBox(width: 30.0)),
          ),
          Text(
            valueOrDefault<String>(
              widget!.reveiwText,
              'reviewText',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}
