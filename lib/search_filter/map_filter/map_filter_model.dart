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
import 'map_filter_widget.dart' show MapFilterWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class MapFilterModel extends FlutterFlowModel<MapFilterWidget> {
  ///  Local state fields for this page.

  ServicesRecord? choosenServ;

  OrdersRecord? choosenOrder;

  LatLng? userlocation;

  List<OrdersRecord> filterOrders = [];
  void addToFilterOrders(OrdersRecord item) => filterOrders.add(item);
  void removeFromFilterOrders(OrdersRecord item) => filterOrders.remove(item);
  void removeAtIndexFromFilterOrders(int index) => filterOrders.removeAt(index);
  void insertAtIndexInFilterOrders(int index, OrdersRecord item) =>
      filterOrders.insert(index, item);
  void updateFilterOrdersAtIndex(int index, Function(OrdersRecord) updateFn) =>
      filterOrders[index] = updateFn(filterOrders[index]);

  List<ServicesRecord> filterServices = [];
  void addToFilterServices(ServicesRecord item) => filterServices.add(item);
  void removeFromFilterServices(ServicesRecord item) =>
      filterServices.remove(item);
  void removeAtIndexFromFilterServices(int index) =>
      filterServices.removeAt(index);
  void insertAtIndexInFilterServices(int index, ServicesRecord item) =>
      filterServices.insert(index, item);
  void updateFilterServicesAtIndex(
          int index, Function(ServicesRecord) updateFn) =>
      filterServices[index] = updateFn(filterServices[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter1;
  final googleMapsController1 = Completer<GoogleMapController>();
  // Model for mainSearch component.
  late MainSearchModel mainSearchModel1;
  // Model for searchJob component.
  late SearchJobModel searchJobModel1;
  // Model for jobCardLite component.
  late JobCardLiteModel jobCardLiteModel1;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter2;
  final googleMapsController2 = Completer<GoogleMapController>();
  // Model for mainSearch component.
  late MainSearchModel mainSearchModel2;
  // Model for searchJob component.
  late SearchJobModel searchJobModel2;
  // Model for jobCardLite component.
  late JobCardLiteModel jobCardLiteModel2;

  @override
  void initState(BuildContext context) {
    mainSearchModel1 = createModel(context, () => MainSearchModel());
    searchJobModel1 = createModel(context, () => SearchJobModel());
    jobCardLiteModel1 = createModel(context, () => JobCardLiteModel());
    mainSearchModel2 = createModel(context, () => MainSearchModel());
    searchJobModel2 = createModel(context, () => SearchJobModel());
    jobCardLiteModel2 = createModel(context, () => JobCardLiteModel());
  }

  @override
  void dispose() {
    mainSearchModel1.dispose();
    searchJobModel1.dispose();
    jobCardLiteModel1.dispose();
    mainSearchModel2.dispose();
    searchJobModel2.dispose();
    jobCardLiteModel2.dispose();
  }
}
