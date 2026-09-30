import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'web_category_widget.dart' show WebCategoryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WebCategoryModel extends FlutterFlowModel<WebCategoryWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
