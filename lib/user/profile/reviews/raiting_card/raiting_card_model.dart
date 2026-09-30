import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'raiting_card_widget.dart' show RaitingCardWidget;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RaitingCardModel extends FlutterFlowModel<RaitingCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for avatarMini component.
  late AvatarMiniModel avatarMiniModel;

  @override
  void initState(BuildContext context) {
    avatarMiniModel = createModel(context, () => AvatarMiniModel());
  }

  @override
  void dispose() {
    avatarMiniModel.dispose();
  }
}
