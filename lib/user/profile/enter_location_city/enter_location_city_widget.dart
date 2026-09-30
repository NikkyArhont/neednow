import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'enter_location_city_model.dart';
export 'enter_location_city_model.dart';

class EnterLocationCityWidget extends StatefulWidget {
  const EnterLocationCityWidget({
    super.key,
    this.oldCity,
  });

  final String? oldCity;

  static String routeName = 'enterLocationCity';
  static String routePath = '/enterLocationCity';

  @override
  State<EnterLocationCityWidget> createState() =>
      _EnterLocationCityWidgetState();
}

class _EnterLocationCityWidgetState extends State<EnterLocationCityWidget> {
  late EnterLocationCityModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterLocationCityModel());

    _model.textController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget!.oldCity,
      'Введите город',
    ));
    _model.textFieldFocusNode ??= FocusNode();

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
                      'ptpl9bg6' /* Введите город */,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(),
                child: Builder(
                  builder: (context) => TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 2000),
                      () async {
                        await Future.delayed(
                          Duration(
                            milliseconds: 100,
                          ),
                        );
                        _model.apiResultCity = await GetCityCall.call(
                          city: _model.textController.text,
                        );

                        if ((_model.apiResultCity?.succeeded ?? true)) {
                          _model.searchList = functions
                              .parsPlaces(
                                  GetCityCall.listCity(
                                    (_model.apiResultCity?.jsonBody ?? ''),
                                  )?.toList(),
                                  GetCityCall.listPlaceId(
                                    (_model.apiResultCity?.jsonBody ?? ''),
                                  )?.toList(),
                                  GetCityCall.listDescription(
                                    (_model.apiResultCity?.jsonBody ?? ''),
                                  )?.toList())!
                              .toList()
                              .cast<SearchPlaceStruct>();
                          safeSetState(() {});
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
                        'yw9r3hki' /* Введите */,
                      ),
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
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
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
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
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  final listAddCities =
                      _model.searchList.map((e) => e).toList();

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listAddCities.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.0),
                    itemBuilder: (context, listAddCitiesIndex) {
                      final listAddCitiesItem =
                          listAddCities[listAddCitiesIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.coosenPlace = listAddCitiesItem;
                          safeSetState(() {});
                          _model.searchList = [];
                          safeSetState(() {});
                          safeSetState(() {
                            _model.textController?.text =
                                _model.coosenPlace!.placeTitle;
                            _model.textFieldFocusNode?.requestFocus();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _model.textController?.selection =
                                  TextSelection.collapsed(
                                offset: _model.textController!.text.length,
                              );
                            });
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listAddCitiesItem.placeTitle,
                              style: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineLargeFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineLargeIsCustom,
                                  ),
                            ),
                            Text(
                              listAddCitiesItem.placeDescript,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ),
                            Divider(
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      );
                    },
                  );
                },
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Builder(
                    builder: (context) => Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                      child: FFButtonWidget(
                        onPressed: (_model.coosenPlace == null)
                            ? null
                            : () async {
                                await currentUserReference!
                                    .update(createUserRecordData(
                                  city: _model.coosenPlace?.placeTitle,
                                  cityPlaceId: _model.coosenPlace?.placeId,
                                ));
                                _model.apiResultLatLon =
                                    await GetPlaceLatLngCall.call(
                                  placeId: _model.coosenPlace?.placeId,
                                );

                                if ((_model.apiResultLatLon?.succeeded ??
                                    true)) {
                                  await currentUserReference!
                                      .update(createUserRecordData(
                                    adress: functions.parsCoordinate(
                                        GetPlaceLatLngCall.placeLatLon(
                                      (_model.apiResultLatLon?.jsonBody ?? ''),
                                    )),
                                  ));
                                  FFAppState().updateMainFilterStruct(
                                    (e) => e
                                      ..cityTitle =
                                          _model.coosenPlace?.placeTitle,
                                  );
                                  safeSetState(() {});

                                  context.goNamed(MyProfileWidget.routeName);
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
                          'cfm4vbac' /* Применить */,
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
