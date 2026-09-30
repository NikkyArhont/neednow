import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import '/user/service/modal_service/modal_wind_create_service_succsess/modal_wind_create_service_succsess_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_service_widget.dart' show CreateServiceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CreateServiceModel extends FlutterFlowModel<CreateServiceWidget> {
  ///  Local state fields for this page.

  DocumentReference? choosenCat;

  List<FFUploadedFile> uploadedMedia = [];
  void addToUploadedMedia(FFUploadedFile item) => uploadedMedia.add(item);
  void removeFromUploadedMedia(FFUploadedFile item) =>
      uploadedMedia.remove(item);
  void removeAtIndexFromUploadedMedia(int index) =>
      uploadedMedia.removeAt(index);
  void insertAtIndexInUploadedMedia(int index, FFUploadedFile item) =>
      uploadedMedia.insert(index, item);
  void updateUploadedMediaAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      uploadedMedia[index] = updateFn(uploadedMedia[index]);

  List<SearchPlaceStruct> uploadedPlaces = [];
  void addToUploadedPlaces(SearchPlaceStruct item) => uploadedPlaces.add(item);
  void removeFromUploadedPlaces(SearchPlaceStruct item) =>
      uploadedPlaces.remove(item);
  void removeAtIndexFromUploadedPlaces(int index) =>
      uploadedPlaces.removeAt(index);
  void insertAtIndexInUploadedPlaces(int index, SearchPlaceStruct item) =>
      uploadedPlaces.insert(index, item);
  void updateUploadedPlacesAtIndex(
          int index, Function(SearchPlaceStruct) updateFn) =>
      uploadedPlaces[index] = updateFn(uploadedPlaces[index]);

  SearchPlaceStruct? choosenPlace;
  void updateChoosenPlaceStruct(Function(SearchPlaceStruct) updateFn) {
    updateFn(choosenPlace ??= SearchPlaceStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for SwitchIsRemote widget.
  bool? switchIsRemoteValue;
  // State field(s) for enterAddres widget.
  FocusNode? enterAddresFocusNode;
  TextEditingController? enterAddresTextController;
  String? Function(BuildContext, String?)? enterAddresTextControllerValidator;
  // Stores action output result for [Backend Call - API (getAdress)] action in enterAddres widget.
  ApiCallResponse? apiResultAddress;
  // Stores action output result for [Backend Call - API (getPlaceLatLng)] action in Button widget.
  ApiCallResponse? apiResultLatLonServ;
  // State field(s) for fieldTitle widget.
  FocusNode? fieldTitleFocusNode;
  TextEditingController? fieldTitleTextController;
  String? Function(BuildContext, String?)? fieldTitleTextControllerValidator;
  // State field(s) for fieldAmount widget.
  FocusNode? fieldAmountFocusNode;
  TextEditingController? fieldAmountTextController;
  String? Function(BuildContext, String?)? fieldAmountTextControllerValidator;
  // State field(s) for fieldDescription widget.
  FocusNode? fieldDescriptionFocusNode;
  TextEditingController? fieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      fieldDescriptionTextControllerValidator;
  bool isDataUploading_uploadDataNewServ = false;
  FFUploadedFile uploadedLocalFile_uploadDataNewServ =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_uploadDataCreateOrder = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataCreateOrder = [];
  List<String> uploadedFileUrls_uploadDataCreateOrder = [];

  @override
  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
  }

  @override
  void dispose() {
    backbuttonModel.dispose();
    enterAddresFocusNode?.dispose();
    enterAddresTextController?.dispose();

    fieldTitleFocusNode?.dispose();
    fieldTitleTextController?.dispose();

    fieldAmountFocusNode?.dispose();
    fieldAmountTextController?.dispose();

    fieldDescriptionFocusNode?.dispose();
    fieldDescriptionTextController?.dispose();
  }
}
