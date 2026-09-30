import '/app_components/main_search/main_search_widget.dart';
import '/app_components/search_job/search_job_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_lite/job_card_lite_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'map_filter_model.dart';
export 'map_filter_model.dart';

class MapFilterWidget extends StatefulWidget {
  const MapFilterWidget({super.key});

  static String routeName = 'MapFilter';
  static String routePath = '/mapFilter';

  @override
  State<MapFilterWidget> createState() => _MapFilterWidgetState();
}

class _MapFilterWidgetState extends State<MapFilterWidget> {
  late MapFilterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapFilterModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.userlocation = currentUserLocationValue;
      safeSetState(() {});
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
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
        body: Builder(
          builder: (context) {
            if (FFAppState().choosenRoleWorker) {
              return Stack(
                children: [
                  StreamBuilder<List<OrdersRecord>>(
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
                      List<OrdersRecord> googleMapOrdersRecordList =
                          snapshot.data!;

                      return FlutterFlowGoogleMap(
                        controller: _model.googleMapsController1,
                        onCameraIdle: (latLng) => safeSetState(
                            () => _model.googleMapsCenter1 = latLng),
                        initialLocation: _model.googleMapsCenter1 ??=
                            _model.userlocation!,
                        markers: googleMapOrdersRecordList
                            .where((e) =>
                                (FFAppState().mainFilter.minPrice <= e.price) &&
                                (FFAppState().mainFilter.maxPrice >= e.price) &&
                                ((FFAppState()
                                            .mainFilter
                                            .categories
                                            .contains(e.category) ==
                                        true) ||
                                    !(FFAppState()
                                        .mainFilter
                                        .categories
                                        .isNotEmpty)) &&
                                (functions.degreesToRadians(
                                        FFAppState().mainFilter.userPoint,
                                        FFAppState().mainFilter.locationRadius,
                                        e.location)! ||
                                    (FFAppState().mainFilter.userPoint ==
                                        functions.reternZeroLoc()) ||
                                    (currentUserLocationValue == null)))
                            .toList()
                            .map(
                              (marker) => FlutterFlowMarker(
                                marker.reference.path,
                                marker.location!,
                                () async {
                                  _model.choosenOrder = marker;
                                  safeSetState(() {});
                                },
                              ),
                            )
                            .toList(),
                        markerColor: GoogleMarkerColor.cyan,
                        mapType: MapType.normal,
                        style: GoogleMapStyle.standard,
                        initialZoom: 14.0,
                        allowInteraction: true,
                        allowZoom: true,
                        showZoomControls: false,
                        showLocation: true,
                        showCompass: false,
                        showMapToolbar: false,
                        showTraffic: false,
                        centerMapOnMarkerTap: true,
                      );
                    },
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: PointerInterceptor(
                      intercepting: isWeb,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primaryText,
                              FlutterFlowTheme.of(context).primaryBackground
                            ],
                            stops: [0.5, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  PointerInterceptor(
                    intercepting: isWeb,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: wrapWithModel(
                            model: _model.mainSearchModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: MainSearchWidget(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: PointerInterceptor(
                      intercepting: isWeb,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 100.0,
                                    buttonSize: 56.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    icon: Icon(
                                      Icons.navigation_sharp,
                                      color: FlutterFlowTheme.of(context).info,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      currentUserLocationValue =
                                          await getCurrentUserLocation(
                                              defaultLocation:
                                                  LatLng(0.0, 0.0));
                                      await requestPermission(
                                          locationPermission);
                                      _model.userlocation =
                                          currentUserLocationValue;
                                      safeSetState(() {});
                                      await _model.googleMapsController1.future
                                          .then(
                                        (c) => c.animateCamera(
                                          CameraUpdate.newLatLng(
                                              currentUserLocationValue!
                                                  .toGoogleMaps()),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.searchJobModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SearchJobWidget(),
                                ),
                              ),
                            ],
                          ),
                          if (_model.choosenOrder != null)
                            Padding(
                              padding: EdgeInsets.all(24.0),
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
                                        _model.choosenOrder,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'orderDoc': _model.choosenOrder,
                                    },
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.jobCardLiteModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: JobCardLiteWidget(
                                    price: _model.choosenOrder!.price,
                                    titleCategory: functions.searchCatTitles(
                                        FFAppState().saveCat.toList(),
                                        _model.choosenOrder!.category!),
                                    orderCity:
                                        _model.choosenOrder!.locationTitle,
                                    userData: _model.choosenOrder!.whoCreate!,
                                    jobTitle: _model.choosenOrder!.title,
                                    orderDoc: _model.choosenOrder,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  StreamBuilder<List<ServicesRecord>>(
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
                      List<ServicesRecord> googleMapServicesRecordList =
                          snapshot.data!;

                      return FlutterFlowGoogleMap(
                        controller: _model.googleMapsController2,
                        onCameraIdle: (latLng) => safeSetState(
                            () => _model.googleMapsCenter2 = latLng),
                        initialLocation: _model.googleMapsCenter2 ??=
                            _model.userlocation!,
                        markers: googleMapServicesRecordList
                            .where((e) =>
                                (FFAppState().mainFilter.minPrice <= e.price) &&
                                (FFAppState().mainFilter.maxPrice >= e.price) &&
                                ((FFAppState()
                                            .mainFilter
                                            .categories
                                            .contains(e.category) ==
                                        true) ||
                                    !(FFAppState()
                                        .mainFilter
                                        .categories
                                        .isNotEmpty)) &&
                                (functions.degreesToRadians(
                                        FFAppState().mainFilter.userPoint,
                                        FFAppState().mainFilter.locationRadius,
                                        e.location)! ||
                                    (FFAppState().mainFilter.userPoint ==
                                        functions.reternZeroLoc()) ||
                                    (currentUserLocationValue == null)))
                            .toList()
                            .map(
                              (marker) => FlutterFlowMarker(
                                marker.reference.path,
                                marker.location!,
                                () async {
                                  _model.choosenServ = marker;
                                  safeSetState(() {});
                                },
                              ),
                            )
                            .toList(),
                        markerColor: GoogleMarkerColor.cyan,
                        mapType: MapType.normal,
                        style: GoogleMapStyle.standard,
                        initialZoom: 14.0,
                        allowInteraction: true,
                        allowZoom: true,
                        showZoomControls: false,
                        showLocation: true,
                        showCompass: false,
                        showMapToolbar: false,
                        showTraffic: false,
                        centerMapOnMarkerTap: true,
                      );
                    },
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: PointerInterceptor(
                      intercepting: isWeb,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primaryText,
                              FlutterFlowTheme.of(context).primaryBackground
                            ],
                            stops: [0.5, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  PointerInterceptor(
                    intercepting: isWeb,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: wrapWithModel(
                            model: _model.mainSearchModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: MainSearchWidget(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: PointerInterceptor(
                      intercepting: isWeb,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 100.0,
                                    buttonSize: 56.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    icon: Icon(
                                      Icons.navigation_sharp,
                                      color: FlutterFlowTheme.of(context).info,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      currentUserLocationValue =
                                          await getCurrentUserLocation(
                                              defaultLocation:
                                                  LatLng(0.0, 0.0));
                                      await requestPermission(
                                          locationPermission);
                                      _model.userlocation =
                                          currentUserLocationValue;
                                      safeSetState(() {});
                                      await _model.googleMapsController2.future
                                          .then(
                                        (c) => c.animateCamera(
                                          CameraUpdate.newLatLng(
                                              currentUserLocationValue!
                                                  .toGoogleMaps()),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.searchJobModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SearchJobWidget(),
                                ),
                              ),
                            ],
                          ),
                          if (_model.choosenServ != null)
                            Padding(
                              padding: EdgeInsets.all(24.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    ServiceDetailsWidget.routeName,
                                    queryParameters: {
                                      'serviceDoc': serializeParam(
                                        _model.choosenServ,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'serviceDoc': _model.choosenServ,
                                    },
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.jobCardLiteModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: JobCardLiteWidget(
                                    price: _model.choosenServ!.price,
                                    titleCategory: functions.searchCatTitles(
                                        FFAppState().saveCat.toList(),
                                        _model.choosenServ!.category!),
                                    orderCity:
                                        _model.choosenServ!.locationTitle,
                                    userData: _model.choosenServ!.whoCreate!,
                                    jobTitle: _model.choosenServ!.title,
                                    servDoc: _model.choosenServ,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
