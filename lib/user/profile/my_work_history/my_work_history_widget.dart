import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/empty_list_widget/emtpy_done_works/emtpy_done_works_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/jobs/job_card_history/job_card_history_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_work_history_model.dart';
export 'my_work_history_model.dart';

class MyWorkHistoryWidget extends StatefulWidget {
  const MyWorkHistoryWidget({super.key});

  static String routeName = 'myWorkHistory';
  static String routePath = '/myWorkHistory';

  @override
  State<MyWorkHistoryWidget> createState() => _MyWorkHistoryWidgetState();
}

class _MyWorkHistoryWidgetState extends State<MyWorkHistoryWidget> {
  late MyWorkHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyWorkHistoryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 12.0),
                  child: wrapWithModel(
                    model: _model.titlewithbackModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TitlewithbackWidget(
                      title: FFLocalizations.of(context).getText(
                        'no8lvjnl' /* История заказов */,
                      ),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  if (valueOrDefault<bool>(
                      currentUserDocument?.isWorker, false)) {
                    return StreamBuilder<List<WorkRecord>>(
                      stream: queryWorkRecord(
                        queryBuilder: (workRecord) => workRecord
                            .where(
                              'worker',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'work_status',
                              isEqualTo: ResponseType.done.serialize(),
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
                        List<WorkRecord> listViewWorkRecordList =
                            snapshot.data!;
                        if (listViewWorkRecordList.isEmpty) {
                          return Center(
                            child: EmtpyDoneWorksWidget(),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewWorkRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 24.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewWorkRecord =
                                listViewWorkRecordList[listViewIndex];
                            return Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      WorkPageWidget.routeName,
                                      queryParameters: {
                                        'workRef': serializeParam(
                                          listViewWorkRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: wrapWithModel(
                                    model:
                                        _model.jobCardHistoryModels1.getModel(
                                      listViewWorkRecord.reference.id,
                                      listViewIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: JobCardHistoryWidget(
                                      key: Key(
                                        'Key1gq_${listViewWorkRecord.reference.id}',
                                      ),
                                      price: listViewWorkRecord.agreedPrice,
                                      haveReview:
                                          listViewWorkRecord.reviewFromWorker,
                                      userData: listViewWorkRecord.client!,
                                      doneDate:
                                          listViewWorkRecord.finishedTime!,
                                      workRef: listViewWorkRecord.reference,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return StreamBuilder<List<WorkRecord>>(
                      stream: queryWorkRecord(
                        queryBuilder: (workRecord) => workRecord
                            .where(
                              'client',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'work_status',
                              isEqualTo: ResponseType.done.serialize(),
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
                        List<WorkRecord> listViewWorkRecordList =
                            snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewWorkRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 24.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewWorkRecord =
                                listViewWorkRecordList[listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    WorkPageWidget.routeName,
                                    queryParameters: {
                                      'workRef': serializeParam(
                                        listViewWorkRecord.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.jobCardHistoryModels2.getModel(
                                    listViewWorkRecord.reference.id,
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: JobCardHistoryWidget(
                                    key: Key(
                                      'Key4nf_${listViewWorkRecord.reference.id}',
                                    ),
                                    price: listViewWorkRecord.agreedPrice,
                                    haveReview:
                                        listViewWorkRecord.reviewFromClient,
                                    userData: listViewWorkRecord.client!,
                                    doneDate: listViewWorkRecord.finishedTime!,
                                    workRef: listViewWorkRecord.reference,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
