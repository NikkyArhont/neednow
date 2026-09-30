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
import 'enter_location_city_start_widget.dart'
    show EnterLocationCityStartWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EnterLocationCityStartModel
    extends FlutterFlowModel<EnterLocationCityStartWidget> {
  ///  Local state fields for this page.

  List<SearchPlaceStruct> searchList = [];
  void addToSearchList(SearchPlaceStruct item) => searchList.add(item);
  void removeFromSearchList(SearchPlaceStruct item) => searchList.remove(item);
  void removeAtIndexFromSearchList(int index) => searchList.removeAt(index);
  void insertAtIndexInSearchList(int index, SearchPlaceStruct item) =>
      searchList.insert(index, item);
  void updateSearchListAtIndex(
          int index, Function(SearchPlaceStruct) updateFn) =>
      searchList[index] = updateFn(searchList[index]);

  SearchPlaceStruct? coosenPlace;
  void updateCoosenPlaceStruct(Function(SearchPlaceStruct) updateFn) {
    updateFn(coosenPlace ??= SearchPlaceStruct());
  }

  int? searchCount;

  ///  State fields for stateful widgets in this page.

  // Model for titlewithback component.
  late TitlewithbackModel titlewithbackModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (getCity)] action in TextField widget.
  ApiCallResponse? apiResultCity;
  // Stores action output result for [Backend Call - API (getPlaceLatLng)] action in Button widget.
  ApiCallResponse? apiResultLatLon;

  @override
  void initState(BuildContext context) {
    titlewithbackModel = createModel(context, () => TitlewithbackModel());
  }

  @override
  void dispose() {
    titlewithbackModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
