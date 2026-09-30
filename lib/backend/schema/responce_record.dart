import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponceRecord extends FirestoreRecord {
  ResponceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "resp_sender" field.
  DocumentReference? _respSender;
  DocumentReference? get respSender => _respSender;
  bool hasRespSender() => _respSender != null;

  // "resp_reciver" field.
  DocumentReference? _respReciver;
  DocumentReference? get respReciver => _respReciver;
  bool hasRespReciver() => _respReciver != null;

  // "resp_service" field.
  DocumentReference? _respService;
  DocumentReference? get respService => _respService;
  bool hasRespService() => _respService != null;

  // "resp_order" field.
  DocumentReference? _respOrder;
  DocumentReference? get respOrder => _respOrder;
  bool hasRespOrder() => _respOrder != null;

  // "new_responce" field.
  bool? _newResponce;
  bool get newResponce => _newResponce ?? false;
  bool hasNewResponce() => _newResponce != null;

  // "resp_price" field.
  int? _respPrice;
  int get respPrice => _respPrice ?? 0;
  bool hasRespPrice() => _respPrice != null;

  // "resp_letter" field.
  String? _respLetter;
  String get respLetter => _respLetter ?? '';
  bool hasRespLetter() => _respLetter != null;

  // "resp_deadline" field.
  int? _respDeadline;
  int get respDeadline => _respDeadline ?? 0;
  bool hasRespDeadline() => _respDeadline != null;

  // "respOffer" field.
  OfferType? _respOffer;
  OfferType? get respOffer => _respOffer;
  bool hasRespOffer() => _respOffer != null;

  void _initializeFields() {
    _respSender = snapshotData['resp_sender'] as DocumentReference?;
    _respReciver = snapshotData['resp_reciver'] as DocumentReference?;
    _respService = snapshotData['resp_service'] as DocumentReference?;
    _respOrder = snapshotData['resp_order'] as DocumentReference?;
    _newResponce = snapshotData['new_responce'] as bool?;
    _respPrice = castToType<int>(snapshotData['resp_price']);
    _respLetter = snapshotData['resp_letter'] as String?;
    _respDeadline = castToType<int>(snapshotData['resp_deadline']);
    _respOffer = snapshotData['respOffer'] is OfferType
        ? snapshotData['respOffer']
        : deserializeEnum<OfferType>(snapshotData['respOffer']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('responce');

  static Stream<ResponceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ResponceRecord.fromSnapshot(s));

  static Future<ResponceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ResponceRecord.fromSnapshot(s));

  static ResponceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ResponceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ResponceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ResponceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ResponceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ResponceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createResponceRecordData({
  DocumentReference? respSender,
  DocumentReference? respReciver,
  DocumentReference? respService,
  DocumentReference? respOrder,
  bool? newResponce,
  int? respPrice,
  String? respLetter,
  int? respDeadline,
  OfferType? respOffer,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'resp_sender': respSender,
      'resp_reciver': respReciver,
      'resp_service': respService,
      'resp_order': respOrder,
      'new_responce': newResponce,
      'resp_price': respPrice,
      'resp_letter': respLetter,
      'resp_deadline': respDeadline,
      'respOffer': respOffer,
    }.withoutNulls,
  );

  return firestoreData;
}

class ResponceRecordDocumentEquality implements Equality<ResponceRecord> {
  const ResponceRecordDocumentEquality();

  @override
  bool equals(ResponceRecord? e1, ResponceRecord? e2) {
    return e1?.respSender == e2?.respSender &&
        e1?.respReciver == e2?.respReciver &&
        e1?.respService == e2?.respService &&
        e1?.respOrder == e2?.respOrder &&
        e1?.newResponce == e2?.newResponce &&
        e1?.respPrice == e2?.respPrice &&
        e1?.respLetter == e2?.respLetter &&
        e1?.respDeadline == e2?.respDeadline &&
        e1?.respOffer == e2?.respOffer;
  }

  @override
  int hash(ResponceRecord? e) => const ListEquality().hash([
        e?.respSender,
        e?.respReciver,
        e?.respService,
        e?.respOrder,
        e?.newResponce,
        e?.respPrice,
        e?.respLetter,
        e?.respDeadline,
        e?.respOffer
      ]);

  @override
  bool isValidKey(Object? o) => o is ResponceRecord;
}
