import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _choosenRoleWorker =
          prefs.getBool('ff_choosenRoleWorker') ?? _choosenRoleWorker;
    });
    _safeInit(() {
      _firstTime = prefs.getBool('ff_firstTime') ?? _firstTime;
    });
    _safeInit(() {
      _saveCat = prefs
              .getStringList('ff_saveCat')
              ?.map((x) {
                try {
                  return DownloadCatStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _saveCat;
    });
    _safeInit(() {
      _KYCUserCheck = prefs.getBool('ff_KYCUserCheck') ?? _KYCUserCheck;
    });
    _safeInit(() {
      _saveCatRef = prefs
              .getStringList('ff_saveCatRef')
              ?.map((path) => path.ref)
              .toList() ??
          _saveCatRef;
    });
    _safeInit(() {
      _notifPermiss = prefs.getBool('ff_notifPermiss') ?? _notifPermiss;
    });
    _safeInit(() {
      _locationPermiss =
          prefs.getBool('ff_locationPermiss') ?? _locationPermiss;
    });
    _safeInit(() {
      _baseUrl = prefs.getString('ff_baseUrl') ?? _baseUrl;
    });
    _safeInit(() {
      _terminalId = prefs.getString('ff_terminalId') ?? _terminalId;
    });
    _safeInit(() {
      _accessToken = prefs.getString('ff_accessToken') ?? _accessToken;
    });
    _safeInit(() {
      _refreshToken = prefs.getString('ff_refreshToken') ?? _refreshToken;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_checkLastInvoice')) {
        try {
          final serializedData = prefs.getString('ff_checkLastInvoice') ?? '{}';
          _checkLastInvoice =
              LastInvoiceStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _choosenRoleWorker = true;
  bool get choosenRoleWorker => _choosenRoleWorker;
  set choosenRoleWorker(bool value) {
    _choosenRoleWorker = value;
    prefs.setBool('ff_choosenRoleWorker', value);
  }

  bool _firstTime = true;
  bool get firstTime => _firstTime;
  set firstTime(bool value) {
    _firstTime = value;
    prefs.setBool('ff_firstTime', value);
  }

  int _colorNumber = 0;
  int get colorNumber => _colorNumber;
  set colorNumber(int value) {
    _colorNumber = value;
  }

  List<DownloadCatStruct> _saveCat = [];
  List<DownloadCatStruct> get saveCat => _saveCat;
  set saveCat(List<DownloadCatStruct> value) {
    _saveCat = value;
    prefs.setStringList('ff_saveCat', value.map((x) => x.serialize()).toList());
  }

  void addToSaveCat(DownloadCatStruct value) {
    saveCat.add(value);
    prefs.setStringList(
        'ff_saveCat', _saveCat.map((x) => x.serialize()).toList());
  }

  void removeFromSaveCat(DownloadCatStruct value) {
    saveCat.remove(value);
    prefs.setStringList(
        'ff_saveCat', _saveCat.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSaveCat(int index) {
    saveCat.removeAt(index);
    prefs.setStringList(
        'ff_saveCat', _saveCat.map((x) => x.serialize()).toList());
  }

  void updateSaveCatAtIndex(
    int index,
    DownloadCatStruct Function(DownloadCatStruct) updateFn,
  ) {
    saveCat[index] = updateFn(_saveCat[index]);
    prefs.setStringList(
        'ff_saveCat', _saveCat.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSaveCat(int index, DownloadCatStruct value) {
    saveCat.insert(index, value);
    prefs.setStringList(
        'ff_saveCat', _saveCat.map((x) => x.serialize()).toList());
  }

  CreateJobDataStruct _newJobCreate = CreateJobDataStruct();
  CreateJobDataStruct get newJobCreate => _newJobCreate;
  set newJobCreate(CreateJobDataStruct value) {
    _newJobCreate = value;
  }

  void updateNewJobCreateStruct(Function(CreateJobDataStruct) updateFn) {
    updateFn(_newJobCreate);
  }

  FilterDataStruct _mainFilter = FilterDataStruct.fromSerializableMap(
      jsonDecode('{\"userPoint\":\"0.0,0.0\",\"categories\":\"[]\"}'));
  FilterDataStruct get mainFilter => _mainFilter;
  set mainFilter(FilterDataStruct value) {
    _mainFilter = value;
  }

  void updateMainFilterStruct(Function(FilterDataStruct) updateFn) {
    updateFn(_mainFilter);
  }

  int _commission = 0;
  int get commission => _commission;
  set commission(int value) {
    _commission = value;
  }

  bool _KYCUserCheck = false;
  bool get KYCUserCheck => _KYCUserCheck;
  set KYCUserCheck(bool value) {
    _KYCUserCheck = value;
    prefs.setBool('ff_KYCUserCheck', value);
  }

  List<DocumentReference> _saveCatRef = [];
  List<DocumentReference> get saveCatRef => _saveCatRef;
  set saveCatRef(List<DocumentReference> value) {
    _saveCatRef = value;
    prefs.setStringList('ff_saveCatRef', value.map((x) => x.path).toList());
  }

  void addToSaveCatRef(DocumentReference value) {
    saveCatRef.add(value);
    prefs.setStringList(
        'ff_saveCatRef', _saveCatRef.map((x) => x.path).toList());
  }

  void removeFromSaveCatRef(DocumentReference value) {
    saveCatRef.remove(value);
    prefs.setStringList(
        'ff_saveCatRef', _saveCatRef.map((x) => x.path).toList());
  }

  void removeAtIndexFromSaveCatRef(int index) {
    saveCatRef.removeAt(index);
    prefs.setStringList(
        'ff_saveCatRef', _saveCatRef.map((x) => x.path).toList());
  }

  void updateSaveCatRefAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    saveCatRef[index] = updateFn(_saveCatRef[index]);
    prefs.setStringList(
        'ff_saveCatRef', _saveCatRef.map((x) => x.path).toList());
  }

  void insertAtIndexInSaveCatRef(int index, DocumentReference value) {
    saveCatRef.insert(index, value);
    prefs.setStringList(
        'ff_saveCatRef', _saveCatRef.map((x) => x.path).toList());
  }

  int _testVarCount = 0;
  int get testVarCount => _testVarCount;
  set testVarCount(int value) {
    _testVarCount = value;
  }

  bool _notifPermiss = false;
  bool get notifPermiss => _notifPermiss;
  set notifPermiss(bool value) {
    _notifPermiss = value;
    prefs.setBool('ff_notifPermiss', value);
  }

  bool _locationPermiss = false;
  bool get locationPermiss => _locationPermiss;
  set locationPermiss(bool value) {
    _locationPermiss = value;
    prefs.setBool('ff_locationPermiss', value);
  }

  String _baseUrl = 'https://apis.bonum.mn/bonum-gateway';
  String get baseUrl => _baseUrl;
  set baseUrl(String value) {
    _baseUrl = value;
    prefs.setString('ff_baseUrl', value);
  }

  String _terminalId = '17171893';
  String get terminalId => _terminalId;
  set terminalId(String value) {
    _terminalId = value;
    prefs.setString('ff_terminalId', value);
  }

  String _tokenType = '';
  String get tokenType => _tokenType;
  set tokenType(String value) {
    _tokenType = value;
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
    prefs.setString('ff_accessToken', value);
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String value) {
    _refreshToken = value;
    prefs.setString('ff_refreshToken', value);
  }

  String _currentInvoiceId = '';
  String get currentInvoiceId => _currentInvoiceId;
  set currentInvoiceId(String value) {
    _currentInvoiceId = value;
  }

  String _followUpLink = '';
  String get followUpLink => _followUpLink;
  set followUpLink(String value) {
    _followUpLink = value;
  }

  LastInvoiceStruct _checkLastInvoice = LastInvoiceStruct.fromSerializableMap(
      jsonDecode('{\"checked\":\"true\",\"checkCounter\":\"0\"}'));
  LastInvoiceStruct get checkLastInvoice => _checkLastInvoice;
  set checkLastInvoice(LastInvoiceStruct value) {
    _checkLastInvoice = value;
    prefs.setString('ff_checkLastInvoice', value.serialize());
  }

  void updateCheckLastInvoiceStruct(Function(LastInvoiceStruct) updateFn) {
    updateFn(_checkLastInvoice);
    prefs.setString('ff_checkLastInvoice', _checkLastInvoice.serialize());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
