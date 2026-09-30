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
import 'main_widget.dart' show MainWidget;
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

class MainModel extends FlutterFlowModel<MainWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> choosenCat = [];
  void addToChoosenCat(DocumentReference item) => choosenCat.add(item);
  void removeFromChoosenCat(DocumentReference item) => choosenCat.remove(item);
  void removeAtIndexFromChoosenCat(int index) => choosenCat.removeAt(index);
  void insertAtIndexInChoosenCat(int index, DocumentReference item) =>
      choosenCat.insert(index, item);
  void updateChoosenCatAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      choosenCat[index] = updateFn(choosenCat[index]);

  bool searchActive = false;

  String? placeID;

  LatLng? searchLatLon;

  int? cardCountNotSearch;

  bool showMap = false;

  ///  State fields for stateful widgets in this page.

  // Model for webMenu component.
  late WebMenuModel webMenuModel;
  // Model for topAvatarNnotific component.
  late TopAvatarNnotificModel topAvatarNnotificModel;
  // Model for mainSearch component.
  late MainSearchModel mainSearchModel;
  // Model for myJobCard component.
  late MyJobCardModel myJobCardModel1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<OrdersRecord> simpleSearchResults1 = [];
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter1;
  final googleMapsController1 = Completer<GoogleMapController>();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter2;
  final googleMapsController2 = Completer<GoogleMapController>();
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels1;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels2;
  // Model for myJobCard component.
  late MyJobCardModel myJobCardModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  List<ServicesRecord> simpleSearchResults2 = [];
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter3;
  final googleMapsController3 = Completer<GoogleMapController>();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter4;
  final googleMapsController4 = Completer<GoogleMapController>();
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels3;
  // Models for jobCardLite dynamic component.
  late FlutterFlowDynamicModels<JobCardLiteModel> jobCardLiteModels4;
  // Model for mapButton component.
  late MapButtonModel mapButtonModel;
  // Model for menu component.
  late MenuModel menuModel;
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
  void initState(BuildContext context) {
    webMenuModel = createModel(context, () => WebMenuModel());
    topAvatarNnotificModel =
        createModel(context, () => TopAvatarNnotificModel());
    mainSearchModel = createModel(context, () => MainSearchModel());
    myJobCardModel1 = createModel(context, () => MyJobCardModel());
    jobCardLiteModels1 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    jobCardLiteModels2 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    myJobCardModel2 = createModel(context, () => MyJobCardModel());
    jobCardLiteModels3 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    jobCardLiteModels4 = FlutterFlowDynamicModels(() => JobCardLiteModel());
    mapButtonModel = createModel(context, () => MapButtonModel());
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    webMenuModel.dispose();
    topAvatarNnotificModel.dispose();
    mainSearchModel.dispose();
    myJobCardModel1.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    jobCardLiteModels1.dispose();
    jobCardLiteModels2.dispose();
    myJobCardModel2.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    jobCardLiteModels3.dispose();
    jobCardLiteModels4.dispose();
    mapButtonModel.dispose();
    menuModel.dispose();
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
