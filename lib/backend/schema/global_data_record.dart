import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GlobalDataRecord extends FirestoreRecord {
  GlobalDataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comission" field.
  int? _comission;
  int get comission => _comission ?? 0;
  bool hasComission() => _comission != null;

  void _initializeFields() {
    _comission = castToType<int>(snapshotData['comission']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('globalData');

  static Stream<GlobalDataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GlobalDataRecord.fromSnapshot(s));

  static Future<GlobalDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GlobalDataRecord.fromSnapshot(s));

  static GlobalDataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GlobalDataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GlobalDataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GlobalDataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GlobalDataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GlobalDataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGlobalDataRecordData({
  int? comission,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comission': comission,
    }.withoutNulls,
  );

  return firestoreData;
}

class GlobalDataRecordDocumentEquality implements Equality<GlobalDataRecord> {
  const GlobalDataRecordDocumentEquality();

  @override
  bool equals(GlobalDataRecord? e1, GlobalDataRecord? e2) {
    return e1?.comission == e2?.comission;
  }

  @override
  int hash(GlobalDataRecord? e) => const ListEquality().hash([e?.comission]);

  @override
  bool isValidKey(Object? o) => o is GlobalDataRecord;
}
