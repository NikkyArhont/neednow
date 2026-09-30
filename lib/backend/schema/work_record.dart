import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkRecord extends FirestoreRecord {
  WorkRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "order" field.
  DocumentReference? _order;
  DocumentReference? get order => _order;
  bool hasOrder() => _order != null;

  // "worker" field.
  DocumentReference? _worker;
  DocumentReference? get worker => _worker;
  bool hasWorker() => _worker != null;

  // "client" field.
  DocumentReference? _client;
  DocumentReference? get client => _client;
  bool hasClient() => _client != null;

  // "history_responces" field.
  List<DocumentReference>? _historyResponces;
  List<DocumentReference> get historyResponces => _historyResponces ?? const [];
  bool hasHistoryResponces() => _historyResponces != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "agreed_price" field.
  int? _agreedPrice;
  int get agreedPrice => _agreedPrice ?? 0;
  bool hasAgreedPrice() => _agreedPrice != null;

  // "safe_deal" field.
  bool? _safeDeal;
  bool get safeDeal => _safeDeal ?? false;
  bool hasSafeDeal() => _safeDeal != null;

  // "work_chat" field.
  DocumentReference? _workChat;
  DocumentReference? get workChat => _workChat;
  bool hasWorkChat() => _workChat != null;

  // "review_from_client" field.
  bool? _reviewFromClient;
  bool get reviewFromClient => _reviewFromClient ?? false;
  bool hasReviewFromClient() => _reviewFromClient != null;

  // "review_from_worker" field.
  bool? _reviewFromWorker;
  bool get reviewFromWorker => _reviewFromWorker ?? false;
  bool hasReviewFromWorker() => _reviewFromWorker != null;

  // "finished_time" field.
  DateTime? _finishedTime;
  DateTime? get finishedTime => _finishedTime;
  bool hasFinishedTime() => _finishedTime != null;

  // "work_status" field.
  ResponseType? _workStatus;
  ResponseType? get workStatus => _workStatus;
  bool hasWorkStatus() => _workStatus != null;

  // "work_title" field.
  String? _workTitle;
  String get workTitle => _workTitle ?? '';
  bool hasWorkTitle() => _workTitle != null;

  // "service" field.
  DocumentReference? _service;
  DocumentReference? get service => _service;
  bool hasService() => _service != null;

  // "accompleshedDate" field.
  DateTime? _accompleshedDate;
  DateTime? get accompleshedDate => _accompleshedDate;
  bool hasAccompleshedDate() => _accompleshedDate != null;

  // "debateStatus" field.
  DebateStatus? _debateStatus;
  DebateStatus? get debateStatus => _debateStatus;
  bool hasDebateStatus() => _debateStatus != null;

  // "debateAuthor" field.
  DocumentReference? _debateAuthor;
  DocumentReference? get debateAuthor => _debateAuthor;
  bool hasDebateAuthor() => _debateAuthor != null;

  // "debateRefery" field.
  DocumentReference? _debateRefery;
  DocumentReference? get debateRefery => _debateRefery;
  bool hasDebateRefery() => _debateRefery != null;

  // "agreed_deadline" field.
  int? _agreedDeadline;
  int get agreedDeadline => _agreedDeadline ?? 0;
  bool hasAgreedDeadline() => _agreedDeadline != null;

  // "lastPayDay" field.
  DateTime? _lastPayDay;
  DateTime? get lastPayDay => _lastPayDay;
  bool hasLastPayDay() => _lastPayDay != null;

  // "dabateMessage" field.
  String? _dabateMessage;
  String get dabateMessage => _dabateMessage ?? '';
  bool hasDabateMessage() => _dabateMessage != null;

  // "byOffer" field.
  bool? _byOffer;
  bool get byOffer => _byOffer ?? false;
  bool hasByOffer() => _byOffer != null;

  void _initializeFields() {
    _order = snapshotData['order'] as DocumentReference?;
    _worker = snapshotData['worker'] as DocumentReference?;
    _client = snapshotData['client'] as DocumentReference?;
    _historyResponces = getDataList(snapshotData['history_responces']);
    _createdTime = snapshotData['created_time'] as DateTime?;
    _agreedPrice = castToType<int>(snapshotData['agreed_price']);
    _safeDeal = snapshotData['safe_deal'] as bool?;
    _workChat = snapshotData['work_chat'] as DocumentReference?;
    _reviewFromClient = snapshotData['review_from_client'] as bool?;
    _reviewFromWorker = snapshotData['review_from_worker'] as bool?;
    _finishedTime = snapshotData['finished_time'] as DateTime?;
    _workStatus = snapshotData['work_status'] is ResponseType
        ? snapshotData['work_status']
        : deserializeEnum<ResponseType>(snapshotData['work_status']);
    _workTitle = snapshotData['work_title'] as String?;
    _service = snapshotData['service'] as DocumentReference?;
    _accompleshedDate = snapshotData['accompleshedDate'] as DateTime?;
    _debateStatus = snapshotData['debateStatus'] is DebateStatus
        ? snapshotData['debateStatus']
        : deserializeEnum<DebateStatus>(snapshotData['debateStatus']);
    _debateAuthor = snapshotData['debateAuthor'] as DocumentReference?;
    _debateRefery = snapshotData['debateRefery'] as DocumentReference?;
    _agreedDeadline = castToType<int>(snapshotData['agreed_deadline']);
    _lastPayDay = snapshotData['lastPayDay'] as DateTime?;
    _dabateMessage = snapshotData['dabateMessage'] as String?;
    _byOffer = snapshotData['byOffer'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('work');

  static Stream<WorkRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkRecord.fromSnapshot(s));

  static Future<WorkRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkRecord.fromSnapshot(s));

  static WorkRecord fromSnapshot(DocumentSnapshot snapshot) => WorkRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWorkRecordData({
  DocumentReference? order,
  DocumentReference? worker,
  DocumentReference? client,
  DateTime? createdTime,
  int? agreedPrice,
  bool? safeDeal,
  DocumentReference? workChat,
  bool? reviewFromClient,
  bool? reviewFromWorker,
  DateTime? finishedTime,
  ResponseType? workStatus,
  String? workTitle,
  DocumentReference? service,
  DateTime? accompleshedDate,
  DebateStatus? debateStatus,
  DocumentReference? debateAuthor,
  DocumentReference? debateRefery,
  int? agreedDeadline,
  DateTime? lastPayDay,
  String? dabateMessage,
  bool? byOffer,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'order': order,
      'worker': worker,
      'client': client,
      'created_time': createdTime,
      'agreed_price': agreedPrice,
      'safe_deal': safeDeal,
      'work_chat': workChat,
      'review_from_client': reviewFromClient,
      'review_from_worker': reviewFromWorker,
      'finished_time': finishedTime,
      'work_status': workStatus,
      'work_title': workTitle,
      'service': service,
      'accompleshedDate': accompleshedDate,
      'debateStatus': debateStatus,
      'debateAuthor': debateAuthor,
      'debateRefery': debateRefery,
      'agreed_deadline': agreedDeadline,
      'lastPayDay': lastPayDay,
      'dabateMessage': dabateMessage,
      'byOffer': byOffer,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkRecordDocumentEquality implements Equality<WorkRecord> {
  const WorkRecordDocumentEquality();

  @override
  bool equals(WorkRecord? e1, WorkRecord? e2) {
    const listEquality = ListEquality();
    return e1?.order == e2?.order &&
        e1?.worker == e2?.worker &&
        e1?.client == e2?.client &&
        listEquality.equals(e1?.historyResponces, e2?.historyResponces) &&
        e1?.createdTime == e2?.createdTime &&
        e1?.agreedPrice == e2?.agreedPrice &&
        e1?.safeDeal == e2?.safeDeal &&
        e1?.workChat == e2?.workChat &&
        e1?.reviewFromClient == e2?.reviewFromClient &&
        e1?.reviewFromWorker == e2?.reviewFromWorker &&
        e1?.finishedTime == e2?.finishedTime &&
        e1?.workStatus == e2?.workStatus &&
        e1?.workTitle == e2?.workTitle &&
        e1?.service == e2?.service &&
        e1?.accompleshedDate == e2?.accompleshedDate &&
        e1?.debateStatus == e2?.debateStatus &&
        e1?.debateAuthor == e2?.debateAuthor &&
        e1?.debateRefery == e2?.debateRefery &&
        e1?.agreedDeadline == e2?.agreedDeadline &&
        e1?.lastPayDay == e2?.lastPayDay &&
        e1?.dabateMessage == e2?.dabateMessage &&
        e1?.byOffer == e2?.byOffer;
  }

  @override
  int hash(WorkRecord? e) => const ListEquality().hash([
        e?.order,
        e?.worker,
        e?.client,
        e?.historyResponces,
        e?.createdTime,
        e?.agreedPrice,
        e?.safeDeal,
        e?.workChat,
        e?.reviewFromClient,
        e?.reviewFromWorker,
        e?.finishedTime,
        e?.workStatus,
        e?.workTitle,
        e?.service,
        e?.accompleshedDate,
        e?.debateStatus,
        e?.debateAuthor,
        e?.debateRefery,
        e?.agreedDeadline,
        e?.lastPayDay,
        e?.dabateMessage,
        e?.byOffer
      ]);

  @override
  bool isValidKey(Object? o) => o is WorkRecord;
}
