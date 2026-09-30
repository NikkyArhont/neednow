// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LastInvoiceStruct extends FFFirebaseStruct {
  LastInvoiceStruct({
    bool? checked,
    DocumentReference? id,
    int? checkCounter,
    String? invoiceID,
    String? currentStatusAPI,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _checked = checked,
        _id = id,
        _checkCounter = checkCounter,
        _invoiceID = invoiceID,
        _currentStatusAPI = currentStatusAPI,
        super(firestoreUtilData);

  // "checked" field.
  bool? _checked;
  bool get checked => _checked ?? false;
  set checked(bool? val) => _checked = val;

  bool hasChecked() => _checked != null;

  // "id" field.
  DocumentReference? _id;
  DocumentReference? get id => _id;
  set id(DocumentReference? val) => _id = val;

  bool hasId() => _id != null;

  // "checkCounter" field.
  int? _checkCounter;
  int get checkCounter => _checkCounter ?? 0;
  set checkCounter(int? val) => _checkCounter = val;

  void incrementCheckCounter(int amount) =>
      checkCounter = checkCounter + amount;

  bool hasCheckCounter() => _checkCounter != null;

  // "invoiceID" field.
  String? _invoiceID;
  String get invoiceID => _invoiceID ?? '';
  set invoiceID(String? val) => _invoiceID = val;

  bool hasInvoiceID() => _invoiceID != null;

  // "currentStatusAPI" field.
  String? _currentStatusAPI;
  String get currentStatusAPI => _currentStatusAPI ?? '';
  set currentStatusAPI(String? val) => _currentStatusAPI = val;

  bool hasCurrentStatusAPI() => _currentStatusAPI != null;

  static LastInvoiceStruct fromMap(Map<String, dynamic> data) =>
      LastInvoiceStruct(
        checked: data['checked'] as bool?,
        id: data['id'] as DocumentReference?,
        checkCounter: castToType<int>(data['checkCounter']),
        invoiceID: data['invoiceID'] as String?,
        currentStatusAPI: data['currentStatusAPI'] as String?,
      );

  static LastInvoiceStruct? maybeFromMap(dynamic data) => data is Map
      ? LastInvoiceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'checked': _checked,
        'id': _id,
        'checkCounter': _checkCounter,
        'invoiceID': _invoiceID,
        'currentStatusAPI': _currentStatusAPI,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'checked': serializeParam(
          _checked,
          ParamType.bool,
        ),
        'id': serializeParam(
          _id,
          ParamType.DocumentReference,
        ),
        'checkCounter': serializeParam(
          _checkCounter,
          ParamType.int,
        ),
        'invoiceID': serializeParam(
          _invoiceID,
          ParamType.String,
        ),
        'currentStatusAPI': serializeParam(
          _currentStatusAPI,
          ParamType.String,
        ),
      }.withoutNulls;

  static LastInvoiceStruct fromSerializableMap(Map<String, dynamic> data) =>
      LastInvoiceStruct(
        checked: deserializeParam(
          data['checked'],
          ParamType.bool,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['transactions'],
        ),
        checkCounter: deserializeParam(
          data['checkCounter'],
          ParamType.int,
          false,
        ),
        invoiceID: deserializeParam(
          data['invoiceID'],
          ParamType.String,
          false,
        ),
        currentStatusAPI: deserializeParam(
          data['currentStatusAPI'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LastInvoiceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LastInvoiceStruct &&
        checked == other.checked &&
        id == other.id &&
        checkCounter == other.checkCounter &&
        invoiceID == other.invoiceID &&
        currentStatusAPI == other.currentStatusAPI;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([checked, id, checkCounter, invoiceID, currentStatusAPI]);
}

LastInvoiceStruct createLastInvoiceStruct({
  bool? checked,
  DocumentReference? id,
  int? checkCounter,
  String? invoiceID,
  String? currentStatusAPI,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LastInvoiceStruct(
      checked: checked,
      id: id,
      checkCounter: checkCounter,
      invoiceID: invoiceID,
      currentStatusAPI: currentStatusAPI,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LastInvoiceStruct? updateLastInvoiceStruct(
  LastInvoiceStruct? lastInvoice, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    lastInvoice
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLastInvoiceStructData(
  Map<String, dynamic> firestoreData,
  LastInvoiceStruct? lastInvoice,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (lastInvoice == null) {
    return;
  }
  if (lastInvoice.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && lastInvoice.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final lastInvoiceData =
      getLastInvoiceFirestoreData(lastInvoice, forFieldValue);
  final nestedData =
      lastInvoiceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = lastInvoice.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLastInvoiceFirestoreData(
  LastInvoiceStruct? lastInvoice, [
  bool forFieldValue = false,
]) {
  if (lastInvoice == null) {
    return {};
  }
  final firestoreData = mapToFirestore(lastInvoice.toMap());

  // Add any Firestore field values
  lastInvoice.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLastInvoiceListFirestoreData(
  List<LastInvoiceStruct>? lastInvoices,
) =>
    lastInvoices?.map((e) => getLastInvoiceFirestoreData(e, true)).toList() ??
    [];
