import '/app_components/map_button/map_button_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_search/emtpy_search_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'search_result_model.dart';
export 'search_result_model.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({super.key});

  static String routeName = 'SearchResult';
  static String routePath = '/searchResult';

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  late SearchResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.searchActive = false;
      safeSetState(() {});
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Builder(
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
                  List<OrdersRecord> containerOrdersRecordList = snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          context
                                              .pushNamed(MainWidget.routeName);
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 200.0,
                                          child: TextFormField(
                                            controller: _model.textController1,
                                            focusNode:
                                                _model.textFieldFocusNode1,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.textController1',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                // searchAction
                                                safeSetState(() {
                                                  _model.simpleSearchResults1 =
                                                      TextSearch(
                                                    containerOrdersRecordList
                                                        .map(
                                                          (record) =>
                                                              TextSearchItem
                                                                  .fromTerms(
                                                                      record, [
                                                            record.title!
                                                          ]),
                                                        )
                                                        .toList(),
                                                  )
                                                          .search(_model
                                                              .textController1
                                                              .text)
                                                          .map((r) => r.object)
                                                          .toList();
                                                  ;
                                                });
                                                _model.searchResult = _model
                                                    .simpleSearchResults1
                                                    .length;
                                                _model.searchActive = true;
                                                safeSetState(() {});
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                              hintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'e4g0dfb0' /* Поиск по названию */,
                                              ),
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily,
                                                    color: Color(0xFFBDBDBD),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumIsCustom,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              filled: true,
                                              fillColor: (_model
                                                          .textFieldFocusNode1
                                                          ?.hasFocus ??
                                                      false)
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : FlutterFlowTheme.of(context)
                                                      .accent4,
                                              prefixIcon: Icon(
                                                Icons.search,
                                                size: 20.0,
                                              ),
                                              suffixIcon:
                                                  _model.textController1!.text
                                                          .isNotEmpty
                                                      ? InkWell(
                                                          onTap: () async {
                                                            _model
                                                                .textController1
                                                                ?.clear(); // searchAction
                                                            safeSetState(() {
                                                              _model.simpleSearchResults1 =
                                                                  TextSearch(
                                                                containerOrdersRecordList
                                                                    .map(
                                                                      (record) =>
                                                                          TextSearchItem.fromTerms(
                                                                              record,
                                                                              [
                                                                            record.title!
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
                                                            _model.searchResult =
                                                                _model
                                                                    .simpleSearchResults1
                                                                    .length;
                                                            _model.searchActive =
                                                                true;
                                                            safeSetState(() {});
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.clear,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        )
                                                      : null,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                            maxLength: 40,
                                            buildCounter: (context,
                                                    {required currentLength,
                                                    required isFocused,
                                                    maxLength}) =>
                                                null,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .textController1Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        fillColor: Color(0xFFF5F5F5),
                                        icon: Icon(
                                          FFIcons.kfilter2,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed(
                                              AllFilterWidget.routeName);
                                        },
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (!_model.searchActive)
                                      Text(
                                        functions
                                            .filterOrders(
                                                containerOrdersRecordList
                                                    .toList(),
                                                FFAppState().mainFilter)
                                            .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                      ),
                                    if (_model.searchActive)
                                      Text(
                                        functions
                                            .filterOrders(
                                                _model.simpleSearchResults1
                                                    .toList(),
                                                FFAppState().mainFilter)
                                            .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                      ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'yrif6q1b' /* найдено */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineLargeIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                              if (!_model.searchActive)
                                Builder(
                                  builder: (context) {
                                    final notActivSearchOrders =
                                        containerOrdersRecordList.toList();
                                    if (notActivSearchOrders.isEmpty) {
                                      return EmtpySearchWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        24.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notActivSearchOrders.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder:
                                          (context, notActivSearchOrdersIndex) {
                                        final notActivSearchOrdersItem =
                                            notActivSearchOrders[
                                                notActivSearchOrdersIndex];
                                        return Visibility(
                                          visible: ((FFAppState()
                                                          .mainFilter
                                                          .minPrice <=
                                                      notActivSearchOrdersItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMinPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .maxPrice >=
                                                      notActivSearchOrdersItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMaxPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .categories
                                                          .contains(
                                                              notActivSearchOrdersItem
                                                                  .category) ==
                                                      true) ||
                                                  !(FFAppState()
                                                      .mainFilter
                                                      .categories
                                                      .isNotEmpty)) &&
                                              (functions.degreesToRadians(
                                                      FFAppState()
                                                          .mainFilter
                                                          .userPoint,
                                                      valueOrDefault<double>(
                                                        FFAppState()
                                                            .mainFilter
                                                            .locationRadius,
                                                        10.0,
                                                      ),
                                                      notActivSearchOrdersItem
                                                          .location)! ||
                                                  (FFAppState().mainFilter.userPoint ==
                                                      functions
                                                          .reternZeroLoc()) ||
                                                  (currentUserLocationValue ==
                                                      null) ||
                                                  (FFAppState()
                                                          .mainFilter
                                                          .locationRadius ==
                                                      0.0)) &&
                                              (notActivSearchOrdersItem
                                                      .whoCreate !=
                                                  currentUserReference),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  OrderDetailsWidget.routeName,
                                                  queryParameters: {
                                                    'orderDoc': serializeParam(
                                                      notActivSearchOrdersItem,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'orderDoc':
                                                        notActivSearchOrdersItem,
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.jobCardLiteModels1
                                                    .getModel(
                                                  notActivSearchOrdersItem
                                                      .reference.id,
                                                  notActivSearchOrdersIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: JobCardLiteWidget(
                                                  key: Key(
                                                    'Keyfxc_${notActivSearchOrdersItem.reference.id}',
                                                  ),
                                                  price:
                                                      notActivSearchOrdersItem
                                                          .price,
                                                  titleCategory:
                                                      functions.searchCatTitles(
                                                          FFAppState()
                                                              .saveCat
                                                              .toList(),
                                                          notActivSearchOrdersItem
                                                              .category!),
                                                  userData:
                                                      notActivSearchOrdersItem
                                                          .whoCreate!,
                                                  orderCity:
                                                      notActivSearchOrdersItem
                                                          .locationTitle,
                                                  jobTitle:
                                                      notActivSearchOrdersItem
                                                          .title,
                                                  orderDoc:
                                                      notActivSearchOrdersItem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              if (_model.searchActive)
                                Builder(
                                  builder: (context) {
                                    final activsearchOrders =
                                        _model.simpleSearchResults1.toList();
                                    if (activsearchOrders.isEmpty) {
                                      return EmtpySearchWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        24.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: activsearchOrders.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder:
                                          (context, activsearchOrdersIndex) {
                                        final activsearchOrdersItem =
                                            activsearchOrders[
                                                activsearchOrdersIndex];
                                        return Visibility(
                                          visible: ((FFAppState()
                                                          .mainFilter
                                                          .minPrice <=
                                                      activsearchOrdersItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMinPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .maxPrice >=
                                                      activsearchOrdersItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMaxPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .categories
                                                          .contains(
                                                              activsearchOrdersItem
                                                                  .category) ==
                                                      true) ||
                                                  !(FFAppState()
                                                      .mainFilter
                                                      .categories
                                                      .isNotEmpty)) &&
                                              (functions.degreesToRadians(
                                                      FFAppState()
                                                          .mainFilter
                                                          .userPoint,
                                                      valueOrDefault<double>(
                                                        FFAppState()
                                                            .mainFilter
                                                            .locationRadius,
                                                        10.0,
                                                      ),
                                                      activsearchOrdersItem
                                                          .location)! ||
                                                  (FFAppState().mainFilter.userPoint ==
                                                      functions
                                                          .reternZeroLoc()) ||
                                                  (currentUserLocationValue ==
                                                      null) ||
                                                  (FFAppState()
                                                          .mainFilter
                                                          .locationRadius ==
                                                      0.0)) &&
                                              (activsearchOrdersItem
                                                      .whoCreate !=
                                                  currentUserReference),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                OrderDetailsWidget.routeName,
                                                queryParameters: {
                                                  'orderDoc': serializeParam(
                                                    activsearchOrdersItem,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'orderDoc':
                                                      activsearchOrdersItem,
                                                },
                                              );
                                            },
                                            child: wrapWithModel(
                                              model: _model.jobCardLiteModels2
                                                  .getModel(
                                                activsearchOrdersItem
                                                    .reference.id,
                                                activsearchOrdersIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: JobCardLiteWidget(
                                                key: Key(
                                                  'Key0w6_${activsearchOrdersItem.reference.id}',
                                                ),
                                                price:
                                                    activsearchOrdersItem.price,
                                                titleCategory:
                                                    functions.searchCatTitles(
                                                        FFAppState()
                                                            .saveCat
                                                            .toList(),
                                                        activsearchOrdersItem
                                                            .category!),
                                                userData: activsearchOrdersItem
                                                    .whoCreate!,
                                                orderCity: activsearchOrdersItem
                                                    .locationTitle,
                                                jobTitle:
                                                    activsearchOrdersItem.title,
                                                orderDoc: activsearchOrdersItem,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                            ]
                                .divide(SizedBox(height: 18.0))
                                .addToStart(SizedBox(height: 60.0)),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 40.0),
                            child: wrapWithModel(
                              model: _model.mapButtonModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: MapButtonWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return StreamBuilder<List<ServicesRecord>>(
                stream: queryServicesRecord(
                  queryBuilder: (servicesRecord) => servicesRecord
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
                  List<ServicesRecord> containerServicesRecordList =
                      snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0,
                                          buttonSize: 40.0,
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            context.pushNamed(
                                                MainWidget.routeName);
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 200.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController2,
                                              focusNode:
                                                  _model.textFieldFocusNode2,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.textController2',
                                                Duration(milliseconds: 2000),
                                                () async {
                                                  safeSetState(() {
                                                    _model.simpleSearchResults2 =
                                                        TextSearch(
                                                      containerServicesRecordList
                                                          .map(
                                                            (record) =>
                                                                TextSearchItem
                                                                    .fromTerms(
                                                                        record,
                                                                        [
                                                                  record.title!
                                                                ]),
                                                          )
                                                          .toList(),
                                                    )
                                                            .search(_model
                                                                .textController2
                                                                .text)
                                                            .map(
                                                                (r) => r.object)
                                                            .toList();
                                                    ;
                                                  });
                                                  _model.searchResult = _model
                                                      .simpleSearchResults2
                                                      .length;
                                                  _model.searchActive = true;
                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: false,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                hintText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'scloio4t' /* Поиск по названию */,
                                                ),
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      color: Color(0xFFBDBDBD),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
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
                                                suffixIcon: _model
                                                        .textController2!
                                                        .text
                                                        .isNotEmpty
                                                    ? InkWell(
                                                        onTap: () async {
                                                          _model.textController2
                                                              ?.clear();
                                                          safeSetState(() {
                                                            _model.simpleSearchResults2 =
                                                                TextSearch(
                                                              containerServicesRecordList
                                                                  .map(
                                                                    (record) =>
                                                                        TextSearchItem.fromTerms(
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
                                                          _model.searchResult =
                                                              _model
                                                                  .simpleSearchResults2
                                                                  .length;
                                                          _model.searchActive =
                                                              true;
                                                          safeSetState(() {});
                                                          safeSetState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          size: 20.0,
                                                        ),
                                                      )
                                                    : null,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textController2Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0,
                                          buttonSize: 40.0,
                                          fillColor: Color(0xFFF5F5F5),
                                          icon: Icon(
                                            FFIcons.kfilter2,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            context.pushNamed(
                                                AllFilterWidget.routeName);
                                          },
                                        ),
                                      ].divide(SizedBox(width: 12.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (!_model.searchActive)
                                      Text(
                                        functions
                                            .filterServices(
                                                containerServicesRecordList
                                                    .toList(),
                                                FFAppState().mainFilter)
                                            .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                      ),
                                    if (_model.searchActive)
                                      Text(
                                        functions
                                            .filterServices(
                                                _model.simpleSearchResults2
                                                    .toList(),
                                                FFAppState().mainFilter)
                                            .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLargeFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .headlineLargeIsCustom,
                                            ),
                                      ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '6mvtzntw' /* найдено */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineLargeIsCustom,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                              if (_model.searchActive)
                                Builder(
                                  builder: (context) {
                                    final notActiveSearchServices =
                                        _model.simpleSearchResults2.toList();
                                    if (notActiveSearchServices.isEmpty) {
                                      return EmtpySearchWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        24.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notActiveSearchServices.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder: (context,
                                          notActiveSearchServicesIndex) {
                                        final notActiveSearchServicesItem =
                                            notActiveSearchServices[
                                                notActiveSearchServicesIndex];
                                        return Visibility(
                                          visible: ((FFAppState()
                                                          .mainFilter
                                                          .minPrice <=
                                                      notActiveSearchServicesItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMinPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .maxPrice >=
                                                      notActiveSearchServicesItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMaxPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .categories
                                                          .contains(
                                                              notActiveSearchServicesItem
                                                                  .category) ==
                                                      true) ||
                                                  !(FFAppState()
                                                      .mainFilter
                                                      .categories
                                                      .isNotEmpty)) &&
                                              (functions.degreesToRadians(
                                                      FFAppState()
                                                          .mainFilter
                                                          .userPoint,
                                                      valueOrDefault<double>(
                                                        FFAppState()
                                                            .mainFilter
                                                            .locationRadius,
                                                        10.0,
                                                      ),
                                                      notActiveSearchServicesItem
                                                          .location)! ||
                                                  (FFAppState().mainFilter.userPoint ==
                                                      functions
                                                          .reternZeroLoc()) ||
                                                  (currentUserLocationValue ==
                                                      null) ||
                                                  (FFAppState()
                                                          .mainFilter
                                                          .locationRadius ==
                                                      0.0)) &&
                                              (notActiveSearchServicesItem
                                                      .whoCreate !=
                                                  currentUserReference),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ServiceDetailsWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'serviceDoc':
                                                        serializeParam(
                                                      notActiveSearchServicesItem,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'serviceDoc':
                                                        notActiveSearchServicesItem,
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.jobCardLiteModels3
                                                    .getModel(
                                                  notActiveSearchServicesItem
                                                      .reference.id,
                                                  notActiveSearchServicesIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: JobCardLiteWidget(
                                                  key: Key(
                                                    'Keycy0_${notActiveSearchServicesItem.reference.id}',
                                                  ),
                                                  price:
                                                      notActiveSearchServicesItem
                                                          .price,
                                                  titleCategory:
                                                      functions.searchCatTitles(
                                                          FFAppState()
                                                              .saveCat
                                                              .toList(),
                                                          notActiveSearchServicesItem
                                                              .category!),
                                                  userData:
                                                      notActiveSearchServicesItem
                                                          .whoCreate!,
                                                  orderCity:
                                                      notActiveSearchServicesItem
                                                          .locationTitle,
                                                  jobTitle:
                                                      notActiveSearchServicesItem
                                                          .title,
                                                  servDoc:
                                                      notActiveSearchServicesItem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              if (!_model.searchActive)
                                Builder(
                                  builder: (context) {
                                    final activSearchServices =
                                        containerServicesRecordList.toList();
                                    if (activSearchServices.isEmpty) {
                                      return EmtpySearchWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        12.0,
                                        0,
                                        24.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: activSearchServices.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.0),
                                      itemBuilder:
                                          (context, activSearchServicesIndex) {
                                        final activSearchServicesItem =
                                            activSearchServices[
                                                activSearchServicesIndex];
                                        return Visibility(
                                          visible: ((FFAppState()
                                                          .mainFilter
                                                          .minPrice <=
                                                      activSearchServicesItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMinPrice()) &&
                                              ((FFAppState().mainFilter.maxPrice >=
                                                      activSearchServicesItem
                                                          .price) ||
                                                  !FFAppState()
                                                      .mainFilter
                                                      .hasMaxPrice()) &&
                                              ((FFAppState()
                                                          .mainFilter
                                                          .categories
                                                          .contains(
                                                              activSearchServicesItem
                                                                  .category) ==
                                                      true) ||
                                                  !(FFAppState()
                                                      .mainFilter
                                                      .categories
                                                      .isNotEmpty)) &&
                                              (functions.degreesToRadians(
                                                      FFAppState()
                                                          .mainFilter
                                                          .userPoint,
                                                      valueOrDefault<double>(
                                                        FFAppState()
                                                            .mainFilter
                                                            .locationRadius,
                                                        10.0,
                                                      ),
                                                      activSearchServicesItem
                                                          .location)! ||
                                                  (FFAppState().mainFilter.userPoint ==
                                                      functions
                                                          .reternZeroLoc()) ||
                                                  (currentUserLocationValue ==
                                                      null) ||
                                                  (FFAppState()
                                                          .mainFilter
                                                          .locationRadius ==
                                                      0.0)) &&
                                              (activSearchServicesItem
                                                      .whoCreate !=
                                                  currentUserReference),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ServiceDetailsWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'serviceDoc':
                                                        serializeParam(
                                                      activSearchServicesItem,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'serviceDoc':
                                                        activSearchServicesItem,
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.jobCardLiteModels4
                                                    .getModel(
                                                  activSearchServicesItem
                                                      .reference.id,
                                                  activSearchServicesIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: JobCardLiteWidget(
                                                  key: Key(
                                                    'Keyc0q_${activSearchServicesItem.reference.id}',
                                                  ),
                                                  price: activSearchServicesItem
                                                      .price,
                                                  titleCategory:
                                                      functions.searchCatTitles(
                                                          FFAppState()
                                                              .saveCat
                                                              .toList(),
                                                          activSearchServicesItem
                                                              .category!),
                                                  userData:
                                                      activSearchServicesItem
                                                          .whoCreate!,
                                                  orderCity:
                                                      activSearchServicesItem
                                                          .locationTitle,
                                                  jobTitle:
                                                      activSearchServicesItem
                                                          .title,
                                                  servDoc:
                                                      activSearchServicesItem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                            ].addToStart(SizedBox(height: 60.0)),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 40.0),
                            child: wrapWithModel(
                              model: _model.mapButtonModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: MapButtonWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
