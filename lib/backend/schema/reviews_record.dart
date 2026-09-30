import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReviewsRecord extends FirestoreRecord {
  ReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "author" field.
  DocumentReference? _author;
  DocumentReference? get author => _author;
  bool hasAuthor() => _author != null;

  // "about" field.
  DocumentReference? _about;
  DocumentReference? get about => _about;
  bool hasAbout() => _about != null;

  // "star" field.
  int? _star;
  int get star => _star ?? 0;
  bool hasStar() => _star != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "work" field.
  DocumentReference? _work;
  DocumentReference? get work => _work;
  bool hasWork() => _work != null;

  void _initializeFields() {
    _author = snapshotData['author'] as DocumentReference?;
    _about = snapshotData['about'] as DocumentReference?;
    _star = castToType<int>(snapshotData['star']);
    _comment = snapshotData['comment'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _work = snapshotData['work'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviews');

  static Stream<ReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewsRecord.fromSnapshot(s));

  static Future<ReviewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewsRecord.fromSnapshot(s));

  static ReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReviewsRecordData({
  DocumentReference? author,
  DocumentReference? about,
  int? star,
  String? comment,
  DateTime? date,
  DocumentReference? work,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'author': author,
      'about': about,
      'star': star,
      'comment': comment,
      'date': date,
      'work': work,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReviewsRecordDocumentEquality implements Equality<ReviewsRecord> {
  const ReviewsRecordDocumentEquality();

  @override
  bool equals(ReviewsRecord? e1, ReviewsRecord? e2) {
    return e1?.author == e2?.author &&
        e1?.about == e2?.about &&
        e1?.star == e2?.star &&
        e1?.comment == e2?.comment &&
        e1?.date == e2?.date &&
        e1?.work == e2?.work;
  }

  @override
  int hash(ReviewsRecord? e) => const ListEquality()
      .hash([e?.author, e?.about, e?.star, e?.comment, e?.date, e?.work]);

  @override
  bool isValidKey(Object? o) => o is ReviewsRecord;
}
