import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "members" field.
  List<DocumentReference>? _members;
  List<DocumentReference> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "messages" field.
  List<DocumentReference>? _messages;
  List<DocumentReference> get messages => _messages ?? const [];
  bool hasMessages() => _messages != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "last_message_sender" field.
  DocumentReference? _lastMessageSender;
  DocumentReference? get lastMessageSender => _lastMessageSender;
  bool hasLastMessageSender() => _lastMessageSender != null;

  // "last_message_seen_by" field.
  List<DocumentReference>? _lastMessageSeenBy;
  List<DocumentReference> get lastMessageSeenBy =>
      _lastMessageSeenBy ?? const [];
  bool hasLastMessageSeenBy() => _lastMessageSeenBy != null;

  // "work" field.
  DocumentReference? _work;
  DocumentReference? get work => _work;
  bool hasWork() => _work != null;

  // "chatTitle" field.
  String? _chatTitle;
  String get chatTitle => _chatTitle ?? '';
  bool hasChatTitle() => _chatTitle != null;

  // "debateStatus" field.
  DebateStatus? _debateStatus;
  DebateStatus? get debateStatus => _debateStatus;
  bool hasDebateStatus() => _debateStatus != null;

  void _initializeFields() {
    _members = getDataList(snapshotData['members']);
    _messages = getDataList(snapshotData['messages']);
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _lastMessageSender =
        snapshotData['last_message_sender'] as DocumentReference?;
    _lastMessageSeenBy = getDataList(snapshotData['last_message_seen_by']);
    _work = snapshotData['work'] as DocumentReference?;
    _chatTitle = snapshotData['chatTitle'] as String?;
    _debateStatus = snapshotData['debateStatus'] is DebateStatus
        ? snapshotData['debateStatus']
        : deserializeEnum<DebateStatus>(snapshotData['debateStatus']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? lastMessageSender,
  DocumentReference? work,
  String? chatTitle,
  DebateStatus? debateStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'last_message_sender': lastMessageSender,
      'work': work,
      'chatTitle': chatTitle,
      'debateStatus': debateStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.members, e2?.members) &&
        listEquality.equals(e1?.messages, e2?.messages) &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.lastMessageSender == e2?.lastMessageSender &&
        listEquality.equals(e1?.lastMessageSeenBy, e2?.lastMessageSeenBy) &&
        e1?.work == e2?.work &&
        e1?.chatTitle == e2?.chatTitle &&
        e1?.debateStatus == e2?.debateStatus;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.members,
        e?.messages,
        e?.lastMessage,
        e?.lastMessageTime,
        e?.lastMessageSender,
        e?.lastMessageSeenBy,
        e?.work,
        e?.chatTitle,
        e?.debateStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
