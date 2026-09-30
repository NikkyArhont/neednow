import '/auth/base_auth_user_provider.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/modal_wind_sing_up/modal_wind_sing_up_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_model.dart';
export 'menu_model.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.currentPage,
  });

  final CurrentPage? currentPage;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late MenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 4.0,
        height: 90.0,
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  disabledIconColor: FlutterFlowTheme.of(context).primary,
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xFF9E9E9E),
                    size: 24.0,
                  ),
                  onPressed: (widget!.currentPage == CurrentPage.main)
                      ? null
                      : () async {
                          context.pushNamed(MainWidget.routeName);
                        },
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '1zpk11ge' /* Главная */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: widget!.currentPage == CurrentPage.main
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).accent1,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    disabledIconColor: FlutterFlowTheme.of(context).primary,
                    icon: Icon(
                      FFIcons.kwork,
                      color: Color(0xFF9E9E9E),
                      size: 24.0,
                    ),
                    onPressed: (widget!.currentPage == CurrentPage.orders)
                        ? null
                        : () async {
                            if (loggedIn) {
                              context.pushNamed(JobsWidget.routeName);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: ModalWindSingUpWidget(),
                                  );
                                },
                              );
                            }
                          },
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '2t8cftnb' /* Заказы */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: widget!.currentPage == CurrentPage.orders
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).accent1,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    disabledIconColor: FlutterFlowTheme.of(context).primary,
                    icon: Icon(
                      FFIcons.kchat,
                      color: Color(0xFF9E9E9E),
                      size: 24.0,
                    ),
                    onPressed: (widget!.currentPage == CurrentPage.chats)
                        ? null
                        : () async {
                            if (loggedIn) {
                              context.pushNamed(ChatListWidget.routeName);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: ModalWindSingUpWidget(),
                                  );
                                },
                              );
                            }
                          },
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'zwrrbbrm' /* Чаты */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: widget!.currentPage == CurrentPage.chats
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).accent1,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    disabledIconColor: FlutterFlowTheme.of(context).primary,
                    icon: Icon(
                      Icons.person_outline,
                      color: Color(0xFF9E9E9E),
                      size: 24.0,
                    ),
                    onPressed: (widget!.currentPage == CurrentPage.profile)
                        ? null
                        : () async {
                            if (loggedIn) {
                              context.pushNamed(MyProfileWidget.routeName);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: ModalWindSingUpWidget(),
                                  );
                                },
                              );
                            }
                          },
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '17xi299h' /* Профиль */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: widget!.currentPage == CurrentPage.profile
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).accent1,
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
