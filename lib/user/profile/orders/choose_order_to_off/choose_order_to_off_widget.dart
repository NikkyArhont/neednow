import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/user_card_mini/user_card_mini_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choose_order_to_off_model.dart';
export 'choose_order_to_off_model.dart';

class ChooseOrderToOffWidget extends StatefulWidget {
  const ChooseOrderToOffWidget({
    super.key,
    required this.prefworker,
    required this.prefServ,
  });

  final DocumentReference? prefworker;
  final DocumentReference? prefServ;

  static String routeName = 'chooseOrderToOff';
  static String routePath = '/chooseOrderToOff';

  @override
  State<ChooseOrderToOffWidget> createState() => _ChooseOrderToOffWidgetState();
}

class _ChooseOrderToOffWidgetState extends State<ChooseOrderToOffWidget> {
  late ChooseOrderToOffModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseOrderToOffModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loadOrder = await queryOrdersRecordOnce(
        queryBuilder: (ordersRecord) => ordersRecord.where(
          'who_create',
          isEqualTo: currentUserReference,
        ),
      );
      _model.choosenOrder = _model.loadOrder?.firstOrNull;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                child: wrapWithModel(
                  model: _model.titlewithbackModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TitlewithbackWidget(
                    title: 'Выбрать заказ',
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final chooseOrderToOffVar =
                            _model.loadOrder?.toList() ?? [];

                        return ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            60.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: chooseOrderToOffVar.length,
                          separatorBuilder: (_, __) => SizedBox(height: 14.0),
                          itemBuilder: (context, chooseOrderToOffVarIndex) {
                            final chooseOrderToOffVarItem =
                                chooseOrderToOffVar[chooseOrderToOffVarIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.choosenOrder = chooseOrderToOffVarItem;
                                safeSetState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_model.choosenOrder?.reference !=
                                      chooseOrderToOffVarItem.reference)
                                    Icon(
                                      Icons.circle_outlined,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  if (_model.choosenOrder?.reference ==
                                      chooseOrderToOffVarItem.reference)
                                    FaIcon(
                                      FontAwesomeIcons.dotCircle,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.choosenOrder =
                                          chooseOrderToOffVarItem;
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: 840.0,
                                      constraints: BoxConstraints(
                                        minWidth: 240.0,
                                        maxWidth: 840.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 12.0, 0.0),
                                              child: StreamBuilder<UserRecord>(
                                                stream: UserRecord.getDocument(
                                                    chooseOrderToOffVarItem
                                                        .whoCreate!),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  final userCardMiniUserRecord =
                                                      snapshot.data!;

                                                  return UserCardMiniWidget(
                                                    key: Key(
                                                        'Keylqf_${chooseOrderToOffVarIndex}_of_${chooseOrderToOffVar.length}'),
                                                    titleServOrder:
                                                        chooseOrderToOffVarItem
                                                            .title,
                                                    avaURL:
                                                        userCardMiniUserRecord
                                                            .photoUrl,
                                                    lastAchiv:
                                                        userCardMiniUserRecord
                                                            .lastAchivment,
                                                    raiting:
                                                        userCardMiniUserRecord
                                                            .rating,
                                                    userName:
                                                        userCardMiniUserRecord
                                                            .displayName,
                                                  );
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Wrap(
                                                        spacing: 2.0,
                                                        runSpacing: 2.0,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        direction:
                                                            Axis.horizontal,
                                                        runAlignment:
                                                            WrapAlignment.start,
                                                        verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Text(
                                                            '${chooseOrderToOffVarItem.locationTitle}  -  ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                          Text(
                                                            functions.searchCatTitles(
                                                                FFAppState()
                                                                    .saveCat
                                                                    .toList(),
                                                                chooseOrderToOffVarItem
                                                                    .category!),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF757575),
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    '${chooseOrderToOffVarItem.price.toString()} ${FFAppConstants.currency}',
                                                    maxLines: 1,
                                                    minFontSize: 10.0,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMediumIsCustom,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 16.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 12.0)),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: FFButtonWidget(
                  onPressed: (_model.choosenOrder == null)
                      ? null
                      : () async {
                          context.pushNamed(
                            OfferOrderWidget.routeName,
                            queryParameters: {
                              'passOrder': serializeParam(
                                _model.choosenOrder,
                                ParamType.Document,
                              ),
                              'preferWorker': serializeParam(
                                widget!.prefworker,
                                ParamType.DocumentReference,
                              ),
                              'preferService': serializeParam(
                                widget!.prefServ,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'passOrder': _model.choosenOrder,
                            },
                          );
                        },
                  text: FFLocalizations.of(context).getText(
                    'da1js303' /* Применить */,
                  ),
                  options: FFButtonOptions(
                    width: 360.0,
                    height: 58.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
