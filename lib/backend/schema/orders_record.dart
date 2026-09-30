import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "is_remote" field.
  bool? _isRemote;
  bool get isRemote => _isRemote ?? false;
  bool hasIsRemote() => _isRemote != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "photo" field.
  List<String>? _photo;
  List<String> get photo => _photo ?? const [];
  bool hasPhoto() => _photo != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "who_create" field.
  DocumentReference? _whoCreate;
  DocumentReference? get whoCreate => _whoCreate;
  bool hasWhoCreate() => _whoCreate != null;

  // "when_create" field.
  DateTime? _whenCreate;
  DateTime? get whenCreate => _whenCreate;
  bool hasWhenCreate() => _whenCreate != null;

  // "status" field.
  JobStatus? _status;
  JobStatus? get status => _status;
  bool hasStatus() => _status != null;

  // "views" field.
  List<DocumentReference>? _views;
  List<DocumentReference> get views => _views ?? const [];
  bool hasViews() => _views != null;

  // "responces" field.
  List<DocumentReference>? _responces;
  List<DocumentReference> get responces => _responces ?? const [];
  bool hasResponces() => _responces != null;

  // "category" field.
  DocumentReference? _category;
  DocumentReference? get category => _category;
  bool hasCategory() => _category != null;

  // "locationTitle" field.
  String? _locationTitle;
  String get locationTitle => _locationTitle ?? '';
  bool hasLocationTitle() => _locationTitle != null;

  // "locationPlaceId" field.
  String? _locationPlaceId;
  String get locationPlaceId => _locationPlaceId ?? '';
  bool hasLocationPlaceId() => _locationPlaceId != null;

  // "deadLine" field.
  int? _deadLine;
  int get deadLine => _deadLine ?? 0;
  bool hasDeadLine() => _deadLine != null;

  // "cityPlaceId" field.
  String? _cityPlaceId;
  String get cityPlaceId => _cityPlaceId ?? '';
  bool hasCityPlaceId() => _cityPlaceId != null;

  void _initializeFields() {
    _location = snapshotData['location'] as LatLng?;
    _isRemote = snapshotData['is_remote'] as bool?;
    _title = snapshotData['title'] as String?;
    _price = castToType<int>(snapshotData['price']);
    _description = snapshotData['description'] as String?;
    _photo = getDataList(snapshotData['photo']);
    _note = snapshotData['note'] as String?;
    _whoCreate = snapshotData['who_create'] as DocumentReference?;
    _whenCreate = snapshotData['when_create'] as DateTime?;
    _status = snapshotData['status'] is JobStatus
        ? snapshotData['status']
        : deserializeEnum<JobStatus>(snapshotData['status']);
    _views = getDataList(snapshotData['views']);
    _responces = getDataList(snapshotData['responces']);
    _category = snapshotData['category'] as DocumentReference?;
    _locationTitle = snapshotData['locationTitle'] as String?;
    _locationPlaceId = snapshotData['locationPlaceId'] as String?;
    _deadLine = castToType<int>(snapshotData['deadLine']);
    _cityPlaceId = snapshotData['cityPlaceId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  LatLng? location,
  bool? isRemote,
  String? title,
  int? price,
  String? description,
  String? note,
  DocumentReference? whoCreate,
  DateTime? whenCreate,
  JobStatus? status,
  DocumentReference? category,
  String? locationTitle,
  String? locationPlaceId,
  int? deadLine,
  String? cityPlaceId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'location': location,
      'is_remote': isRemote,
      'title': title,
      'price': price,
      'description': description,
      'note': note,
      'who_create': whoCreate,
      'when_create': whenCreate,
      'status': status,
      'category': category,
      'locationTitle': locationTitle,
      'locationPlaceId': locationPlaceId,
      'deadLine': deadLine,
      'cityPlaceId': cityPlaceId,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.location == e2?.location &&
        e1?.isRemote == e2?.isRemote &&
        e1?.title == e2?.title &&
        e1?.price == e2?.price &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.photo, e2?.photo) &&
        e1?.note == e2?.note &&
        e1?.whoCreate == e2?.whoCreate &&
        e1?.whenCreate == e2?.whenCreate &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.views, e2?.views) &&
        listEquality.equals(e1?.responces, e2?.responces) &&
        e1?.category == e2?.category &&
        e1?.locationTitle == e2?.locationTitle &&
        e1?.locationPlaceId == e2?.locationPlaceId &&
        e1?.deadLine == e2?.deadLine &&
        e1?.cityPlaceId == e2?.cityPlaceId;
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.location,
        e?.isRemote,
        e?.title,
        e?.price,
        e?.description,
        e?.photo,
        e?.note,
        e?.whoCreate,
        e?.whenCreate,
        e?.status,
        e?.views,
        e?.responces,
        e?.category,
        e?.locationTitle,
        e?.locationPlaceId,
        e?.deadLine,
        e?.cityPlaceId
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
