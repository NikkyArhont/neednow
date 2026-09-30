import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).primary,
          child: Center(
            child: Image.asset(
              'assets/images/Asset_2@4x-8.png',
              width: 200.0,
              fit: BoxFit.contain,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'startpage': ParameterData.none(),
  'onboarding': ParameterData.none(),
  'enterPhone': ParameterData.none(),
  'smsverification': (data) async => ParameterData(
        allParams: {
          'phone': getParameter<String>(data, 'phone'),
        },
      ),
  'enterEditProfile': (data) async => ParameterData(
        allParams: {
          'name': getParameter<String>(data, 'name'),
        },
      ),
  'main': ParameterData.none(),
  'myJobs': ParameterData.none(),
  'Jobs': ParameterData.none(),
  'myNotification': ParameterData.none(),
  'MapFilter': ParameterData.none(),
  'SearchResult': ParameterData.none(),
  'allFilter': ParameterData.none(),
  'getOrder': (data) async => ParameterData(
        allParams: {
          'orderRef': await getDocumentParameter<OrdersRecord>(
              data, 'orderRef', OrdersRecord.fromSnapshot),
          'byOffer': await getDocumentParameter<WorkRecord>(
              data, 'byOffer', WorkRecord.fromSnapshot),
        },
      ),
  'createServiceStart': ParameterData.none(),
  'createService': ParameterData.none(),
  'workerKYC': ParameterData.none(),
  'workerKYCedit': ParameterData.none(),
  'Reviews': (data) async => ParameterData(
        allParams: {
          'whosReveiws': getParameter<DocumentReference>(data, 'whosReveiws'),
        },
      ),
  'myProfile': ParameterData.none(),
  'EditProfile': ParameterData.none(),
  'myBalance': ParameterData.none(),
  'Income': ParameterData.none(),
  'Outcome': ParameterData.none(),
  'chatList': ParameterData.none(),
  'chatWindow': (data) async => ParameterData(
        allParams: {
          'chatDoc': await getDocumentParameter<ChatsRecord>(
              data, 'chatDoc', ChatsRecord.fromSnapshot),
        },
      ),
  'adminPageLogin': ParameterData.none(),
  'ServiceDetails': (data) async => ParameterData(
        allParams: {
          'serviceDoc': await getDocumentParameter<ServicesRecord>(
              data, 'serviceDoc', ServicesRecord.fromSnapshot),
        },
      ),
  'workPage': (data) async => ParameterData(
        allParams: {
          'workRef': getParameter<DocumentReference>(data, 'workRef'),
        },
      ),
  'enterLocationCity': (data) async => ParameterData(
        allParams: {
          'oldCity': getParameter<String>(data, 'oldCity'),
        },
      ),
  'myWorkHistory': ParameterData.none(),
  'takeReview': (data) async => ParameterData(
        allParams: {
          'reviewReciver':
              getParameter<DocumentReference>(data, 'reviewReciver'),
          'workReview': getParameter<DocumentReference>(data, 'workReview'),
        },
      ),
  'enterLocationAdress': (data) async => ParameterData(
        allParams: {
          'oldAddress': getParameter<String>(data, 'oldAddress'),
        },
      ),
  'editService': (data) async => ParameterData(
        allParams: {
          'serviceDocEDit': await getDocumentParameter<ServicesRecord>(
              data, 'serviceDocEDit', ServicesRecord.fromSnapshot),
        },
      ),
  'approvedWorker': (data) async => ParameterData(
        allParams: {
          'workDoc': await getDocumentParameter<WorkRecord>(
              data, 'workDoc', WorkRecord.fromSnapshot),
        },
      ),
  'orderDetails': (data) async => ParameterData(
        allParams: {
          'orderDoc': await getDocumentParameter<OrdersRecord>(
              data, 'orderDoc', OrdersRecord.fromSnapshot),
          'offerdWork': getParameter<bool>(data, 'offerdWork'),
        },
      ),
  'editOrder': (data) async => ParameterData(
        allParams: {
          'orderDocEDit': await getDocumentParameter<OrdersRecord>(
              data, 'orderDocEDit', OrdersRecord.fromSnapshot),
        },
      ),
  'createOrder': ParameterData.none(),
  'offerOrder': (data) async => ParameterData(
        allParams: {
          'passOrder': await getDocumentParameter<OrdersRecord>(
              data, 'passOrder', OrdersRecord.fromSnapshot),
          'preferWorker': getParameter<DocumentReference>(data, 'preferWorker'),
          'preferService':
              getParameter<DocumentReference>(data, 'preferService'),
        },
      ),
  'chooseOrderToOff': (data) async => ParameterData(
        allParams: {
          'prefworker': getParameter<DocumentReference>(data, 'prefworker'),
          'prefServ': getParameter<DocumentReference>(data, 'prefServ'),
        },
      ),
  'reviewWithJobs': (data) async => ParameterData(
        allParams: {
          'whosReview': await getDocumentParameter<UserRecord>(
              data, 'whosReview', UserRecord.fromSnapshot),
        },
      ),
  'deniedWorker': (data) async => ParameterData(
        allParams: {
          'workDoc': await getDocumentParameter<WorkRecord>(
              data, 'workDoc', WorkRecord.fromSnapshot),
        },
      ),
  'enterLocationCityStart': (data) async => ParameterData(
        allParams: {
          'oldCity': getParameter<String>(data, 'oldCity'),
          'name': getParameter<String>(data, 'name'),
        },
      ),
  'adminMainProfile': ParameterData.none(),
  'adminPageRegistration': ParameterData.none(),
  'adminEmploee': ParameterData.none(),
  'adminCategory': ParameterData.none(),
  'adminUsers': ParameterData.none(),
  'adminUserCard': (data) async => ParameterData(
        allParams: {
          'userCard': await getDocumentParameter<UserRecord>(
              data, 'userCard', UserRecord.fromSnapshot),
        },
      ),
  'adminChats': ParameterData.none(),
  'adminWorkCard': (data) async => ParameterData(
        allParams: {
          'workCard': await getDocumentParameter<WorkRecord>(
              data, 'workCard', WorkRecord.fromSnapshot),
        },
      ),
  'createDebate': (data) async => ParameterData(
        allParams: {
          'workDoc': await getDocumentParameter<WorkRecord>(
              data, 'workDoc', WorkRecord.fromSnapshot),
        },
      ),
  'webChooseRole': ParameterData.none(),
  'webOrderDetails': (data) async => ParameterData(
        allParams: {
          'orderDoc': await getDocumentParameter<OrdersRecord>(
              data, 'orderDoc', OrdersRecord.fromSnapshot),
          'offerdWork': getParameter<bool>(data, 'offerdWork'),
        },
      ),
  'webServiceDetails': (data) async => ParameterData(
        allParams: {
          'serviceDoc': await getDocumentParameter<ServicesRecord>(
              data, 'serviceDoc', ServicesRecord.fromSnapshot),
        },
      ),
  'webChats': (data) async => ParameterData(
        allParams: {
          'choosenChat': getParameter<DocumentReference>(data, 'choosenChat'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
