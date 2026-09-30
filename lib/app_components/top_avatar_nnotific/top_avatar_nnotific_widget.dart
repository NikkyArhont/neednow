import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/onboarding/bot_shet_choose_role/bot_shet_choose_role_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'top_avatar_nnotific_model.dart';
export 'top_avatar_nnotific_model.dart';

class TopAvatarNnotificWidget extends StatefulWidget {
  const TopAvatarNnotificWidget({super.key});

  @override
  State<TopAvatarNnotificWidget> createState() =>
      _TopAvatarNnotificWidgetState();
}

class _TopAvatarNnotificWidgetState extends State<TopAvatarNnotificWidget> {
  late TopAvatarNnotificModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopAvatarNnotificModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              AuthUserStreamWidget(
                builder: (context) => wrapWithModel(
                  model: _model.avatarMiniModel,
                  updateCallback: () => safeSetState(() {}),
                  child: AvatarMiniWidget(
                    sizeAva: 48,
                    sizeLetter: 32,
                    avaURL: currentUserPhoto,
                    nameLetter: currentUserDisplayName,
                  ),
                ),
              ),
              if (!loggedIn)
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Asset_6@3x-8.png',
                      width: 22.0,
                      height: 22.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
            ],
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AuthUserStreamWidget(
                    builder: (context) => AutoSizeText(
                      loggedIn
                          ? currentUserDisplayName
                          : valueOrDefault<String>(
                              FFLocalizations.of(context).getVariableText(
                                ruText: 'Добро пожаловать!',
                                mnText: '',
                              ),
                              'Тавтай морил!',
                            ),
                      maxLines: 1,
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineLargeFamily,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineLargeIsCustom,
                              ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: BotShetChooseRoleWidget(),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AutoSizeText(
                        FFAppState().choosenRoleWorker
                            ? FFLocalizations.of(context).getVariableText(
                                ruText: 'Исполнитель',
                                mnText: 'Гүйцэтгэгч',
                              )
                            : FFLocalizations.of(context).getVariableText(
                                ruText: 'Заказчик',
                                mnText: 'Хэрэглэгч',
                              ),
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ].divide(SizedBox(height: 6.0)),
            ),
          ),
          Container(
            width: 48.0,
            height: 48.0,
            child: Stack(
              children: [
                FlutterFlowIconButton(
                  borderColor: Color(0xFFEEEEEE),
                  borderRadius: 100.0,
                  buttonSize: 48.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  icon: Icon(
                    FFIcons.knotification,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(MyNotificationWidget.routeName);
                  },
                ),
                if (valueOrDefault<bool>(currentUserDocument?.hasNewNot, false))
                  Align(
                    alignment: AlignmentDirectional(0.4, -0.4),
                    child: AuthUserStreamWidget(
                      builder: (context) => Icon(
                        FFIcons.ktimeCircle,
                        color: FlutterFlowTheme.of(context).error,
                        size: 6.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ].divide(SizedBox(width: 16.0)),
      ),
    );
  }
}
