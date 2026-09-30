import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/balance/outcome_incorrect/outcome_incorrect_widget.dart';
import '/user/profile/balance/trans_error/trans_error_widget.dart';
import '/user/profile/balance/transaction_correct/transaction_correct_widget.dart';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'income_info_after_link_model.dart';
export 'income_info_after_link_model.dart';

class IncomeInfoAfterLinkWidget extends StatefulWidget {
  const IncomeInfoAfterLinkWidget({super.key});

  @override
  State<IncomeInfoAfterLinkWidget> createState() =>
      _IncomeInfoAfterLinkWidgetState();
}

class _IncomeInfoAfterLinkWidgetState extends State<IncomeInfoAfterLinkWidget>
    with TickerProviderStateMixin {
  late IncomeInfoAfterLinkModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IncomeInfoAfterLinkModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
      );
      FFAppState().updateCheckLastInvoiceStruct(
        (e) => e..checkCounter = 1,
      );
      safeSetState(() {});
      while (FFAppState().checkLastInvoice.checkCounter < 40) {
        _model.accessPAI = await BonumAuthCreateCall.call(
          tokenHdr: FFAppState().terminalId,
        );

        _model.apiChaeckPay2 = await BonumGetInvoiceStatusCall.call(
          invoiceId: FFAppState().checkLastInvoice.invoiceID,
          tokenType: BonumAuthCreateCall.tokenType(
            (_model.accessPAI?.jsonBody ?? ''),
          ),
          accessToken: BonumAuthCreateCall.accessToken(
            (_model.accessPAI?.jsonBody ?? ''),
          ),
          terminalId: FFAppState().terminalId,
        );

        if ((_model.apiChaeckPay2?.succeeded ?? true)) {
          if (BonumGetInvoiceStatusCall.paymentStatus(
                (_model.apiChaeckPay2?.jsonBody ?? ''),
              ) ==
              'PENDING') {
            await Future.delayed(
              Duration(
                milliseconds: 5000,
              ),
            );
            FFAppState().updateCheckLastInvoiceStruct(
              (e) => e
                ..incrementCheckCounter(1)
                ..currentStatusAPI = 'pendingProcess',
            );
            safeSetState(() {});
          } else {
            if (BonumGetInvoiceStatusCall.paymentStatus(
                  (_model.apiChaeckPay2?.jsonBody ?? ''),
                ) ==
                'PAID') {
              FFAppState().updateCheckLastInvoiceStruct(
                (e) => e
                  ..checkCounter = 40
                  ..checked = true
                  ..currentStatusAPI = 'PAID',
              );
              safeSetState(() {});
              _model.readTrans = await TransactionsRecord.getDocumentOnce(
                  FFAppState().checkLastInvoice.id!);

              await _model.readTrans!.reference
                  .update(createTransactionsRecordData(
                isPaid: true,
                status: 'PAID',
              ));

              await currentUserReference!.update({
                ...mapToFirestore(
                  {
                    'transactions':
                        FieldValue.arrayUnion([_model.readTrans?.reference]),
                    'balance': FieldValue.increment(_model.readTrans!.amount),
                  },
                ),
              });
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    elevation: 0,
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    alignment: AlignmentDirectional(0.0, 0.0)
                        .resolve(Directionality.of(context)),
                    child: TransactionCorrectWidget(),
                  );
                },
              );

              break;
            } else {
              if (BonumGetInvoiceStatusCall.paymentStatus(
                        (_model.apiChaeckPay2?.jsonBody ?? ''),
                      ) ==
                      null ||
                  BonumGetInvoiceStatusCall.paymentStatus(
                        (_model.apiChaeckPay2?.jsonBody ?? ''),
                      ) ==
                      '') {
                FFAppState().updateCheckLastInvoiceStruct(
                  (e) => e
                    ..checkCounter = 40
                    ..checked = true
                    ..id = null
                    ..currentStatusAPI = 'notPaidTRUE',
                );
                safeSetState(() {});
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      alignment: AlignmentDirectional(0.0, 0.0)
                          .resolve(Directionality.of(context)),
                      child: OutcomeIncorrectWidget(),
                    );
                  },
                );

                break;
              } else {
                FFAppState().updateCheckLastInvoiceStruct(
                  (e) => e
                    ..checkCounter = 40
                    ..checked = true
                    ..id = null
                    ..currentStatusAPI = 'notPaidFalse',
                );
                safeSetState(() {});
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      alignment: AlignmentDirectional(0.0, 0.0)
                          .resolve(Directionality.of(context)),
                      child: OutcomeIncorrectWidget(),
                    );
                  },
                );

                break;
              }
            }
          }
        } else {
          FFAppState().updateCheckLastInvoiceStruct(
            (e) => e
              ..checkCounter = 40
              ..checked = true
              ..currentStatusAPI = 'checkINVOICEfail',
          );
          safeSetState(() {});
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: TransErrorWidget(),
              );
            },
          );

          break;
        }
      }
      if (FFAppState().checkLastInvoice.checkCounter >= 40) {
        Navigator.pop(context);
        FFAppState().updateCheckLastInvoiceStruct(
          (e) => e..checked = true,
        );
        safeSetState(() {});
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: TransErrorWidget(),
            );
          },
        );
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.2,
            end: 1.0,
          ),
          FadeEffect(
            curve: Curves.easeOut,
            delay: 600.0.ms,
            duration: 600.0.ms,
            begin: 0.2,
            end: 1.0,
          ),
        ],
      ),
    });

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

    return Builder(
      builder: (context) => Container(
        width: 340.0,
        height: 340.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(44.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/income.png',
                  width: 180.0,
                  height: 180.0,
                  fit: BoxFit.contain,
                ),
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      '8pdt50lo' /* Попытка: */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).displayMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).displayMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .displayMediumIsCustom,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      FFAppState().checkLastInvoice.checkCounter.toString(),
                      '0',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).displayMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).displayMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .displayMediumIsCustom,
                        ),
                  ),
                ].divide(SizedBox(width: 4.0)),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'jm4d6ed2' /* Проверяем оплату */,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).displayMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).displayMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).displayMediumIsCustom,
                    ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
