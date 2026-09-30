// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class KycStruct extends FFFirebaseStruct {
  KycStruct({
    KycStruct? status,
    List<String>? photoKYC,
    String? messageFailed,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _photoKYC = photoKYC,
        _messageFailed = messageFailed,
        super(firestoreUtilData);

  // "status" field.
  KycStruct? _status;
  KycStruct get status => _status ?? KycStruct();
  set status(KycStruct? val) => _status = val;

  void updateStatus(Function(KycStruct) updateFn) {
    updateFn(_status ??= KycStruct());
  }

  bool hasStatus() => _status != null;

  // "photoKYC" field.
  List<String>? _photoKYC;
  List<String> get photoKYC => _photoKYC ?? const [];
  set photoKYC(List<String>? val) => _photoKYC = val;

  void updatePhotoKYC(Function(List<String>) updateFn) {
    updateFn(_photoKYC ??= []);
  }

  bool hasPhotoKYC() => _photoKYC != null;

  // "messageFailed" field.
  String? _messageFailed;
  String get messageFailed => _messageFailed ?? '';
  set messageFailed(String? val) => _messageFailed = val;

  bool hasMessageFailed() => _messageFailed != null;

  static KycStruct fromMap(Map<String, dynamic> data) => KycStruct(
        status: data['status'] is KycStruct
            ? data['status']
            : KycStruct.maybeFromMap(data['status']),
        photoKYC: getDataList(data['photoKYC']),
        messageFailed: data['messageFailed'] as String?,
      );

  static KycStruct? maybeFromMap(dynamic data) =>
      data is Map ? KycStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'status': _status?.toMap(),
        'photoKYC': _photoKYC,
        'messageFailed': _messageFailed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.DataStruct,
        ),
        'photoKYC': serializeParam(
          _photoKYC,
          ParamType.String,
          isList: true,
        ),
        'messageFailed': serializeParam(
          _messageFailed,
          ParamType.String,
        ),
      }.withoutNulls;

  static KycStruct fromSerializableMap(Map<String, dynamic> data) => KycStruct(
        status: deserializeStructParam(
          data['status'],
          ParamType.DataStruct,
          false,
          structBuilder: KycStruct.fromSerializableMap,
        ),
        photoKYC: deserializeParam<String>(
          data['photoKYC'],
          ParamType.String,
          true,
        ),
        messageFailed: deserializeParam(
          data['messageFailed'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'KycStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is KycStruct &&
        status == other.status &&
        listEquality.equals(photoKYC, other.photoKYC) &&
        messageFailed == other.messageFailed;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, photoKYC, messageFailed]);
}

KycStruct createKycStruct({
  KycStruct? status,
  String? messageFailed,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    KycStruct(
      status: status ?? (clearUnsetFields ? KycStruct() : null),
      messageFailed: messageFailed,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

KycStruct? updateKycStruct(
  KycStruct? kyc, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    kyc
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addKycStructData(
  Map<String, dynamic> firestoreData,
  KycStruct? kyc,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (kyc == null) {
    return;
  }
  if (kyc.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && kyc.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final kycData = getKycFirestoreData(kyc, forFieldValue);
  final nestedData = kycData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = kyc.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getKycFirestoreData(
  KycStruct? kyc, [
  bool forFieldValue = false,
]) {
  if (kyc == null) {
    return {};
  }
  final firestoreData = mapToFirestore(kyc.toMap());

  // Handle nested data for "status" field.
  addKycStructData(
    firestoreData,
    kyc.hasStatus() ? kyc.status : null,
    'status',
    forFieldValue,
  );

  // Add any Firestore field values
  kyc.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getKycListFirestoreData(
  List<KycStruct>? kycs,
) =>
    kycs?.map((e) => getKycFirestoreData(e, true)).toList() ?? [];
