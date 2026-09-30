import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/user/profile/balance/income_info_after_link/income_info_after_link_widget.dart';
import '/user/profile/balance/trans_error/trans_error_widget.dart';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'income_info_model.dart';
export 'income_info_model.dart';

class IncomeInfoWidget extends StatefulWidget {
  const IncomeInfoWidget({
    super.key,
    required this.amount,
  });

  final int? amount;

  @override
  State<IncomeInfoWidget> createState() => _IncomeInfoWidgetState();
}

class _IncomeInfoWidgetState extends State<IncomeInfoWidget>
    with TickerProviderStateMixin {
  late IncomeInfoModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IncomeInfoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var transactionsRecordReference = TransactionsRecord.collection.doc();
      await transactionsRecordReference.set({
        ...createTransactionsRecordData(
          whosTransaction: currentUserReference,
          income: true,
          amount: widget!.amount,
          status: 'PENDING',
        ),
        ...mapToFirestore(
          {
            'timestamp': FieldValue.serverTimestamp(),
          },
        ),
      });
      _model.newTransaction = TransactionsRecord.getDocumentFromData({
        ...createTransactionsRecordData(
          whosTransaction: currentUserReference,
          income: true,
          amount: widget!.amount,
          status: 'PENDING',
        ),
        ...mapToFirestore(
          {
            'timestamp': DateTime.now(),
          },
        ),
      }, transactionsRecordReference);
      FFAppState().updateCheckLastInvoiceStruct(
        (e) => e..id = _model.newTransaction?.reference,
      );
      safeSetState(() {});
      _model.createAccessAPI = await BonumAuthCreateCall.call(
        tokenHdr: FFAppState().terminalId,
      );

      if ((_model.createAccessAPI?.succeeded ?? true)) {
        _model.apiRefresh = await BonumAuthRefreshCall.call(
          tokenType: BonumAuthCreateCall.tokenType(
            (_model.createAccessAPI?.jsonBody ?? ''),
          ),
          refreshToken: BonumAuthCreateCall.refreshToken(
            (_model.createAccessAPI?.jsonBody ?? ''),
          ),
        );

        FFAppState().updateCheckLastInvoiceStruct(
          (e) => e..currentStatusAPI = 'AccessDONE',
        );
        safeSetState(() {});
        if ((_model.apiRefresh?.succeeded ?? true)) {
          FFAppState().tokenType = BonumAuthRefreshCall.tokenType(
            (_model.apiRefresh?.jsonBody ?? ''),
          )!;
          FFAppState().refreshToken = BonumAuthRefreshCall.refreshToken(
            (_model.apiRefresh?.jsonBody ?? ''),
          )!;
          FFAppState().accessToken = BonumAuthCreateCall.accessToken(
            (_model.createAccessAPI?.jsonBody ?? ''),
          )!;
          FFAppState().updateCheckLastInvoiceStruct(
            (e) => e..currentStatusAPI = 'refreshDONE',
          );
          safeSetState(() {});
          _model.apiInvoice = await BonumCreateInvoiceCall.call(
            amount: widget!.amount,
            transactionId: _model.newTransaction?.reference.id,
            tokenType: FFAppState().tokenType,
            refreshToken: FFAppState().refreshToken,
            callback: 'http://neednow.mn/income',
          );

          if ((_model.apiInvoice?.succeeded ?? true)) {
            FFAppState().updateCheckLastInvoiceStruct(
              (e) => e
                ..checked = false
                ..id = _model.newTransaction?.reference
                ..invoiceID = BonumCreateInvoiceCall.invoceId(
                  (_model.apiInvoice?.jsonBody ?? ''),
                )
                ..currentStatusAPI = 'invoceCreate',
            );
            safeSetState(() {});

            await _model.newTransaction!.reference
                .update(createTransactionsRecordData(
              invoiceId: BonumCreateInvoiceCall.invoceId(
                (_model.apiInvoice?.jsonBody ?? ''),
              ),
            ));
            await launchURL(BonumCreateInvoiceCall.followUpLink(
              (_model.apiInvoice?.jsonBody ?? ''),
            )!);
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
                  child: IncomeInfoAfterLinkWidget(),
                );
              },
            );
          } else {
            FFAppState().updateCheckLastInvoiceStruct(
              (e) => e..currentStatusAPI = 'invoiceFAIL',
            );
            safeSetState(() {});
            Navigator.pop(context);
            await showDialog(
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
        } else {
          FFAppState().updateCheckLastInvoiceStruct(
            (e) => e..currentStatusAPI = 'refreshFAIL',
          );
          safeSetState(() {});
          Navigator.pop(context);
          await showDialog(
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
      } else {
        FFAppState().updateCheckLastInvoiceStruct(
          (e) => e..currentStatusAPI = 'accessFAIL',
        );
        safeSetState(() {});
        Navigator.pop(context);
        await showDialog(
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
              Text(
                FFLocalizations.of(context).getText(
                  '9qmlx4v1' /* Ожидается пополнение */,
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
