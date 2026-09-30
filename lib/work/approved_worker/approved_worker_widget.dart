import '/app_components/avatar_mini/avatar_mini_widget.dart';
import '/app_components/info_fact_deal/info_fact_deal_widget.dart';
import '/app_components/info_safe_deal/info_safe_deal_widget.dart';
import '/app_components/titlewithback/titlewithback_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/modals_windows/get_job/modal_wind_not_money/modal_wind_not_money_widget.dart';
import '/work/modal_wind_approved_worker/modal_wind_approved_worker_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'approved_worker_model.dart';
export 'approved_worker_model.dart';

class ApprovedWorkerWidget extends StatefulWidget {
  const ApprovedWorkerWidget({
    super.key,
    required this.workDoc,
  });

  final WorkRecord? workDoc;

  static String routeName = 'approvedWorker';
  static String routePath = '/approvedWorker';

  @override
  State<ApprovedWorkerWidget> createState() => _ApprovedWorkerWidgetState();
}

class _ApprovedWorkerWidgetState extends State<ApprovedWorkerWidget> {
  late ApprovedWorkerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApprovedWorkerModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.queryComission = await queryGlobalDataRecordOnce(
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      FFAppState().commission = _model.queryComission!.comission;
      safeSetState(() {});
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<UserRecord>(
      stream: UserRecord.getDocument(widget!.workDoc!.worker!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final approvedWorkerUserRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          child: wrapWithModel(
                            model: _model.titlewithbackModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TitlewithbackWidget(
                              title: 'Подтвердить исполнителя',
                            ),
                          ),
                        ),
                        if (!(isWeb
                            ? MediaQuery.viewInsetsOf(context).bottom > 0
                            : _isKeyboardVisible))
                          Material(
                            color: Colors.transparent,
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    wrapWithModel(
                                      model: _model.avatarMiniModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: AvatarMiniWidget(
                                        sizeAva: 92,
                                        sizeLetter: 72,
                                        avaURL:
                                            approvedWorkerUserRecord.photoUrl,
                                        nameLetter: approvedWorkerUserRecord
                                            .displayName,
                                      ),
                                    ),
                                    Text(
                                      approvedWorkerUserRecord.displayName,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineLargeIsCustom,
                                          ),
                                    ),
                                    Text(
                                      approvedWorkerUserRecord.city,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star_half,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                        Text(
                                          formatNumber(
                                            approvedWorkerUserRecord.rating,
                                            formatType: FormatType.custom,
                                            format: '#.0',
                                            locale: '',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        Text(
                                          '(${formatNumber(
                                            approvedWorkerUserRecord
                                                .reviews.length,
                                            formatType: FormatType.decimal,
                                            decimalType:
                                                DecimalType.commaDecimal,
                                          )})',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              ReviewsWidget.routeName,
                                              queryParameters: {
                                                'whosReveiws': serializeParam(
                                                  approvedWorkerUserRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'fvy2b8it' /* Отзывы */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 12.0)),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Container(
                            width: 600.0,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'kktxshz0' /* Сопроводительное письмо */,
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController',
                                        Duration(milliseconds: 1000),
                                        () => safeSetState(() {}),
                                      ),
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          'gpxzd0hn' /* Введите */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              color: Color(0xFF9E9E9E),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelMediumIsCustom,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding: EdgeInsets.all(18.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                      maxLines: null,
                                      maxLength: 300,
                                      buildCounter: (context,
                                              {required currentLength,
                                              required isFocused,
                                              maxLength}) =>
                                          null,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '8xegal63' /* Способ оплаты */,
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                                if (FFAppConstants.withOutSBR)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          safeSetState(() => _model.safeDeal =
                                              !_model.safeDeal);
                                          _model.safeDeal = true;
                                        },
                                        value: _model.safeDeal,
                                        onIcon: Icon(
                                          Icons.circle_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        offIcon: Icon(
                                          Icons.circle_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Icon(
                                        FFIcons.kshieldDone,
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        size: 20.0,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '4qdtzv1b' /* Безопасная сделка */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
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
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: InfoSafeDealWidget(),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: Icon(
                                          Icons.info_outline_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ToggleIcon(
                                      onPressed: () async {
                                        safeSetState(() =>
                                            _model.safeDeal = !_model.safeDeal);
                                        _model.safeDeal = false;
                                      },
                                      value: !_model.safeDeal,
                                      onIcon: Icon(
                                        Icons.circle_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                      offIcon: Icon(
                                        Icons.circle_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                    ),
                                    Icon(
                                      FFIcons.kshieldFail,
                                      color: FlutterFlowTheme.of(context).error,
                                      size: 20.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'w3uhsnic' /* По факту выполнения заказа */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
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
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: InfoFactDealWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.safePop();
                            },
                            text: FFLocalizations.of(context).getText(
                              'y307lqmx' /* Отменить */,
                            ),
                            options: FFButtonOptions(
                              width: 360.0,
                              height: 58.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFE9F0FF),
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'involve',
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100.0),
                                bottomRight: Radius.circular(100.0),
                                topLeft: Radius.circular(100.0),
                                topRight: Radius.circular(100.0),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Builder(
                            builder: (context) => FFButtonWidget(
                              onPressed: ((_model.textController.text == null ||
                                          _model.textController.text == '') ||
                                      (_model.safeDeal == null))
                                  ? null
                                  : () async {
                                      if ((widget!.workDoc!.agreedPrice <
                                              (valueOrDefault(
                                                      currentUserDocument
                                                          ?.balance,
                                                      0) +
                                                  FFAppState().commission)) ||
                                          !FFAppConstants.withOutSBR) {
                                        if (_model.safeDeal) {
                                          // SafeDealTransaction

                                          var transactionsRecordReference =
                                              TransactionsRecord.collection
                                                  .doc();
                                          await transactionsRecordReference
                                              .set({
                                            ...createTransactionsRecordData(
                                              whosTransaction:
                                                  currentUserReference,
                                              income: false,
                                              amount:
                                                  widget!.workDoc?.agreedPrice,
                                              isPaid: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'timestamp': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                          _model.safeDealTransaction =
                                              TransactionsRecord
                                                  .getDocumentFromData({
                                            ...createTransactionsRecordData(
                                              whosTransaction:
                                                  currentUserReference,
                                              income: false,
                                              amount:
                                                  widget!.workDoc?.agreedPrice,
                                              isPaid: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'timestamp': DateTime.now(),
                                              },
                                            ),
                                          }, transactionsRecordReference);

                                          await currentUserReference!.update({
                                            ...mapToFirestore(
                                              {
                                                'transactions':
                                                    FieldValue.arrayUnion([
                                                  _model.safeDealTransaction
                                                      ?.reference
                                                ]),
                                                'balance': FieldValue.increment(
                                                    -(_model
                                                        .safeDealTransaction!
                                                        .amount)),
                                              },
                                            ),
                                          });
                                        }
                                        // respondAgreed

                                        var responceRecordReference =
                                            ResponceRecord.collection.doc();
                                        await responceRecordReference
                                            .set(createResponceRecordData(
                                          respSender: currentUserReference,
                                          respReciver: widget!.workDoc?.worker,
                                          newResponce: true,
                                          respLetter:
                                              _model.textController.text,
                                          respOffer: OfferType.agreed,
                                        ));
                                        _model.respondAgreed =
                                            ResponceRecord.getDocumentFromData(
                                                createResponceRecordData(
                                                  respSender:
                                                      currentUserReference,
                                                  respReciver:
                                                      widget!.workDoc?.worker,
                                                  newResponce: true,
                                                  respLetter: _model
                                                      .textController.text,
                                                  respOffer: OfferType.agreed,
                                                ),
                                                responceRecordReference);
                                        // agreedNotific

                                        var notificationsRecordReference =
                                            NotificationsRecord.collection
                                                .doc();
                                        await notificationsRecordReference.set({
                                          ...createNotificationsRecordData(
                                            whosNotification:
                                                widget!.workDoc?.worker,
                                            title:
                                                'Отклик подтвержден заказчиком',
                                            letter:
                                                'Вы утверждены на заказ ${widget!.workDoc?.workTitle}',
                                            unRead: true,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'timeStapm':
                                                  FieldValue.serverTimestamp(),
                                            },
                                          ),
                                        });
                                        _model.agreedNotific =
                                            NotificationsRecord
                                                .getDocumentFromData({
                                          ...createNotificationsRecordData(
                                            whosNotification:
                                                widget!.workDoc?.worker,
                                            title:
                                                'Отклик подтвержден заказчиком',
                                            letter:
                                                'Вы утверждены на заказ ${widget!.workDoc?.workTitle}',
                                            unRead: true,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'timeStapm': DateTime.now(),
                                            },
                                          ),
                                        }, notificationsRecordReference);
                                        // updateWork

                                        await widget!.workDoc!.reference
                                            .update({
                                          ...createWorkRecordData(
                                            safeDeal: _model.safeDeal,
                                            finishedTime:
                                                functions.countFinishedTime(
                                                    getCurrentTimestamp,
                                                    widget!.workDoc
                                                        ?.agreedDeadline),
                                            workStatus: ResponseType.confirmed,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'history_responces':
                                                  FieldValue.arrayUnion([
                                                _model.respondAgreed?.reference
                                              ]),
                                            },
                                          ),
                                        });

                                        await widget!.workDoc!.worker!.update({
                                          ...createUserRecordData(
                                            hasNewNot: true,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'myNotifications':
                                                  FieldValue.arrayUnion([
                                                _model.agreedNotific?.reference
                                              ]),
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child:
                                                    ModalWindApprovedWorkerWidget(
                                                  workRef: widget!
                                                      .workDoc!.reference,
                                                  workerName:
                                                      approvedWorkerUserRecord
                                                          .displayName,
                                                  workTitle: widget!
                                                      .workDoc?.workTitle,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child:
                                                    ModalWindNotMoneyWidget(),
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                              text: FFLocalizations.of(context).getText(
                                'f311rn02' /* Подтвердить */,
                              ),
                              options: FFButtonOptions(
                                width: 360.0,
                                height: 58.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
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
                                disabledColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 24.0)),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 40.0))
                    .addToStart(SizedBox(height: 40.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
