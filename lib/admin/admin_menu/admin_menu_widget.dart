import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_menu_model.dart';
export 'admin_menu_model.dart';

class AdminMenuWidget extends StatefulWidget {
  const AdminMenuWidget({
    super.key,
    required this.currentAdminPage,
  });

  final AdminMenu? currentAdminPage;

  @override
  State<AdminMenuWidget> createState() => _AdminMenuWidgetState();
}

class _AdminMenuWidgetState extends State<AdminMenuWidget> {
  late AdminMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminMenuModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 40.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Asset_3@4x-8.png',
                  width: 146.0,
                  height: 52.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '39uyb298' /* УПРАВЛЕНИЕ */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            FFButtonWidget(
              onPressed: (widget!.currentAdminPage == AdminMenu.profile)
                  ? null
                  : () async {
                      context.pushNamed(AdminMainProfileWidget.routeName);
                    },
              text: FFLocalizations.of(context).getText(
                '2e2hwbcy' /* Профиль */,
              ),
              icon: Icon(
                FFIcons.kprofile2,
                size: 15.0,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 2.8,
                height: 46.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                disabledColor: FlutterFlowTheme.of(context).accent4,
                disabledTextColor: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            FFButtonWidget(
              onPressed: (widget!.currentAdminPage == AdminMenu.emploees)
                  ? null
                  : () async {
                      context.pushNamed(AdminEmploeeWidget.routeName);
                    },
              text: FFLocalizations.of(context).getText(
                '7wawnand' /* Сотрудники */,
              ),
              icon: Icon(
                FFIcons.k2User,
                size: 15.0,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 2.8,
                height: 46.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                disabledColor: FlutterFlowTheme.of(context).accent4,
                disabledTextColor: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  're9yc9oc' /* КОНТЕНТ */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            FFButtonWidget(
              onPressed: (widget!.currentAdminPage == AdminMenu.category)
                  ? null
                  : () async {
                      context.pushNamed(AdminCategoryWidget.routeName);
                    },
              text: FFLocalizations.of(context).getText(
                'a8tvxx02' /* Категории */,
              ),
              icon: FaIcon(
                FontAwesomeIcons.borderAll,
                size: 15.0,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 2.8,
                height: 46.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                disabledColor: FlutterFlowTheme.of(context).accent4,
                disabledTextColor: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '3iz3kwk7' /* ПОДДЕРЖКА */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            ),
            FFButtonWidget(
              onPressed: (widget!.currentAdminPage == AdminMenu.users)
                  ? null
                  : () async {
                      context.pushNamed(AdminUsersWidget.routeName);
                    },
              text: FFLocalizations.of(context).getText(
                '9ckfpupn' /* Пользователи */,
              ),
              icon: Icon(
                Icons.people_alt_sharp,
                size: 15.0,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 2.8,
                height: 46.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                disabledColor: FlutterFlowTheme.of(context).accent4,
                disabledTextColor: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            FFButtonWidget(
              onPressed: (widget!.currentAdminPage == AdminMenu.chats)
                  ? null
                  : () async {
                      context.pushNamed(AdminChatsWidget.routeName);
                    },
              text: FFLocalizations.of(context).getText(
                'tbhyii0o' /* Чаты */,
              ),
              icon: Icon(
                FFIcons.kchat,
                size: 15.0,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 2.8,
                height: 46.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleSmallIsCustom,
                    ),
                elevation: 0.0,
                disabledColor: FlutterFlowTheme.of(context).accent4,
                disabledTextColor: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
