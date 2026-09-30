import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seacrh_adress_model.dart';
export 'seacrh_adress_model.dart';

class SeacrhAdressWidget extends StatefulWidget {
  const SeacrhAdressWidget({super.key});

  @override
  State<SeacrhAdressWidget> createState() => _SeacrhAdressWidgetState();
}

class _SeacrhAdressWidgetState extends State<SeacrhAdressWidget> {
  late SeacrhAdressModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeacrhAdressModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
