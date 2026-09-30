import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AchivmentsRecord extends FirestoreRecord {
  AchivmentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "whenAchived" field.
  DateTime? _whenAchived;
  DateTime? get whenAchived => _whenAchived;
  bool hasWhenAchived() => _whenAchived != null;

  // "whenLose" field.
  DateTime? _whenLose;
  DateTime? get whenLose => _whenLose;
  bool hasWhenLose() => _whenLose != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _image = snapshotData['image'] as String?;
    _description = snapshotData['description'] as String?;
    _whenAchived = snapshotData['whenAchived'] as DateTime?;
    _whenLose = snapshotData['whenLose'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('achivments');

  static Stream<AchivmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AchivmentsRecord.fromSnapshot(s));

  static Future<AchivmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AchivmentsRecord.fromSnapshot(s));

  static AchivmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AchivmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AchivmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AchivmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AchivmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AchivmentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAchivmentsRecordData({
  String? title,
  String? image,
  String? description,
  DateTime? whenAchived,
  DateTime? whenLose,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'image': image,
      'description': description,
      'whenAchived': whenAchived,
      'whenLose': whenLose,
    }.withoutNulls,
  );

  return firestoreData;
}

class AchivmentsRecordDocumentEquality implements Equality<AchivmentsRecord> {
  const AchivmentsRecordDocumentEquality();

  @override
  bool equals(AchivmentsRecord? e1, AchivmentsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.image == e2?.image &&
        e1?.description == e2?.description &&
        e1?.whenAchived == e2?.whenAchived &&
        e1?.whenLose == e2?.whenLose;
  }

  @override
  int hash(AchivmentsRecord? e) => const ListEquality()
      .hash([e?.title, e?.image, e?.description, e?.whenAchived, e?.whenLose]);

  @override
  bool isValidKey(Object? o) => o is AchivmentsRecord;
}
