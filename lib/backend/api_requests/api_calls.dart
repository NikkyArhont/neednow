import 'dart:convert';
import 'dart:typed_data';
import '../cloud_functions/cloud_functions.dart';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCityCall {
  static Future<ApiCallResponse> call({
    String? city = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetCityCall',
        'variables': {
          'city': city,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static List<String>? listCity(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].structured_formatting.main_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? listPlaceId(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].place_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? listDescription(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAdressCall {
  static Future<ApiCallResponse> call({
    String? addres = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetAdressCall',
        'variables': {
          'addres': addres,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static List<String>? listCity(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].structured_formatting.main_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? listPlaceId(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].place_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? listDescription(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetPlaceLatLngCall {
  static Future<ApiCallResponse> call({
    String? placeId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetPlaceLatLngCall',
        'variables': {
          'placeId': placeId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static dynamic? placeLatLon(dynamic response) => getJsonField(
        response,
        r'''$.result.geometry.location''',
      );
}

class BonumAuthCreateCall {
  static Future<ApiCallResponse> call({
    String? tokenHdr = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'BonumAuthCreateCall',
        'variables': {
          'tokenHdr': tokenHdr,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static String? tokenType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.tokenType''',
      ));
  static String? accessToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.accessToken''',
      ));
  static String? refreshToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refreshToken''',
      ));
}

class BonumAuthRefreshCall {
  static Future<ApiCallResponse> call({
    String? tokenType = '',
    String? refreshToken = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'BonumAuthRefreshCall',
        'variables': {
          'tokenType': tokenType,
          'refreshToken': refreshToken,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static String? tokenType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.tokenType''',
      ));
  static String? accessToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.accessToken''',
      ));
  static String? refreshToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refreshToken''',
      ));
}

class BonumCreateInvoiceCall {
  static Future<ApiCallResponse> call({
    int? amount = 100,
    String? callback = '',
    String? transactionId = 'test-uuid-1234551111',
    String? tokenType = '',
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
"amount": ${amount}, 
  "callback": "${escapeStringForJson(callback)}",
  "transactionId": "${escapeStringForJson(transactionId)}",
  "expiresIn": 600
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'BonumCreateInvoice',
      apiUrl: 'https://apis.bonum.mn/bonum-gateway/ecommerce/invoices',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${tokenType} ${refreshToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? invoceId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.invoiceId''',
      ));
  static String? followUpLink(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.followUpLink''',
      ));
}

class BonumGetInvoiceStatusCall {
  static Future<ApiCallResponse> call({
    String? invoiceId = '',
    String? statusUrl = '',
    String? tokenType = '',
    String? accessToken = '',
    String? terminalId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'BonumGetInvoiceStatus',
      apiUrl:
          'https://apis.bonum.mn/bonum-gateway/ecommerce/invoices/${invoiceId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${tokenType} ${accessToken}',
        'Accept': 'application/json',
        'X-TERMINAL-ID': '${terminalId}',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? paymentStatus(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
  static String? vendor(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.paymentVendor''',
      ));
  static String? transID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.transactionId''',
      ));
  static double? amount(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.amount''',
      ));
  static String? time(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.updatedAt''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
