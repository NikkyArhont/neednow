import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionsRecord extends FirestoreRecord {
  TransactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "whos_transaction" field.
  DocumentReference? _whosTransaction;
  DocumentReference? get whosTransaction => _whosTransaction;
  bool hasWhosTransaction() => _whosTransaction != null;

  // "income" field.
  bool? _income;
  bool get income => _income ?? false;
  bool hasIncome() => _income != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "is_paid" field.
  bool? _isPaid;
  bool get isPaid => _isPaid ?? false;
  bool hasIsPaid() => _isPaid != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "invoiceId" field.
  String? _invoiceId;
  String get invoiceId => _invoiceId ?? '';
  bool hasInvoiceId() => _invoiceId != null;

  void _initializeFields() {
    _whosTransaction = snapshotData['whos_transaction'] as DocumentReference?;
    _income = snapshotData['income'] as bool?;
    _amount = castToType<int>(snapshotData['amount']);
    _isPaid = snapshotData['is_paid'] as bool?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _invoiceId = snapshotData['invoiceId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionsRecord.fromSnapshot(s));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionsRecord.fromSnapshot(s));

  static TransactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionsRecordData({
  DocumentReference? whosTransaction,
  bool? income,
  int? amount,
  bool? isPaid,
  DateTime? timestamp,
  String? status,
  String? invoiceId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'whos_transaction': whosTransaction,
      'income': income,
      'amount': amount,
      'is_paid': isPaid,
      'timestamp': timestamp,
      'status': status,
      'invoiceId': invoiceId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionsRecordDocumentEquality
    implements Equality<TransactionsRecord> {
  const TransactionsRecordDocumentEquality();

  @override
  bool equals(TransactionsRecord? e1, TransactionsRecord? e2) {
    return e1?.whosTransaction == e2?.whosTransaction &&
        e1?.income == e2?.income &&
        e1?.amount == e2?.amount &&
        e1?.isPaid == e2?.isPaid &&
        e1?.timestamp == e2?.timestamp &&
        e1?.status == e2?.status &&
        e1?.invoiceId == e2?.invoiceId;
  }

  @override
  int hash(TransactionsRecord? e) => const ListEquality().hash([
        e?.whosTransaction,
        e?.income,
        e?.amount,
        e?.isPaid,
        e?.timestamp,
        e?.status,
        e?.invoiceId
      ]);

  @override
  bool isValidKey(Object? o) => o is TransactionsRecord;
}
