import '/app_components/responce_card/responce_card_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'offer_to_service_model.dart';
export 'offer_to_service_model.dart';

class OfferToServiceWidget extends StatefulWidget {
  const OfferToServiceWidget({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
    this.parameter4,
  });

  final DocumentReference? parameter1;
  final bool? parameter2;
  final DocumentReference? parameter3;
  final DocumentReference? parameter4;

  @override
  State<OfferToServiceWidget> createState() => _OfferToServiceWidgetState();
}

class _OfferToServiceWidgetState extends State<OfferToServiceWidget> {
  late OfferToServiceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfferToServiceModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          widget!.parameter2! && (widget!.parameter3 == widget!.parameter4),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                'ivfdej38' /* Предложения по услуге */,
              ),
              style: FlutterFlowTheme.of(context).headlineLarge.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineLargeFamily,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineLargeIsCustom,
                  ),
            ),
            StreamBuilder<List<WorkRecord>>(
              stream: queryWorkRecord(
                queryBuilder: (workRecord) => workRecord.where(
                  'service',
                  isEqualTo: widget!.parameter1,
                ),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<WorkRecord> listViewWorkRecordList = snapshot.data!;

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewWorkRecordList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.0),
                  itemBuilder: (context, listViewIndex) {
                    final listViewWorkRecord =
                        listViewWorkRecordList[listViewIndex];
                    return wrapWithModel(
                      model: _model.responceCardModels.getModel(
                        listViewWorkRecord.reference.id,
                        listViewIndex,
                      ),
                      updateCallback: () => safeSetState(() {}),
                      child: ResponceCardWidget(
                        key: Key(
                          'Keycka_${listViewWorkRecord.reference.id}',
                        ),
                        workTitle: listViewWorkRecord.workTitle,
                        clientRef: listViewWorkRecord.client!,
                        workRef: listViewWorkRecord.reference,
                      ),
                    );
                  },
                );
              },
            ),
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
