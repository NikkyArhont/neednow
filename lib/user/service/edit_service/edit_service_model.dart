import '/app_components/backbutton/backbutton_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/modals_windows/search_error/search_error_widget.dart';
import '/user/service/modal_service/delete_service/delete_service_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'edit_service_widget.dart' show EditServiceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditServiceModel extends FlutterFlowModel<EditServiceWidget> {
  ///  Local state fields for this page.

  String? searchTitle;

  String? searchPlaceId;

  DocumentReference? choosenCat;

  List<String> lastPhotoG = [];
  void addToLastPhotoG(String item) => lastPhotoG.add(item);
  void removeFromLastPhotoG(String item) => lastPhotoG.remove(item);
  void removeAtIndexFromLastPhotoG(int index) => lastPhotoG.removeAt(index);
  void insertAtIndexInLastPhotoG(int index, String item) =>
      lastPhotoG.insert(index, item);
  void updateLastPhotoGAtIndex(int index, Function(String) updateFn) =>
      lastPhotoG[index] = updateFn(lastPhotoG[index]);

  ///  State fields for stateful widgets in this page.

  // Model for backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for fieldAddress widget.
  final fieldAddressKey = GlobalKey();
  FocusNode? fieldAddressFocusNode;
  TextEditingController? fieldAddressTextController;
  String? fieldAddressSelectedOption;
  String? Function(BuildContext, String?)? fieldAddressTextControllerValidator;
  // Stores action output result for [Backend Call - API (getAdress)] action in fieldAddress widget.
  ApiCallResponse? apiResult9tu;
  // State field(s) for SwitchIsRemote widget.
  bool? switchIsRemoteValue;
  // State field(s) for fieldTitle widget.
  FocusNode? fieldTitleFocusNode;
  TextEditingController? fieldTitleTextController;
  String? Function(BuildContext, String?)? fieldTitleTextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // State field(s) for fieldAmount widget.
  FocusNode? fieldAmountFocusNode;
  TextEditingController? fieldAmountTextController;
  String? Function(BuildContext, String?)? fieldAmountTextControllerValidator;
  // State field(s) for fieldDescription widget.
  FocusNode? fieldDescriptionFocusNode;
  TextEditingController? fieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      fieldDescriptionTextControllerValidator;
  bool isDataUploading_uploadDataEditJob = false;
  FFUploadedFile uploadedLocalFile_uploadDataEditJob =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataEditJob = '';

  // Stores action output result for [Backend Call - API (getPlaceLatLng)] action in Button widget.
  ApiCallResponse? apiResultne5;

  @override
  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
  }

  @override
  void dispose() {
    backbuttonModel.dispose();
    fieldAddressFocusNode?.dispose();

    fieldTitleFocusNode?.dispose();
    fieldTitleTextController?.dispose();

    expandableExpandableController.dispose();
    fieldAmountFocusNode?.dispose();
    fieldAmountTextController?.dispose();

    fieldDescriptionFocusNode?.dispose();
    fieldDescriptionTextController?.dispose();
  }
}
