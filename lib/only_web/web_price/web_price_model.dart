import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'web_price_widget.dart' show WebPriceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WebPriceModel extends FlutterFlowModel<WebPriceWidget> {
  ///  Local state fields for this component.

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

  ///  State fields for stateful widgets in this component.

  // State field(s) for minPrice widget.
  FocusNode? minPriceFocusNode;
  TextEditingController? minPriceTextController;
  String? Function(BuildContext, String?)? minPriceTextControllerValidator;
  // State field(s) for maxPrice widget.
  FocusNode? maxPriceFocusNode;
  TextEditingController? maxPriceTextController;
  String? Function(BuildContext, String?)? maxPriceTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    minPriceFocusNode?.dispose();
    minPriceTextController?.dispose();

    maxPriceFocusNode?.dispose();
    maxPriceTextController?.dispose();
  }
}
