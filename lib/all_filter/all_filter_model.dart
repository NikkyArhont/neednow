import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'all_filter_widget.dart' show AllFilterWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllFilterModel extends FlutterFlowModel<AllFilterWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> choosenCats = [];
  void addToChoosenCats(DocumentReference item) => choosenCats.add(item);
  void removeFromChoosenCats(DocumentReference item) =>
      choosenCats.remove(item);
  void removeAtIndexFromChoosenCats(int index) => choosenCats.removeAt(index);
  void insertAtIndexInChoosenCats(int index, DocumentReference item) =>
      choosenCats.insert(index, item);
  void updateChoosenCatsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      choosenCats[index] = updateFn(choosenCats[index]);

  LatLng? searchLatLng;

  String? placeID;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for location widget.
  final locationKey = GlobalKey();
  FocusNode? locationFocusNode;
  TextEditingController? locationTextController;
  String? locationSelectedOption;
  String? Function(BuildContext, String?)? locationTextControllerValidator;
  // Stores action output result for [Backend Call - API (getCity)] action in location widget.
  ApiCallResponse? apiResultFilterCity;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for minPrice widget.
  FocusNode? minPriceFocusNode;
  TextEditingController? minPriceTextController;
  String? Function(BuildContext, String?)? minPriceTextControllerValidator;
  // State field(s) for maxPrice widget.
  FocusNode? maxPriceFocusNode;
  TextEditingController? maxPriceTextController;
  String? Function(BuildContext, String?)? maxPriceTextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // Stores action output result for [Backend Call - API (getPlaceLatLng)] action in Button widget.
  ApiCallResponse? apiResultPlaceLatLon;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController1.dispose();
    locationFocusNode?.dispose();

    expandableExpandableController2.dispose();
    minPriceFocusNode?.dispose();
    minPriceTextController?.dispose();

    maxPriceFocusNode?.dispose();
    maxPriceTextController?.dispose();

    expandableExpandableController3.dispose();
  }
}
