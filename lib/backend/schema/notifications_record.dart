import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "whos_notification" field.
  DocumentReference? _whosNotification;
  DocumentReference? get whosNotification => _whosNotification;
  bool hasWhosNotification() => _whosNotification != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "timeStapm" field.
  DateTime? _timeStapm;
  DateTime? get timeStapm => _timeStapm;
  bool hasTimeStapm() => _timeStapm != null;

  // "letter" field.
  String? _letter;
  String get letter => _letter ?? '';
  bool hasLetter() => _letter != null;

  // "unRead" field.
  bool? _unRead;
  bool get unRead => _unRead ?? false;
  bool hasUnRead() => _unRead != null;

  void _initializeFields() {
    _whosNotification = snapshotData['whos_notification'] as DocumentReference?;
    _title = snapshotData['title'] as String?;
    _timeStapm = snapshotData['timeStapm'] as DateTime?;
    _letter = snapshotData['letter'] as String?;
    _unRead = snapshotData['unRead'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  DocumentReference? whosNotification,
  String? title,
  DateTime? timeStapm,
  String? letter,
  bool? unRead,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'whos_notification': whosNotification,
      'title': title,
      'timeStapm': timeStapm,
      'letter': letter,
      'unRead': unRead,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.whosNotification == e2?.whosNotification &&
        e1?.title == e2?.title &&
        e1?.timeStapm == e2?.timeStapm &&
        e1?.letter == e2?.letter &&
        e1?.unRead == e2?.unRead;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash(
      [e?.whosNotification, e?.title, e?.timeStapm, e?.letter, e?.unRead]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
