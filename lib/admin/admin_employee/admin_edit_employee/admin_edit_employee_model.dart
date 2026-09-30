import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'admin_edit_employee_widget.dart' show AdminEditEmployeeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminEditEmployeeModel extends FlutterFlowModel<AdminEditEmployeeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  UserStatus? dropDownValue1;
  FormFieldController<UserStatus>? dropDownValueController1;
  // State field(s) for DropDown widget.
  Tasks? dropDownValue2;
  FormFieldController<Tasks>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
