import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'mini_cat_filter_model.dart';
export 'mini_cat_filter_model.dart';

class MiniCatFilterWidget extends StatefulWidget {
  const MiniCatFilterWidget({
    super.key,
    required this.listCat,
  });

  final List<CategoryRecord>? listCat;

  @override
  State<MiniCatFilterWidget> createState() => _MiniCatFilterWidgetState();
}

class _MiniCatFilterWidgetState extends State<MiniCatFilterWidget> {
  late MiniCatFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MiniCatFilterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 12.0, 0.0),
            child: FFButtonWidget(
              onPressed: (_model.choiceChipsValue == null ||
                      _model.choiceChipsValue == '')
                  ? null
                  : () async {
                      safeSetState(() {
                        _model.choiceChipsValueController?.reset();
                      });
                    },
              text: FFLocalizations.of(context).getText(
                'dyz3pku1' /* Все */,
              ),
              options: FFButtonOptions(
                height: 38.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(100.0),
                disabledColor: FlutterFlowTheme.of(context).primary,
                disabledTextColor:
                    FlutterFlowTheme.of(context).primaryBackground,
              ),
            ),
          ),
          Expanded(
            child: FlutterFlowChoiceChips(
              options: widget!.listCat!
                  .map((e) => e.reference.id)
                  .toList()
                  .map((label) => ChipData(label))
                  .toList(),
              onChanged: (val) => safeSetState(
                  () => _model.choiceChipsValue = val?.firstOrNull),
              selectedChipStyle: ChipStyle(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                iconColor: FlutterFlowTheme.of(context).info,
                iconSize: 16.0,
                labelPadding:
                    EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 2.0),
                elevation: 0.0,
                borderWidth: 2.0,
                borderRadius: BorderRadius.circular(100.0),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                iconColor: Color(0x00000000),
                iconSize: 16.0,
                labelPadding:
                    EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 0.0),
                elevation: 0.0,
                borderColor: FlutterFlowTheme.of(context).primary,
                borderWidth: 2.0,
                borderRadius: BorderRadius.circular(100.0),
              ),
              chipSpacing: 12.0,
              rowSpacing: 8.0,
              multiselect: false,
              alignment: WrapAlignment.start,
              controller: _model.choiceChipsValueController ??=
                  FormFieldController<List<String>>(
                [],
              ),
              wrapped: false,
            ),
          ),
        ],
      ),
    );
  }
}
