import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_edit_employee_model.dart';
export 'admin_edit_employee_model.dart';

class AdminEditEmployeeWidget extends StatefulWidget {
  const AdminEditEmployeeWidget({
    super.key,
    required this.employeeRef,
  });

  final DocumentReference? employeeRef;

  @override
  State<AdminEditEmployeeWidget> createState() =>
      _AdminEditEmployeeWidgetState();
}

class _AdminEditEmployeeWidgetState extends State<AdminEditEmployeeWidget> {
  late AdminEditEmployeeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminEditEmployeeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.0,
      height: 380.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 16.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'jpyipacm' /* Роль сотрудника */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).displayMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayMediumIsCustom,
                              ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '23yv9g35' /* Роль сотрудника */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            FlutterFlowDropDown<UserStatus>(
              controller: _model.dropDownValueController1 ??=
                  FormFieldController<UserStatus>(
                _model.dropDownValue1 ??= UserStatus.emploee,
              ),
              options: List<UserStatus>.from(UserStatus.values
                  .where((e) => e != UserStatus.user)
                  .toList()),
              optionLabels: [
                FFLocalizations.of(context).getText(
                  'kerha7w0' /* Сотрудник */,
                ),
                FFLocalizations.of(context).getText(
                  'nmjk34d9' /* Администратор */,
                )
              ],
              onChanged: (val) =>
                  safeSetState(() => _model.dropDownValue1 = val),
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 56.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
              hintText: FFLocalizations.of(context).getText(
                'b227q761' /* Выберите роль */,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 2.0,
              borderColor: FlutterFlowTheme.of(context).primary,
              borderWidth: 0.0,
              borderRadius: 16.0,
              margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              hidesUnderline: true,
              isOverButton: false,
              isSearchable: false,
              isMultiSelect: false,
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '123u46l1' /* Задачи */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            FlutterFlowDropDown<Tasks>(
              controller: _model.dropDownValueController2 ??=
                  FormFieldController<Tasks>(
                _model.dropDownValue2 ??= Tasks.debate,
              ),
              options: List<Tasks>.from(
                  Tasks.values.where((e) => e != Tasks.none).toList()),
              optionLabels: [
                FFLocalizations.of(context).getText(
                  '9na6jsjy' /* Все */,
                ),
                FFLocalizations.of(context).getText(
                  'z2zho91k' /* Споры */,
                ),
                FFLocalizations.of(context).getText(
                  'gs5e7s9b' /* Категории */,
                )
              ],
              onChanged: (val) =>
                  safeSetState(() => _model.dropDownValue2 = val),
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 56.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
              hintText: FFLocalizations.of(context).getText(
                'r6d8ic5v' /* Выберите задачи */,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 2.0,
              borderColor: FlutterFlowTheme.of(context).primary,
              borderWidth: 0.0,
              borderRadius: 16.0,
              margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              hidesUnderline: true,
              isOverButton: false,
              isSearchable: false,
              isMultiSelect: false,
            ),
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: FFButtonWidget(
                onPressed: ((_model.dropDownValue1 == null) ||
                        (_model.dropDownValue2 == null))
                    ? null
                    : () async {
                        await widget!.employeeRef!.update(createUserRecordData(
                          essence: _model.dropDownValue1,
                          tasks: _model.dropDownValue2,
                        ));
                        Navigator.pop(context);
                      },
                text: FFLocalizations.of(context).getText(
                  'z3fdoyi3' /* Применить */,
                ),
                options: FFButtonOptions(
                  width: 160.0,
                  height: 58.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'involve',
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                    topLeft: Radius.circular(100.0),
                    topRight: Radius.circular(100.0),
                  ),
                  disabledColor: FlutterFlowTheme.of(context).secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
