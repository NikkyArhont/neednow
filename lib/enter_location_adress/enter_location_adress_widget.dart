import '/app_components/titlewithback/titlewithback_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_location_adress_model.dart';
export 'enter_location_adress_model.dart';

class EnterLocationAdressWidget extends StatefulWidget {
  const EnterLocationAdressWidget({
    super.key,
    this.oldAddress,
  });

  final String? oldAddress;

  static String routeName = 'enterLocationAdress';
  static String routePath = '/enterLocationAdress';

  @override
  State<EnterLocationAdressWidget> createState() =>
      _EnterLocationAdressWidgetState();
}

class _EnterLocationAdressWidgetState extends State<EnterLocationAdressWidget> {
  late EnterLocationAdressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterLocationAdressModel());

    _model.textController ??= TextEditingController(text: widget!.oldAddress);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: wrapWithModel(
                  model: _model.titlewithbackModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TitlewithbackWidget(
                    title: FFLocalizations.of(context).getText(
                      'azndwub6' /* Введите локацию */,
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Autocomplete<String>(
                  initialValue: TextEditingValue(text: widget!.oldAddress!),
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return GetAdressCall.listCity(
                      (_model.apiResultGetAddress?.jsonBody ?? ''),
                    )!
                        .where((option) {
                      final lowercaseOption = option.toLowerCase();
                      return lowercaseOption
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return AutocompleteOptionsList(
                      textFieldKey: _model.textFieldKey,
                      textController: _model.textController!,
                      options: options.toList(),
                      onSelected: onSelected,
                      textStyle: TextStyle(),
                      textHighlightStyle: TextStyle(),
                      elevation: 4.0,
                      optionBackgroundColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      optionHighlightColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    );
                  },
                  onSelected: (String selection) {
                    safeSetState(
                        () => _model.textFieldSelectedOption = selection);
                    FocusScope.of(context).unfocus();
                  },
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onEditingComplete,
                  ) {
                    _model.textFieldFocusNode = focusNode;

                    _model.textController = textEditingController;
                    return TextFormField(
                      key: _model.textFieldKey,
                      controller: textEditingController,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.textController',
                        Duration(milliseconds: 2000),
                        () async {
                          _model.apiResultGetAddress = await GetAdressCall.call(
                            addres: _model.textController.text,
                          );

                          await Future.delayed(
                            Duration(
                              milliseconds: 300,
                            ),
                          );
                          if ((_model.apiResultGetAddress?.succeeded ?? true)) {
                            _model.seacrhAddress = GetAdressCall.listCity(
                              (_model.apiResultGetAddress?.jsonBody ?? ''),
                            )?.firstOrNull;
                            _model.idAddress = GetAdressCall.listPlaceId(
                              (_model.apiResultGetAddress?.jsonBody ?? ''),
                            )?.firstOrNull;
                          } else {
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: SearchErrorWidget(),
                                  ),
                                );
                              },
                            );
                          }

                          safeSetState(() {});
                        },
                      ),
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: FFLocalizations.of(context).getText(
                          'hmzqa7fc' /* Введите */,
                        ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                      maxLength: 150,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          null,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    );
                  },
                ),
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Builder(
                    builder: (context) => Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                      child: FFButtonWidget(
                        onPressed: (_model.textFieldSelectedOption != null &&
                                _model.textFieldSelectedOption != '')
                            ? null
                            : () async {
                                _model.apiResultLatLon =
                                    await GetPlaceLatLngCall.call(
                                  placeId: _model.idAddress,
                                );

                                if ((_model.apiResultLatLon?.succeeded ??
                                    true)) {
                                  FFAppState().newJobCreate =
                                      CreateJobDataStruct(
                                    locationTitle: _model.seacrhAddress,
                                    placeId: _model.idAddress,
                                    locationLatLng: functions.parsCoordinate(
                                        GetPlaceLatLngCall.placeLatLon(
                                      (_model.apiResultLatLon?.jsonBody ?? ''),
                                    )),
                                  );
                                  context.safePop();
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: SearchErrorWidget(),
                                        ),
                                      );
                                    },
                                  );
                                }

                                safeSetState(() {});
                              },
                        text: FFLocalizations.of(context).getText(
                          'ak3w4gef' /* Применить */,
                        ),
                        options: FFButtonOptions(
                          width: 360.0,
                          height: 58.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'involve',
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            topRight: Radius.circular(100.0),
                          ),
                          disabledColor: FlutterFlowTheme.of(context).secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }
}
