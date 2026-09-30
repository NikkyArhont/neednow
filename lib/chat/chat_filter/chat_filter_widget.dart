import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_filter_model.dart';
export 'chat_filter_model.dart';

class ChatFilterWidget extends StatefulWidget {
  const ChatFilterWidget({super.key});

  @override
  State<ChatFilterWidget> createState() => _ChatFilterWidgetState();
}

class _ChatFilterWidgetState extends State<ChatFilterWidget> {
  late ChatFilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatFilterModel());

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
              onPressed: () {
                print('Button pressed ...');
              },
              text: FFLocalizations.of(context).getText(
                'q63fyoro' /* Все */,
              ),
              options: FFButtonOptions(
                height: 38.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          Expanded(
            child: FlutterFlowChoiceChips(
              options: [
                ChipData(FFLocalizations.of(context).getText(
                  'xqg5l1i4' /* Option 1 */,
                )),
                ChipData(FFLocalizations.of(context).getText(
                  '1dja3nrn' /* Option 2 */,
                )),
                ChipData(FFLocalizations.of(context).getText(
                  'y4kwvbhw' /* Option 3 */,
                )),
                ChipData('')
              ],
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
