// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DownloadCatStruct extends FFFirebaseStruct {
  DownloadCatStruct({
    String? title,
    DocumentReference? refCat,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _refCat = refCat,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "refCat" field.
  DocumentReference? _refCat;
  DocumentReference? get refCat => _refCat;
  set refCat(DocumentReference? val) => _refCat = val;

  bool hasRefCat() => _refCat != null;

  static DownloadCatStruct fromMap(Map<String, dynamic> data) =>
      DownloadCatStruct(
        title: data['title'] as String?,
        refCat: data['refCat'] as DocumentReference?,
      );

  static DownloadCatStruct? maybeFromMap(dynamic data) => data is Map
      ? DownloadCatStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'refCat': _refCat,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'refCat': serializeParam(
          _refCat,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static DownloadCatStruct fromSerializableMap(Map<String, dynamic> data) =>
      DownloadCatStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        refCat: deserializeParam(
          data['refCat'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['category'],
        ),
      );

  @override
  String toString() => 'DownloadCatStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DownloadCatStruct &&
        title == other.title &&
        refCat == other.refCat;
  }

  @override
  int get hashCode => const ListEquality().hash([title, refCat]);
}

DownloadCatStruct createDownloadCatStruct({
  String? title,
  DocumentReference? refCat,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DownloadCatStruct(
      title: title,
      refCat: refCat,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DownloadCatStruct? updateDownloadCatStruct(
  DownloadCatStruct? downloadCat, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    downloadCat
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDownloadCatStructData(
  Map<String, dynamic> firestoreData,
  DownloadCatStruct? downloadCat,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (downloadCat == null) {
    return;
  }
  if (downloadCat.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && downloadCat.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final downloadCatData =
      getDownloadCatFirestoreData(downloadCat, forFieldValue);
  final nestedData =
      downloadCatData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = downloadCat.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDownloadCatFirestoreData(
  DownloadCatStruct? downloadCat, [
  bool forFieldValue = false,
]) {
  if (downloadCat == null) {
    return {};
  }
  final firestoreData = mapToFirestore(downloadCat.toMap());

  // Add any Firestore field values
  downloadCat.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDownloadCatListFirestoreData(
  List<DownloadCatStruct>? downloadCats,
) =>
    downloadCats?.map((e) => getDownloadCatFirestoreData(e, true)).toList() ??
    [];
