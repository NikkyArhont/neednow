import '/app_components/main_search/main_search_widget.dart';
import '/app_components/map_button/map_button_widget.dart';
import '/app_components/menu/menu_widget.dart';
import '/app_components/top_avatar_nnotific/top_avatar_nnotific_widget.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/empty_list_widget/emtpy_search/emtpy_search_widget.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import '/jobs/my_job_card/my_job_card_widget.dart';
import '/modals_windows/modal_wind_sing_up/modal_wind_sing_up_widget.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import '/only_web/web_category/web_category_widget.dart';
import '/only_web/web_location/web_location_widget.dart';
import '/only_web/web_menu/web_menu_widget.dart';
import '/only_web/web_price/web_price_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'main_model.dart';
export 'main_model.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  static String routeName = 'main';
  static String routePath = '/main';

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late MainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      FFAppState().mainFilter = FilterDataStruct(
        userPoint: currentUserLocationValue,
      );
      safeSetState(() {});
      if ((currentUserDocument?.essence == UserStatus.admin) ||
          (currentUserDocument?.essence == UserStatus.emploee)) {
        context.goNamed(AdminMainProfileWidget.routeName);
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.locationTextController ??=
        TextEditingController(text: FFAppState().mainFilter.cityTitle);

    _model.switchValue = false;
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.minPriceTextController ??= TextEditingController(
        text: FFAppState().mainFilter.minPrice == 0
            ? ''
            : FFAppState().mainFilter.minPrice.toString());
    _model.minPriceFocusNode ??= FocusNode();

    _model.maxPriceTextController ??= TextEditingController(
        text: FFAppState().mainFilter.maxPrice == 1000000
            ? ''
            : FFAppState().mainFilter.maxPrice.toString());
    _model.maxPriceFocusNode ??= FocusNode();

    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        endDrawer: Container(
          width: 530.0,
          child: Drawer(
            elevation: 16.0,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.clear,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'ziddft1z' /* Фильтр */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .displayMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .displayMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .displayMediumIsCustom,
                                  ),
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController1,
                                  child: ExpandablePanel(
                                    header: Text(
                                      FFLocalizations.of(context).getText(
                                        'd1oebtoe' /* Локация */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displayMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displayMediumIsCustom,
                                          ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 12.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (!_model.switchValue!)
                                            Builder(
                                              builder: (context) => Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                child: Autocomplete<String>(
                                                  initialValue:
                                                      TextEditingValue(
                                                          text: FFAppState()
                                                              .mainFilter
                                                              .cityTitle),
                                                  optionsBuilder:
                                                      (textEditingValue) {
                                                    if (textEditingValue.text ==
                                                        '') {
                                                      return const Iterable<
                                                          String>.empty();
                                                    }
                                                    return GetCityCall.listCity(
                                                      (_model.apiResultFilterCity
                                                              ?.jsonBody ??
                                                          ''),
                                                    )!
                                                        .where((option) {
                                                      final lowercaseOption =
                                                          option.toLowerCase();
                                                      return lowercaseOption
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase());
                                                    });
                                                  },
                                                  optionsViewBuilder: (context,
                                                      onSelected, options) {
                                                    return AutocompleteOptionsList(
                                                      textFieldKey:
                                                          _model.locationKey,
                                                      textController: _model
                                                          .locationTextController!,
                                                      options: options.toList(),
                                                      onSelected: onSelected,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                      textHighlightStyle:
                                                          TextStyle(),
                                                      elevation: 4.0,
                                                      optionBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      optionHighlightColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      maxHeight: 200.0,
                                                    );
                                                  },
                                                  onSelected:
                                                      (String selection) {
                                                    safeSetState(() => _model
                                                            .locationSelectedOption =
                                                        selection);
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  fieldViewBuilder: (
                                                    context,
                                                    textEditingController,
                                                    focusNode,
                                                    onEditingComplete,
                                                  ) {
                                                    _model.locationFocusNode =
                                                        focusNode;

                                                    _model.locationTextController =
                                                        textEditingController;
                                                    return TextFormField(
                                                      key: _model.locationKey,
                                                      controller:
                                                          textEditingController,
                                                      focusNode: focusNode,
                                                      onEditingComplete:
                                                          onEditingComplete,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.locationTextController',
                                                        Duration(
                                                            milliseconds: 10),
                                                        () async {
                                                          _model.apiResultFilterCity =
                                                              await GetCityCall
                                                                  .call(
                                                            city: _model
                                                                .locationTextController
                                                                .text,
                                                          );

                                                          await Future.delayed(
                                                            Duration(
                                                              milliseconds: 300,
                                                            ),
                                                          );
                                                          if ((_model
                                                                  .apiResultFilterCity
                                                                  ?.succeeded ??
                                                              true)) {
                                                            _model.placeID =
                                                                GetCityCall
                                                                    .listPlaceId(
                                                              (_model.apiResultFilterCity
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )?.firstOrNull;
                                                            safeSetState(() {});
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  alignment: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              dialogContext)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        SearchErrorWidget(),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                      autofocus: false,
                                                      readOnly:
                                                          _model.switchValue!,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        hintText:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'i8p0slji' /* Введите */,
                                                        ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                                  color: Color(
                                                                      0xFF9E9E9E),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMediumIsCustom,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        prefixIcon: Icon(
                                                          FFIcons.klocation,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .locationTextControllerValidator
                                                          .asValidator(context),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '6qyd4j1a' /* Радиус от текущего местоположе... */,
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                              Switch.adaptive(
                                                value: _model.switchValue!,
                                                onChanged: (newValue) async {
                                                  safeSetState(() => _model
                                                      .switchValue = newValue!);
                                                  if (newValue!) {
                                                    currentUserLocationValue =
                                                        await getCurrentUserLocation(
                                                            defaultLocation:
                                                                LatLng(
                                                                    0.0, 0.0));
                                                    _model.searchLatLon =
                                                        currentUserLocationValue;
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.searchLatLon = null;
                                                    _model.placeID = null;
                                                  }
                                                },
                                                activeColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                activeTrackColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                inactiveTrackColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                                inactiveThumbColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            ],
                                          ),
                                          if (currentUserLocationValue == null)
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await requestPermission(
                                                    locationPermission);

                                                await currentUserReference!
                                                    .update(
                                                        createUserRecordData(
                                                  email: '',
                                                ));
                                              },
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x33246BFD),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.warning_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 24.0,
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'gmx3ceru' /* Предоставить доступ к геолокац... */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await requestPermission(
                                                              locationPermission);
                                                        },
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'lkl9orbv' /* Перейти */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              if (currentUserLocationValue !=
                                                  null)
                                                Slider(
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  inactiveColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  min: 5.0,
                                                  max: 15.0,
                                                  value: _model.sliderValue ??=
                                                      5.0,
                                                  label: _model.sliderValue
                                                      ?.toString(),
                                                  divisions: 10,
                                                  onChanged: (newValue) {
                                                    safeSetState(() =>
                                                        _model.sliderValue =
                                                            newValue);
                                                  },
                                                ),
                                              if (currentUserLocationValue !=
                                                  null)
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'vq6nle2u' /* Доступ к геолокации получен */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                  defaultLocation:
                                                                      LatLng(
                                                                          0.0,
                                                                          0.0));
                                                          _model.searchLatLon =
                                                              currentUserLocationValue;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'ymyislu7' /* Обновить */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 12.0)),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                      expandIcon: FFIcons.karrowDown2,
                                      collapseIcon: FFIcons.karrowUp2,
                                      iconSize: 24.0,
                                      iconColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController2,
                                  child: ExpandablePanel(
                                    header: Text(
                                      FFLocalizations.of(context).getText(
                                        '9a7rhvm1' /* Стоимость */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displayMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displayMediumIsCustom,
                                          ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 12.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _model
                                                      .minPriceTextController,
                                                  focusNode:
                                                      _model.minPriceFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmallIsCustom,
                                                        ),
                                                    hintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'mulsvv51' /* От */,
                                                    ),
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily: 'involve',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0x80FAFAFA),
                                                    hoverColor:
                                                        Color(0x14246BFD),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'involve',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  maxLength: 7,
                                                  buildCounter: (context,
                                                          {required currentLength,
                                                          required isFocused,
                                                          maxLength}) =>
                                                      null,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .minPriceTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _model
                                                      .maxPriceTextController,
                                                  focusNode:
                                                      _model.maxPriceFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmallIsCustom,
                                                        ),
                                                    hintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'ir1a7too' /* До */,
                                                    ),
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily: 'involve',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0x80FAFAFA),
                                                    hoverColor:
                                                        Color(0x14246BFD),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'involve',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  maxLength: 7,
                                                  buildCounter: (context,
                                                          {required currentLength,
                                                          required isFocused,
                                                          maxLength}) =>
                                                      null,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .maxPriceTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ].divide(SizedBox(height: 12.0)),
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                      expandIcon: FFIcons.karrowDown2,
                                      collapseIcon: FFIcons.karrowUp2,
                                      iconSize: 24.0,
                                      iconColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  controller:
                                      _model.expandableExpandableController3,
                                  child: ExpandablePanel(
                                    header: Text(
                                      FFLocalizations.of(context).getText(
                                        '412xc5bc' /* Специализация */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displayMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .displayMediumIsCustom,
                                          ),
                                    ),
                                    collapsed: Container(),
                                    expanded: Builder(
                                      builder: (context) {
                                        final listCat =
                                            FFAppState().saveCat.toList();

                                        return ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: listCat.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 12.0),
                                          itemBuilder: (context, listCatIndex) {
                                            final listCatItem =
                                                listCat[listCatIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (_model.choosenCat.contains(
                                                        listCatItem.refCat) ==
                                                    false) {
                                                  _model.addToChoosenCat(
                                                      listCatItem.refCat!);
                                                  safeSetState(() {});
                                                } else {
                                                  _model.removeFromChoosenCat(
                                                      listCatItem.refCat!);
                                                  safeSetState(() {});
                                                }
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (_model.choosenCat
                                                      .contains(
                                                          listCatItem.refCat))
                                                    Icon(
                                                      Icons.check_box,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 24.0,
                                                    ),
                                                  if (!_model.choosenCat
                                                          .contains(listCatItem
                                                              .refCat) ||
                                                      !(_model.choosenCat
                                                          .isNotEmpty))
                                                    Icon(
                                                      Icons
                                                          .check_box_outline_blank_outlined,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 24.0,
                                                    ),
                                                  Text(
                                                    listCatItem.title,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                      expandIcon: FFIcons.karrowDown2,
                                      collapseIcon: FFIcons.karrowUp2,
                                      iconSize: 24.0,
                                      iconColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(height: 24.0))
                          .addToStart(SizedBox(height: 40.0))
                          .addToEnd(SizedBox(height: 120.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    height: 118.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState().updateMainFilterStruct(
                                (e) => e
                                  ..cityPlaceId = null
                                  ..locationRadius = null
                                  ..userPoint = functions.reternZeroLoc()
                                  ..cityTitle = valueOrDefault(
                                      currentUserDocument?.city, '')
                                  ..categories = [],
                              );
                              safeSetState(() {});
                              safeSetState(() {
                                _model.maxPriceTextController?.clear();
                                _model.minPriceTextController?.clear();
                                _model.locationTextController?.clear();
                              });
                              Navigator.pop(context);
                            },
                            text: FFLocalizations.of(context).getText(
                              '0z5ta0l4' /* Сбросить */,
                            ),
                            options: FFButtonOptions(
                              height: 58.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFE9F0FF),
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'involve',
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100.0),
                                bottomRight: Radius.circular(100.0),
                                topLeft: Radius.circular(100.0),
                                topRight: Radius.circular(100.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                FFAppState().updateMainFilterStruct(
                                  (e) => e
                                    ..minPrice = int.tryParse(
                                        _model.minPriceTextController.text)
                                    ..maxPrice = int.tryParse(
                                        _model.maxPriceTextController.text)
                                    ..categories = _model.choosenCat.toList()
                                    ..locationRadius = _model.sliderValue
                                    ..cityTitle = _model.locationSelectedOption,
                                );
                                if (_model.switchValue!) {
                                  FFAppState().updateMainFilterStruct(
                                    (e) => e
                                      ..userPoint = _model.searchLatLon
                                      ..locationRadius = _model.sliderValue,
                                  );
                                  safeSetState(() {});
                                } else {
                                  _model.apiResultPlaceLatLon =
                                      await GetPlaceLatLngCall.call(
                                    placeId: _model.placeID,
                                  );

                                  if ((_model.apiResultPlaceLatLon?.succeeded ??
                                      true)) {
                                    FFAppState().updateMainFilterStruct(
                                      (e) => e
                                        ..userPoint = functions.parsCoordinate(
                                            GetPlaceLatLngCall.placeLatLon(
                                          (_model.apiResultPlaceLatLon
                                                  ?.jsonBody ??
                                              ''),
                                        )),
                                    );
                                    safeSetState(() {});
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
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
                                }

                                safeSetState(() {
                                  _model.textController1?.clear();
                                  _model.textController2?.clear();
                                  _model.locationTextController?.clear();
                                  _model.minPriceTextController?.clear();
                                  _model.maxPriceTextController?.clear();
                                });
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'wrlqcq6k' /* Применить */,
                              ),
                              options: FFButtonOptions(
                                height: 58.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
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
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 12.0))
                          .addToStart(SizedBox(width: 24.0))
                          .addToEnd(SizedBox(width: 24.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                    ))
                      wrapWithModel(
                        model: _model.webMenuModel,
                        updateCallback: () => safeSetState(() {}),
                        child: WebMenuWidget(),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      desktop: false,
                    ))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 60.0, 24.0, 0.0),
                        child: wrapWithModel(
                          model: _model.topAvatarNnotificModel,
                          updateCallback: () => safeSetState(() {}),
                          child: TopAvatarNnotificWidget(),
                        ),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      desktop: false,
                    ))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: wrapWithModel(
                          model: _model.mainSearchModel,
                          updateCallback: () => safeSetState(() {}),
                          child: MainSearchWidget(),
                        ),
                      ),
                    Builder(
                      builder: (context) {
                        if (FFAppState().choosenRoleWorker) {
                          return StreamBuilder<List<OrdersRecord>>(
                            stream: queryOrdersRecord(
                              queryBuilder: (ordersRecord) => ordersRecord
                                  .where(
                                    'who_create',
                                    isNotEqualTo: currentUserReference,
                                  )
                                  .where(
                                    'status',
                                    isEqualTo: JobStatus.published.serialize(),
                                  ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<OrdersRecord> containerOrdersRecordList =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if ((currentUserDocument?.kYCStatus ==
                                            KycStatus.not_start) ||
                                        !loggedIn)
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          constraints: BoxConstraints(
                                            minWidth: 400.0,
                                            maxWidth: 1500.0,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                Color(0xFF5089FF)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  1.0, 0.0),
                                              end:
                                                  AlignmentDirectional(-1.0, 0),
                                            ),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 400.0,
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'qijaynu0' /* Профиль исполнителя */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLargeIsCustom,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    1.0,
                                                                    0.0,
                                                                    80.0,
                                                                    0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'eaylkml6' /* Создайте профиль исполнителя. ... */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 1.0),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              if (loggedIn) {
                                                                context.pushNamed(
                                                                    CreateServiceWidget
                                                                        .routeName);
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Dialog(
                                                                      elevation:
                                                                          0,
                                                                      insetPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(dialogContext)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            ModalWindSingUpWidget(),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'oelssbn7' /* Создать профиль */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: 32.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 30.0,
                                                                0.0, 0.0),
                                                    child: Image.asset(
                                                      'assets/images/Girlonbage.png',
                                                      width: 140.0,
                                                      height: 140.0,
                                                      fit: BoxFit.contain,
                                                      alignment:
                                                          Alignment(1.0, 1.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (loggedIn &&
                                        responsiveVisibility(
                                          context: context,
                                          desktop: false,
                                        ))
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'we7rrpka' /* Мой услуги */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLargeFamily,
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineLargeIsCustom,
                                                        ),
                                                  ),
                                                  Builder(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      borderRadius: 8.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 28.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      icon: Icon(
                                                        FFIcons
                                                            .kadditionalIcons1,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 12.0,
                                                      ),
                                                      onPressed: () async {
                                                        if (loggedIn) {
                                                          context.pushNamed(
                                                              CreateServiceWidget
                                                                  .routeName);
                                                        } else {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (dialogContext) {
                                                              return Dialog(
                                                                elevation: 0,
                                                                insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                alignment: AlignmentDirectional(
                                                                        0.0,
                                                                        0.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            dialogContext)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      ModalWindSingUpWidget(),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                      MyJobsWidget.routeName);
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '2llvgqvv' /* Все */,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if ((currentUserDocument?.kYCStatus ==
                                            KycStatus.complite) &&
                                        responsiveVisibility(
                                          context: context,
                                          desktop: false,
                                        ))
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StreamBuilder<ServicesRecord>(
                                                  stream: ServicesRecord.getDocument(
                                                      (currentUserDocument
                                                                  ?.myServices
                                                                  ?.toList() ??
                                                              [])
                                                          .lastOrNull!),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final myJobCardServicesRecord =
                                                        snapshot.data!;

                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          ServiceDetailsWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'serviceDoc':
                                                                serializeParam(
                                                              myJobCardServicesRecord,
                                                              ParamType
                                                                  .Document,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'serviceDoc':
                                                                myJobCardServicesRecord,
                                                          },
                                                        );
                                                      },
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .myJobCardModel1,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child: MyJobCardWidget(
                                                          titleCategory: functions
                                                              .searchCatTitles(
                                                                  FFAppState()
                                                                      .saveCat
                                                                      .toList(),
                                                                  myJobCardServicesRecord
                                                                      .category!),
                                                          jobTitle:
                                                              myJobCardServicesRecord
                                                                  .title,
                                                          jobPrice:
                                                              myJobCardServicesRecord
                                                                  .price,
                                                          sumOffers:
                                                              myJobCardServicesRecord
                                                                  .responce
                                                                  .length,
                                                          sumViews:
                                                              myJobCardServicesRecord
                                                                  .views.length,
                                                          jobStatus:
                                                              myJobCardServicesRecord
                                                                  .status!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      desktop: false,
                                    ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'rttlqqud' /* Рекомендуемые заказы */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLargeFamily,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineLargeIsCustom,
                                                      ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    SearchResultWidget
                                                        .routeName);
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'hmasq0yi' /* Все */,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                      tabletLandscape: false,
                                    ))
                                      Container(
                                        width: 840.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'qcjuulht' /* Рекомендуемые заказы */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displayMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displayMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .displayMediumIsCustom,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 360.0,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController1,
                                                    focusNode: _model
                                                        .textFieldFocusNode1,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController1',
                                                      Duration(
                                                          milliseconds: 2000),
                                                      () async {
                                                        // searchActionOrder
                                                        safeSetState(() {
                                                          _model.simpleSearchResults1 =
                                                              TextSearch(
                                                            containerOrdersRecordList
                                                                .map(
                                                                  (record) => TextSearchItem
                                                                      .fromTerms(
                                                                          record,
                                                                          [
                                                                        record
                                                                            .title!
                                                                      ]),
                                                                )
                                                                .toList(),
                                                          )
                                                                  .search(_model
                                                                      .textController1
                                                                      .text)
                                                                  .map((r) =>
                                                                      r.object)
                                                                  .toList();
                                                          ;
                                                        });
                                                        _model.searchActive =
                                                            true;
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        '08i6l7mj' /* Поиск по названию */,
                                                      ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: Color(
                                                                    0xFFBDBDBD),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: (_model
                                                                  .textFieldFocusNode1
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    maxLength: 40,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .textController1Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.searchActive)
                                                      Text(
                                                        functions
                                                            .filterOrders(
                                                                _model
                                                                    .simpleSearchResults1
                                                                    .toList(),
                                                                FFAppState()
                                                                    .mainFilter)
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                      ),
                                                    if (!_model.searchActive)
                                                      Text(
                                                        functions
                                                            .filterOrders(
                                                                containerOrdersRecordList
                                                                    .toList(),
                                                                FFAppState()
                                                                    .mainFilter)
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                      ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'marzrtc0' /* найдено */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeIsCustom,
                                                          ),
                                                    ),
                                                    if (!_model.showMap)
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.showMap = true;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'dru001d4' /* Показать на карте */,
                                                        ),
                                                        icon: Icon(
                                                          FFIcons
                                                              .kadditionalIcons,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    if (_model.showMap)
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.showMap =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '0cwmfyel' /* Показать списком */,
                                                        ),
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.list,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.choosenCat = FFAppState()
                                                        .mainFilter
                                                        .categories
                                                        .toList()
                                                        .cast<
                                                            DocumentReference>();
                                                    safeSetState(() {});
                                                    scaffoldKey.currentState!
                                                        .openEndDrawer();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: (FFAppState()
                                                                      .mainFilter
                                                                      .userPoint !=
                                                                  functions
                                                                      .reternZeroLoc()) ||
                                                              ((FFAppState().mainFilter.minPrice >
                                                                      0) ||
                                                                  (FFAppState()
                                                                          .mainFilter
                                                                          .maxPrice <
                                                                      1000000)) ||
                                                              (FFAppState()
                                                                  .mainFilter
                                                                  .categories
                                                                  .isNotEmpty)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent1,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.kfilter2,
                                                            color: (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint !=
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    ((FFAppState().mainFilter.minPrice >
                                                                            0) ||
                                                                        (FFAppState().mainFilter.maxPrice <
                                                                            1000000)) ||
                                                                    (FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'pntdqkag' /* Фильтр */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: (FFAppState().mainFilter.userPoint !=
                                                                              functions
                                                                                  .reternZeroLoc()) ||
                                                                          ((FFAppState().mainFilter.minPrice > 0) ||
                                                                              (FFAppState().mainFilter.maxPrice <
                                                                                  1000000)) ||
                                                                          (FFAppState()
                                                                              .mainFilter
                                                                              .categories
                                                                              .isNotEmpty)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          if ((FFAppState()
                                                                      .mainFilter
                                                                      .userPoint !=
                                                                  functions
                                                                      .reternZeroLoc()) ||
                                                              ((FFAppState()
                                                                          .mainFilter
                                                                          .minPrice >
                                                                      0) ||
                                                                  (FFAppState()
                                                                          .mainFilter
                                                                          .maxPrice <
                                                                      1000000)) ||
                                                              (FFAppState()
                                                                  .mainFilter
                                                                  .categories
                                                                  .isNotEmpty))
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                FFAppState()
                                                                        .mainFilter =
                                                                    FilterDataStruct
                                                                        .fromSerializableMap(
                                                                            jsonDecode('{\"userPoint\":\"0.0,0.0\",\"categories\":\"[]\"}'));
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons.close,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 8.0))
                                                            .addToStart(
                                                                SizedBox(
                                                                    width: 8.0))
                                                            .addToEnd(SizedBox(
                                                                width: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebLocationWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FFAppState()
                                                                    .mainFilter
                                                                    .userPoint !=
                                                                functions
                                                                    .reternZeroLoc()
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'bw5wrprf' /* Локация */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FFAppState().mainFilter.userPoint !=
                                                                            functions
                                                                                .reternZeroLoc()
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if (FFAppState()
                                                                    .mainFilter
                                                                    .userPoint !=
                                                                functions
                                                                    .reternZeroLoc())
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..userPoint =
                                                                          functions
                                                                              .reternZeroLoc()
                                                                      ..locationRadius =
                                                                          null,
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebPriceWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (FFAppState()
                                                                        .mainFilter
                                                                        .minPrice >
                                                                    0) ||
                                                                (FFAppState()
                                                                        .mainFilter
                                                                        .maxPrice <
                                                                    1000000)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'hyadx5bq' /* Цена */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: (FFAppState().mainFilter.minPrice >
                                                                                0) ||
                                                                            (FFAppState().mainFilter.maxPrice <
                                                                                1000000)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if ((FFAppState()
                                                                        .mainFilter
                                                                        .minPrice >
                                                                    0) ||
                                                                (FFAppState()
                                                                        .mainFilter
                                                                        .maxPrice <
                                                                    1000000))
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..minPrice =
                                                                          null
                                                                      ..maxPrice =
                                                                          null,
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebCategoryWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FFAppState()
                                                                .mainFilter
                                                                .categories
                                                                .isNotEmpty
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'rkre4i3q' /* Специализация */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .isNotEmpty
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if (FFAppState()
                                                                .mainFilter
                                                                .categories
                                                                .isNotEmpty)
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..categories =
                                                                          [],
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    Builder(
                                      builder: (context) {
                                        if (_model.showMap) {
                                          return Container(
                                            width: 1200.0,
                                            height: 600.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (!_model.searchActive)
                                                  Expanded(
                                                    child: Builder(
                                                      builder: (context) =>
                                                          FlutterFlowGoogleMap(
                                                        controller: _model
                                                            .googleMapsController1,
                                                        onCameraIdle: (latLng) =>
                                                            _model.googleMapsCenter1 =
                                                                latLng,
                                                        initialLocation: _model
                                                                .googleMapsCenter1 ??=
                                                            currentUserLocationValue!,
                                                        markers:
                                                            containerOrdersRecordList
                                                                .where((e) =>
                                                                    ((FFAppState().mainFilter.minPrice <=
                                                                            e
                                                                                .price) ||
                                                                        !FFAppState()
                                                                            .mainFilter
                                                                            .hasMinPrice()) &&
                                                                    ((FFAppState().mainFilter.maxPrice >=
                                                                            e
                                                                                .price) ||
                                                                        !FFAppState()
                                                                            .mainFilter
                                                                            .hasMaxPrice()) &&
                                                                    ((FFAppState().mainFilter.categories.contains(e.category) ==
                                                                            true) ||
                                                                        !(FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .isNotEmpty)) &&
                                                                    (functions.degreesToRadians(
                                                                            FFAppState().mainFilter.userPoint,
                                                                            valueOrDefault<double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            e.location)! ||
                                                                        (FFAppState().mainFilter.userPoint == functions.reternZeroLoc()) ||
                                                                        (currentUserLocationValue == null)) &&
                                                                    (e.whoCreate != currentUserReference))
                                                                .toList()
                                                                .map(
                                                                  (marker) =>
                                                                      FlutterFlowMarker(
                                                                    marker
                                                                        .reference
                                                                        .path,
                                                                    marker
                                                                        .location!,
                                                                    () async {
                                                                      await showAlignedDialog(
                                                                        barrierColor:
                                                                            Colors.transparent,
                                                                        context:
                                                                            context,
                                                                        isGlobal:
                                                                            false,
                                                                        avoidOverflow:
                                                                            false,
                                                                        targetAnchor:
                                                                            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                        followerAnchor:
                                                                            AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: JobCardLiteWidget(
                                                                                userData: marker.whoCreate!,
                                                                                price: marker.price,
                                                                                titleCategory: functions.searchCatTitles(FFAppState().saveCat.toList(), marker.category!),
                                                                                orderCity: marker.locationTitle,
                                                                                jobTitle: marker.title,
                                                                                orderDoc: marker,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                        markerColor:
                                                            GoogleMarkerColor
                                                                .blue,
                                                        mapType: MapType.normal,
                                                        style: GoogleMapStyle
                                                            .standard,
                                                        initialZoom: 14.0,
                                                        allowInteraction: true,
                                                        allowZoom: true,
                                                        showZoomControls: true,
                                                        showLocation: true,
                                                        showCompass: false,
                                                        showMapToolbar: false,
                                                        showTraffic: false,
                                                        centerMapOnMarkerTap:
                                                            true,
                                                      ),
                                                    ),
                                                  ),
                                                if (_model.searchActive)
                                                  Expanded(
                                                    child: Builder(
                                                      builder: (context) =>
                                                          FlutterFlowGoogleMap(
                                                        controller: _model
                                                            .googleMapsController2,
                                                        onCameraIdle: (latLng) =>
                                                            _model.googleMapsCenter2 =
                                                                latLng,
                                                        initialLocation: _model
                                                                .googleMapsCenter2 ??=
                                                            currentUserLocationValue!,
                                                        markers: _model
                                                            .simpleSearchResults1
                                                            .where((e) =>
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        e
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .maxPrice >=
                                                                        e
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(
                                                                                e
                                                                                    .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            e
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null)) &&
                                                                (e.whoCreate !=
                                                                    currentUserReference))
                                                            .toList()
                                                            .map(
                                                              (marker) =>
                                                                  FlutterFlowMarker(
                                                                marker.reference
                                                                    .path,
                                                                marker
                                                                    .location!,
                                                                () async {
                                                                  await showAlignedDialog(
                                                                    barrierColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              JobCardLiteWidget(
                                                                            userData:
                                                                                marker.whoCreate!,
                                                                            price:
                                                                                marker.price,
                                                                            titleCategory:
                                                                                functions.searchCatTitles(FFAppState().saveCat.toList(), marker.category!),
                                                                            orderCity:
                                                                                marker.locationTitle,
                                                                            jobTitle:
                                                                                marker.title,
                                                                            orderDoc:
                                                                                marker,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                        markerColor:
                                                            GoogleMarkerColor
                                                                .blue,
                                                        mapType: MapType.normal,
                                                        style: GoogleMapStyle
                                                            .standard,
                                                        initialZoom: 14.0,
                                                        allowInteraction: true,
                                                        allowZoom: true,
                                                        showZoomControls: true,
                                                        showLocation: true,
                                                        showCompass: false,
                                                        showMapToolbar: false,
                                                        showTraffic: false,
                                                        centerMapOnMarkerTap:
                                                            true,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.searchActive)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          100.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final orderSearch = _model
                                                          .simpleSearchResults1
                                                          .toList();
                                                      if (orderSearch.isEmpty) {
                                                        return EmtpySearchWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            orderSearch.length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 24.0),
                                                        itemBuilder: (context,
                                                            orderSearchIndex) {
                                                          final orderSearchItem =
                                                              orderSearch[
                                                                  orderSearchIndex];
                                                          return Visibility(
                                                            visible: ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        orderSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState().mainFilter.maxPrice >=
                                                                        orderSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(
                                                                                orderSearchItem
                                                                                    .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            orderSearchItem
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null) ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .locationRadius ==
                                                                        0.0)) &&
                                                                (orderSearchItem
                                                                        .whoCreate !=
                                                                    currentUserReference) &&
                                                                (orderSearchItem
                                                                        .status !=
                                                                    JobStatus
                                                                        .hide),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (() {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return true;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return false;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return false;
                                                                    } else {
                                                                      return false;
                                                                    }
                                                                  }()) {
                                                                    context
                                                                        .pushNamed(
                                                                      OrderDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'orderDoc':
                                                                            serializeParam(
                                                                          orderSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'orderDoc':
                                                                            orderSearchItem,
                                                                      },
                                                                    );
                                                                  } else {
                                                                    context
                                                                        .pushNamed(
                                                                      WebOrderDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'orderDoc':
                                                                            serializeParam(
                                                                          orderSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'orderDoc':
                                                                            orderSearchItem,
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .jobCardLiteModels1
                                                                      .getModel(
                                                                    orderSearchItem
                                                                        .reference
                                                                        .id,
                                                                    orderSearchIndex,
                                                                  ),
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      JobCardLiteWidget(
                                                                    key: Key(
                                                                      'Keyfuv_${orderSearchItem.reference.id}',
                                                                    ),
                                                                    price: orderSearchItem
                                                                        .price,
                                                                    titleCategory: functions.searchCatTitles(
                                                                        FFAppState()
                                                                            .saveCat
                                                                            .toList(),
                                                                        orderSearchItem
                                                                            .category!),
                                                                    userData:
                                                                        orderSearchItem
                                                                            .whoCreate!,
                                                                    orderCity:
                                                                        orderSearchItem
                                                                            .locationTitle,
                                                                    jobTitle:
                                                                        orderSearchItem
                                                                            .title,
                                                                    orderDoc:
                                                                        orderSearchItem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              if (!_model.searchActive)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          100.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final orderNoSearch =
                                                          containerOrdersRecordList
                                                              .toList();
                                                      if (orderNoSearch
                                                          .isEmpty) {
                                                        return EmtpySearchWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: orderNoSearch
                                                            .length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 24.0),
                                                        itemBuilder: (context,
                                                            orderNoSearchIndex) {
                                                          final orderNoSearchItem =
                                                              orderNoSearch[
                                                                  orderNoSearchIndex];
                                                          return Visibility(
                                                            visible: ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        orderNoSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState().mainFilter.maxPrice >=
                                                                        orderNoSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(
                                                                                orderNoSearchItem
                                                                                    .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            orderNoSearchItem
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null) ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .locationRadius ==
                                                                        0.0)) &&
                                                                (orderNoSearchItem
                                                                        .whoCreate !=
                                                                    currentUserReference) &&
                                                                (orderNoSearchItem
                                                                        .status !=
                                                                    JobStatus
                                                                        .hide),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (() {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return true;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return false;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return false;
                                                                    } else {
                                                                      return false;
                                                                    }
                                                                  }()) {
                                                                    context
                                                                        .pushNamed(
                                                                      OrderDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'orderDoc':
                                                                            serializeParam(
                                                                          orderNoSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'orderDoc':
                                                                            orderNoSearchItem,
                                                                      },
                                                                    );
                                                                  } else {
                                                                    context
                                                                        .pushNamed(
                                                                      WebOrderDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'orderDoc':
                                                                            serializeParam(
                                                                          orderNoSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'orderDoc':
                                                                            orderNoSearchItem,
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .jobCardLiteModels2
                                                                      .getModel(
                                                                    orderNoSearchItem
                                                                        .reference
                                                                        .id,
                                                                    orderNoSearchIndex,
                                                                  ),
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      JobCardLiteWidget(
                                                                    key: Key(
                                                                      'Keyawa_${orderNoSearchItem.reference.id}',
                                                                    ),
                                                                    price: orderNoSearchItem
                                                                        .price,
                                                                    titleCategory: functions.searchCatTitles(
                                                                        FFAppState()
                                                                            .saveCat
                                                                            .toList(),
                                                                        orderNoSearchItem
                                                                            .category!),
                                                                    userData:
                                                                        orderNoSearchItem
                                                                            .whoCreate!,
                                                                    orderCity:
                                                                        orderNoSearchItem
                                                                            .locationTitle,
                                                                    jobTitle:
                                                                        orderNoSearchItem
                                                                            .title,
                                                                    orderDoc:
                                                                        orderNoSearchItem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              );
                            },
                          );
                        } else {
                          return StreamBuilder<List<ServicesRecord>>(
                            stream: queryServicesRecord(
                              queryBuilder: (servicesRecord) => servicesRecord
                                  .where(
                                    'status',
                                    isEqualTo: JobStatus.published.serialize(),
                                  )
                                  .where(
                                    'who_create',
                                    isNotEqualTo: currentUserReference,
                                  ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<ServicesRecord> containerServicesRecordList =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (!loggedIn ||
                                        !((currentUserDocument?.myOrders
                                                    ?.toList() ??
                                                [])
                                            .isNotEmpty))
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          constraints: BoxConstraints(
                                            minWidth: 400.0,
                                            maxWidth: 1500.0,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                Color(0xFF5089FF)
                                              ],
                                              stops: [0.0, 1.0],
                                              begin: AlignmentDirectional(
                                                  1.0, 0.0),
                                              end:
                                                  AlignmentDirectional(-1.0, 0),
                                            ),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 400.0,
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'bxpm5l2o' /* Профиль заказчика */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineLargeIsCustom,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    1.0,
                                                                    0.0,
                                                                    80.0,
                                                                    0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '65lewur7' /* Создайте свой первый заказ. А ... */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 1.0),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              if (loggedIn) {
                                                                context.pushNamed(
                                                                    CreateOrderWidget
                                                                        .routeName);
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Dialog(
                                                                      elevation:
                                                                          0,
                                                                      insetPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(dialogContext)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            ModalWindSingUpWidget(),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '85ceulnd' /* Создать профиль */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: 32.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 30.0,
                                                                0.0, 0.0),
                                                    child: Image.asset(
                                                      'assets/images/Girlonbage.png',
                                                      width: 140.0,
                                                      height: 140.0,
                                                      fit: BoxFit.contain,
                                                      alignment:
                                                          Alignment(1.0, 1.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (loggedIn &&
                                        responsiveVisibility(
                                          context: context,
                                          desktop: false,
                                        ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '4hy4ralc' /* Мой заказы */,
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeIsCustom,
                                                          ),
                                                ),
                                                Builder(
                                                  builder: (context) =>
                                                      FlutterFlowIconButton(
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    borderRadius: 8.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 28.0,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    icon: Icon(
                                                      FFIcons.kadditionalIcons1,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 12.0,
                                                    ),
                                                    onPressed: () async {
                                                      if (loggedIn) {
                                                        context.pushNamed(
                                                            CreateOrderWidget
                                                                .routeName);
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      0.0, 0.0)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    ModalWindSingUpWidget(),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 12.0)),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    MyJobsWidget.routeName);
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'q5psjb2v' /* Все */,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if ((((currentUserDocument?.myOrders
                                                        ?.toList() ??
                                                    [])
                                                .isNotEmpty) &&
                                            loggedIn) &&
                                        responsiveVisibility(
                                          context: context,
                                          desktop: false,
                                        ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => Container(
                                            decoration: BoxDecoration(),
                                            child: FutureBuilder<OrdersRecord>(
                                              future:
                                                  OrdersRecord.getDocumentOnce(
                                                      (currentUserDocument
                                                                  ?.myOrders
                                                                  ?.toList() ??
                                                              [])
                                                          .lastOrNull!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                final myJobCardOrdersRecord =
                                                    snapshot.data!;

                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      OrderDetailsWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'orderDoc':
                                                            serializeParam(
                                                          myJobCardOrdersRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'orderDoc':
                                                            myJobCardOrdersRecord,
                                                      },
                                                    );
                                                  },
                                                  child: wrapWithModel(
                                                    model:
                                                        _model.myJobCardModel2,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: MyJobCardWidget(
                                                      titleCategory: functions
                                                          .searchCatTitles(
                                                              FFAppState()
                                                                  .saveCat
                                                                  .toList(),
                                                              myJobCardOrdersRecord
                                                                  .category!),
                                                      jobTitle:
                                                          myJobCardOrdersRecord
                                                              .title,
                                                      jobPrice:
                                                          myJobCardOrdersRecord
                                                              .price,
                                                      sumOffers:
                                                          myJobCardOrdersRecord
                                                              .responces.length,
                                                      sumViews:
                                                          myJobCardOrdersRecord
                                                              .views.length,
                                                      jobStatus:
                                                          myJobCardOrdersRecord
                                                              .status!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      desktop: false,
                                    ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '46xwdi68' /* Рекомендуемые услуги */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLargeFamily,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineLargeIsCustom,
                                                      ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    SearchResultWidget
                                                        .routeName);
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                's2cus4t6' /* Все */,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                      tabletLandscape: false,
                                    ))
                                      Container(
                                        width: 840.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '75mr9i40' /* Рекомендуемые услуги */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displayMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displayMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .displayMediumIsCustom,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 360.0,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController2,
                                                    focusNode: _model
                                                        .textFieldFocusNode2,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.textController2',
                                                      Duration(
                                                          milliseconds: 2000),
                                                      () async {
                                                        // searchActionOrder
                                                        safeSetState(() {
                                                          _model.simpleSearchResults2 =
                                                              TextSearch(
                                                            containerServicesRecordList
                                                                .map(
                                                                  (record) => TextSearchItem
                                                                      .fromTerms(
                                                                          record,
                                                                          [
                                                                        record
                                                                            .title!
                                                                      ]),
                                                                )
                                                                .toList(),
                                                          )
                                                                  .search(_model
                                                                      .textController2
                                                                      .text)
                                                                  .map((r) =>
                                                                      r.object)
                                                                  .toList();
                                                          ;
                                                        });
                                                        _model.searchActive =
                                                            true;
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'g6n648ep' /* Поиск по названию */,
                                                      ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: Color(
                                                                    0xFFBDBDBD),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: (_model
                                                                  .textFieldFocusNode2
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                                    maxLength: 40,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .textController2Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.searchActive)
                                                      Text(
                                                        functions
                                                            .filterServices(
                                                                _model
                                                                    .simpleSearchResults2
                                                                    .toList(),
                                                                FFAppState()
                                                                    .mainFilter)
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                      ),
                                                    if (!_model.searchActive)
                                                      Text(
                                                        functions
                                                            .filterServices(
                                                                containerServicesRecordList
                                                                    .toList(),
                                                                FFAppState()
                                                                    .mainFilter)
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeFamily,
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLargeIsCustom,
                                                            ),
                                                      ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '3gbrndr2' /* найдено */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeIsCustom,
                                                          ),
                                                    ),
                                                    if (!_model.showMap)
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.showMap = true;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'gqj2txbv' /* Показать на карте */,
                                                        ),
                                                        icon: Icon(
                                                          FFIcons
                                                              .kadditionalIcons,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    if (_model.showMap)
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.showMap =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'hkvt2ix9' /* Показать списком */,
                                                        ),
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.list,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                  ].divide(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.choosenCat = FFAppState()
                                                        .mainFilter
                                                        .categories
                                                        .toList()
                                                        .cast<
                                                            DocumentReference>();
                                                    safeSetState(() {});
                                                    scaffoldKey.currentState!
                                                        .openEndDrawer();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: (FFAppState()
                                                                      .mainFilter
                                                                      .userPoint !=
                                                                  functions
                                                                      .reternZeroLoc()) ||
                                                              ((FFAppState().mainFilter.minPrice >
                                                                      0) ||
                                                                  (FFAppState()
                                                                          .mainFilter
                                                                          .maxPrice <
                                                                      1000000)) ||
                                                              (FFAppState()
                                                                  .mainFilter
                                                                  .categories
                                                                  .isNotEmpty)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent1,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.kfilter2,
                                                            color: (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint !=
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    ((FFAppState().mainFilter.minPrice >
                                                                            0) ||
                                                                        (FFAppState().mainFilter.maxPrice <
                                                                            1000000)) ||
                                                                    (FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'k9dkkbvo' /* Фильтр */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: (FFAppState().mainFilter.userPoint !=
                                                                              functions
                                                                                  .reternZeroLoc()) ||
                                                                          ((FFAppState().mainFilter.minPrice > 0) ||
                                                                              (FFAppState().mainFilter.maxPrice <
                                                                                  1000000)) ||
                                                                          (FFAppState()
                                                                              .mainFilter
                                                                              .categories
                                                                              .isNotEmpty)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallIsCustom,
                                                                ),
                                                          ),
                                                          if ((FFAppState()
                                                                      .mainFilter
                                                                      .userPoint !=
                                                                  functions
                                                                      .reternZeroLoc()) ||
                                                              ((FFAppState()
                                                                          .mainFilter
                                                                          .minPrice >
                                                                      0) ||
                                                                  (FFAppState()
                                                                          .mainFilter
                                                                          .maxPrice <
                                                                      1000000)) ||
                                                              (FFAppState()
                                                                  .mainFilter
                                                                  .categories
                                                                  .isNotEmpty))
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                FFAppState()
                                                                        .mainFilter =
                                                                    FilterDataStruct
                                                                        .fromSerializableMap(
                                                                            jsonDecode('{\"userPoint\":\"0.0,0.0\",\"categories\":\"[]\"}'));
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons.close,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 8.0))
                                                            .addToStart(
                                                                SizedBox(
                                                                    width: 8.0))
                                                            .addToEnd(SizedBox(
                                                                width: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebLocationWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FFAppState()
                                                                    .mainFilter
                                                                    .userPoint !=
                                                                functions
                                                                    .reternZeroLoc()
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'sjs7fsgo' /* Локация */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FFAppState().mainFilter.userPoint !=
                                                                            functions
                                                                                .reternZeroLoc()
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if (FFAppState()
                                                                    .mainFilter
                                                                    .userPoint !=
                                                                functions
                                                                    .reternZeroLoc())
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..userPoint =
                                                                          functions
                                                                              .reternZeroLoc()
                                                                      ..locationRadius =
                                                                          null,
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebPriceWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (FFAppState()
                                                                        .mainFilter
                                                                        .minPrice >
                                                                    0) ||
                                                                (FFAppState()
                                                                        .mainFilter
                                                                        .maxPrice <
                                                                    1000000)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'iphst066' /* Цена */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: (FFAppState().mainFilter.minPrice >
                                                                                0) ||
                                                                            (FFAppState().mainFilter.maxPrice <
                                                                                1000000)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if ((FFAppState()
                                                                        .mainFilter
                                                                        .minPrice >
                                                                    0) ||
                                                                (FFAppState()
                                                                        .mainFilter
                                                                        .maxPrice <
                                                                    1000000))
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..minPrice =
                                                                          null
                                                                      ..maxPrice =
                                                                          null,
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showAlignedDialog(
                                                        barrierColor:
                                                            Color(0x00FFFFFF),
                                                        context: context,
                                                        isGlobal: false,
                                                        avoidOverflow: false,
                                                        targetAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, 1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        followerAnchor:
                                                            AlignmentDirectional(
                                                                    -1.0, -1.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        builder:
                                                            (dialogContext) {
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  WebCategoryWidget(),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FFAppState()
                                                                .mainFilter
                                                                .categories
                                                                .isNotEmpty
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'kluk3j94' /* Специализация */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .isNotEmpty
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                            ),
                                                            if (FFAppState()
                                                                .mainFilter
                                                                .categories
                                                                .isNotEmpty)
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .updateMainFilterStruct(
                                                                    (e) => e
                                                                      ..categories =
                                                                          [],
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 18.0,
                                                                ),
                                                              ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 8.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      width:
                                                                          8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    Builder(
                                      builder: (context) {
                                        if (_model.showMap) {
                                          return Container(
                                            width: 1200.0,
                                            height: 600.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (!_model.searchActive)
                                                  Expanded(
                                                    child: Builder(
                                                      builder: (context) =>
                                                          FlutterFlowGoogleMap(
                                                        controller: _model
                                                            .googleMapsController3,
                                                        onCameraIdle: (latLng) =>
                                                            _model.googleMapsCenter3 =
                                                                latLng,
                                                        initialLocation: _model
                                                                .googleMapsCenter3 ??=
                                                            currentUserLocationValue!,
                                                        markers:
                                                            containerServicesRecordList
                                                                .where((e) =>
                                                                    ((FFAppState().mainFilter.minPrice <=
                                                                            e
                                                                                .price) ||
                                                                        !FFAppState()
                                                                            .mainFilter
                                                                            .hasMinPrice()) &&
                                                                    ((FFAppState().mainFilter.maxPrice >=
                                                                            e
                                                                                .price) ||
                                                                        !FFAppState()
                                                                            .mainFilter
                                                                            .hasMaxPrice()) &&
                                                                    ((FFAppState().mainFilter.categories.contains(e.category) ==
                                                                            true) ||
                                                                        !(FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .isNotEmpty)) &&
                                                                    (functions.degreesToRadians(
                                                                            FFAppState().mainFilter.userPoint,
                                                                            valueOrDefault<double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            e.location)! ||
                                                                        (FFAppState().mainFilter.userPoint == functions.reternZeroLoc()) ||
                                                                        (currentUserLocationValue == null)) &&
                                                                    (e.reference != currentUserReference))
                                                                .toList()
                                                                .map(
                                                                  (marker) =>
                                                                      FlutterFlowMarker(
                                                                    marker
                                                                        .reference
                                                                        .path,
                                                                    marker
                                                                        .location!,
                                                                    () async {
                                                                      await showAlignedDialog(
                                                                        barrierColor:
                                                                            Colors.transparent,
                                                                        context:
                                                                            context,
                                                                        isGlobal:
                                                                            false,
                                                                        avoidOverflow:
                                                                            false,
                                                                        targetAnchor:
                                                                            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                        followerAnchor:
                                                                            AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: JobCardLiteWidget(
                                                                                userData: marker.whoCreate!,
                                                                                price: marker.price,
                                                                                titleCategory: functions.searchCatTitles(FFAppState().saveCat.toList(), marker.category!),
                                                                                orderCity: marker.locationTitle,
                                                                                jobTitle: marker.title,
                                                                                servDoc: marker,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                        markerColor:
                                                            GoogleMarkerColor
                                                                .blue,
                                                        mapType: MapType.normal,
                                                        style: GoogleMapStyle
                                                            .standard,
                                                        initialZoom: 14.0,
                                                        allowInteraction: true,
                                                        allowZoom: true,
                                                        showZoomControls: true,
                                                        showLocation: true,
                                                        showCompass: false,
                                                        showMapToolbar: false,
                                                        showTraffic: false,
                                                        centerMapOnMarkerTap:
                                                            true,
                                                      ),
                                                    ),
                                                  ),
                                                if (_model.searchActive)
                                                  Expanded(
                                                    child: Builder(
                                                      builder: (context) =>
                                                          FlutterFlowGoogleMap(
                                                        controller: _model
                                                            .googleMapsController4,
                                                        onCameraIdle: (latLng) =>
                                                            _model.googleMapsCenter4 =
                                                                latLng,
                                                        initialLocation: _model
                                                                .googleMapsCenter4 ??=
                                                            currentUserLocationValue!,
                                                        markers: _model
                                                            .simpleSearchResults2
                                                            .where((e) =>
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        e
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .maxPrice >=
                                                                        e
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(
                                                                                e
                                                                                    .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            e
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null)) &&
                                                                (e.reference !=
                                                                    currentUserReference))
                                                            .toList()
                                                            .map(
                                                              (marker) =>
                                                                  FlutterFlowMarker(
                                                                marker.reference
                                                                    .path,
                                                                marker
                                                                    .location!,
                                                                () async {
                                                                  await showAlignedDialog(
                                                                    barrierColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              JobCardLiteWidget(
                                                                            userData:
                                                                                marker.whoCreate!,
                                                                            price:
                                                                                marker.price,
                                                                            titleCategory:
                                                                                functions.searchCatTitles(FFAppState().saveCat.toList(), marker.category!),
                                                                            orderCity:
                                                                                marker.locationTitle,
                                                                            jobTitle:
                                                                                marker.title,
                                                                            servDoc:
                                                                                marker,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                        markerColor:
                                                            GoogleMarkerColor
                                                                .blue,
                                                        mapType: MapType.normal,
                                                        style: GoogleMapStyle
                                                            .standard,
                                                        initialZoom: 14.0,
                                                        allowInteraction: true,
                                                        allowZoom: true,
                                                        showZoomControls: true,
                                                        showLocation: true,
                                                        showCompass: false,
                                                        showMapToolbar: false,
                                                        showTraffic: false,
                                                        centerMapOnMarkerTap:
                                                            true,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (!_model.searchActive)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          100.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final serviceNoSearch =
                                                          containerServicesRecordList
                                                              .toList();
                                                      if (serviceNoSearch
                                                          .isEmpty) {
                                                        return EmtpySearchWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            serviceNoSearch
                                                                .length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 24.0),
                                                        itemBuilder: (context,
                                                            serviceNoSearchIndex) {
                                                          final serviceNoSearchItem =
                                                              serviceNoSearch[
                                                                  serviceNoSearchIndex];
                                                          return Visibility(
                                                            visible: ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        serviceNoSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState().mainFilter.maxPrice >=
                                                                        serviceNoSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(serviceNoSearchItem
                                                                                .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            serviceNoSearchItem
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null) ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .locationRadius ==
                                                                        0.0)),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (() {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return true;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return false;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return false;
                                                                    } else {
                                                                      return false;
                                                                    }
                                                                  }()) {
                                                                    context
                                                                        .pushNamed(
                                                                      ServiceDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'serviceDoc':
                                                                            serializeParam(
                                                                          serviceNoSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'serviceDoc':
                                                                            serviceNoSearchItem,
                                                                      },
                                                                    );
                                                                  } else {
                                                                    context
                                                                        .pushNamed(
                                                                      WebServiceDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'serviceDoc':
                                                                            serializeParam(
                                                                          serviceNoSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'serviceDoc':
                                                                            serviceNoSearchItem,
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .jobCardLiteModels3
                                                                      .getModel(
                                                                    serviceNoSearchItem
                                                                        .reference
                                                                        .id,
                                                                    serviceNoSearchIndex,
                                                                  ),
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      JobCardLiteWidget(
                                                                    key: Key(
                                                                      'Key8jo_${serviceNoSearchItem.reference.id}',
                                                                    ),
                                                                    price: serviceNoSearchItem
                                                                        .price,
                                                                    titleCategory: functions.searchCatTitles(
                                                                        FFAppState()
                                                                            .saveCat
                                                                            .toList(),
                                                                        serviceNoSearchItem
                                                                            .category!),
                                                                    userData:
                                                                        serviceNoSearchItem
                                                                            .whoCreate!,
                                                                    orderCity:
                                                                        serviceNoSearchItem
                                                                            .locationTitle,
                                                                    jobTitle:
                                                                        serviceNoSearchItem
                                                                            .title,
                                                                    servDoc:
                                                                        serviceNoSearchItem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              if (_model.searchActive)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 0.0, 24.0,
                                                          100.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final serviceSearch = _model
                                                          .simpleSearchResults2
                                                          .toList();
                                                      if (serviceSearch
                                                          .isEmpty) {
                                                        return EmtpySearchWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: serviceSearch
                                                            .length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                height: 24.0),
                                                        itemBuilder: (context,
                                                            serviceSearchIndex) {
                                                          final serviceSearchItem =
                                                              serviceSearch[
                                                                  serviceSearchIndex];
                                                          return Visibility(
                                                            visible: ((FFAppState()
                                                                            .mainFilter
                                                                            .minPrice <=
                                                                        serviceSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMinPrice()) &&
                                                                ((FFAppState().mainFilter.maxPrice >=
                                                                        serviceSearchItem
                                                                            .price) ||
                                                                    !FFAppState()
                                                                        .mainFilter
                                                                        .hasMaxPrice()) &&
                                                                ((FFAppState()
                                                                            .mainFilter
                                                                            .categories
                                                                            .contains(serviceSearchItem
                                                                                .category) ==
                                                                        true) ||
                                                                    !(FFAppState()
                                                                        .mainFilter
                                                                        .categories
                                                                        .isNotEmpty)) &&
                                                                (functions
                                                                        .degreesToRadians(
                                                                            FFAppState()
                                                                                .mainFilter
                                                                                .userPoint,
                                                                            valueOrDefault<
                                                                                double>(
                                                                              FFAppState().mainFilter.locationRadius,
                                                                              10.0,
                                                                            ),
                                                                            serviceSearchItem
                                                                                .location)! ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .userPoint ==
                                                                        functions
                                                                            .reternZeroLoc()) ||
                                                                    (currentUserLocationValue ==
                                                                        null) ||
                                                                    (FFAppState()
                                                                            .mainFilter
                                                                            .locationRadius ==
                                                                        0.0)),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (() {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return true;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return false;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return false;
                                                                    } else {
                                                                      return false;
                                                                    }
                                                                  }()) {
                                                                    context
                                                                        .pushNamed(
                                                                      ServiceDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'serviceDoc':
                                                                            serializeParam(
                                                                          serviceSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'serviceDoc':
                                                                            serviceSearchItem,
                                                                      },
                                                                    );
                                                                  } else {
                                                                    context
                                                                        .pushNamed(
                                                                      WebServiceDetailsWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'serviceDoc':
                                                                            serializeParam(
                                                                          serviceSearchItem,
                                                                          ParamType
                                                                              .Document,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        'serviceDoc':
                                                                            serviceSearchItem,
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .jobCardLiteModels4
                                                                      .getModel(
                                                                    serviceSearchItem
                                                                        .reference
                                                                        .id,
                                                                    serviceSearchIndex,
                                                                  ),
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      JobCardLiteWidget(
                                                                    key: Key(
                                                                      'Keyyja_${serviceSearchItem.reference.id}',
                                                                    ),
                                                                    price: serviceSearchItem
                                                                        .price,
                                                                    titleCategory: functions.searchCatTitles(
                                                                        FFAppState()
                                                                            .saveCat
                                                                            .toList(),
                                                                        serviceSearchItem
                                                                            .category!),
                                                                    userData:
                                                                        serviceSearchItem
                                                                            .whoCreate!,
                                                                    orderCity:
                                                                        serviceSearchItem
                                                                            .locationTitle,
                                                                    jobTitle:
                                                                        serviceSearchItem
                                                                            .title,
                                                                    servDoc:
                                                                        serviceSearchItem,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: wrapWithModel(
                        model: _model.mapButtonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MapButtonWidget(),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: wrapWithModel(
                        model: _model.menuModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MenuWidget(
                          currentPage: CurrentPage.main,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
