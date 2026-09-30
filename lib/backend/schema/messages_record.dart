import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chat" field.
  DocumentReference? _chat;
  DocumentReference? get chat => _chat;
  bool hasChat() => _chat != null;

  // "who_send" field.
  DocumentReference? _whoSend;
  DocumentReference? get whoSend => _whoSend;
  bool hasWhoSend() => _whoSend != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "timestemp" field.
  DateTime? _timestemp;
  DateTime? get timestemp => _timestemp;
  bool hasTimestemp() => _timestemp != null;

  // "image" field.
  List<String>? _image;
  List<String> get image => _image ?? const [];
  bool hasImage() => _image != null;

  // "document" field.
  String? _document;
  String get document => _document ?? '';
  bool hasDocument() => _document != null;

  // "debateMess" field.
  DebateStatus? _debateMess;
  DebateStatus? get debateMess => _debateMess;
  bool hasDebateMess() => _debateMess != null;

  void _initializeFields() {
    _chat = snapshotData['chat'] as DocumentReference?;
    _whoSend = snapshotData['who_send'] as DocumentReference?;
    _text = snapshotData['text'] as String?;
    _timestemp = snapshotData['timestemp'] as DateTime?;
    _image = getDataList(snapshotData['image']);
    _document = snapshotData['document'] as String?;
    _debateMess = snapshotData['debateMess'] is DebateStatus
        ? snapshotData['debateMess']
        : deserializeEnum<DebateStatus>(snapshotData['debateMess']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('messages');

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  DocumentReference? chat,
  DocumentReference? whoSend,
  String? text,
  DateTime? timestemp,
  String? document,
  DebateStatus? debateMess,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chat': chat,
      'who_send': whoSend,
      'text': text,
      'timestemp': timestemp,
      'document': document,
      'debateMess': debateMess,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.chat == e2?.chat &&
        e1?.whoSend == e2?.whoSend &&
        e1?.text == e2?.text &&
        e1?.timestemp == e2?.timestemp &&
        listEquality.equals(e1?.image, e2?.image) &&
        e1?.document == e2?.document &&
        e1?.debateMess == e2?.debateMess;
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash([
        e?.chat,
        e?.whoSend,
        e?.text,
        e?.timestemp,
        e?.image,
        e?.document,
        e?.debateMess
      ]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
