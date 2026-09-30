import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/modal_wind_sing_up/modal_wind_sing_up_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_job_button_model.dart';
export 'new_job_button_model.dart';

class NewJobButtonWidget extends StatefulWidget {
  const NewJobButtonWidget({super.key});

  @override
  State<NewJobButtonWidget> createState() => _NewJobButtonWidgetState();
}

class _NewJobButtonWidgetState extends State<NewJobButtonWidget> {
  late NewJobButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewJobButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.0),
        child: FlutterFlowIconButton(
          borderRadius: 100.0,
          buttonSize: 56.0,
          fillColor: FlutterFlowTheme.of(context).primary,
          icon: FaIcon(
            FontAwesomeIcons.plus,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
          onPressed: () async {
            if (loggedIn) {
              if (valueOrDefault<bool>(currentUserDocument?.isWorker, false)) {
                context.pushNamed(CreateServiceWidget.routeName);
              } else {
                context.pushNamed(CreateOrderWidget.routeName);
              }
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
    );
  }
}
