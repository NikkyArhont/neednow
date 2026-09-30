import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServicesRecord extends FirestoreRecord {
  ServicesRecord._(
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

  // "responce" field.
  List<DocumentReference>? _responce;
  List<DocumentReference> get responce => _responce ?? const [];
  bool hasResponce() => _responce != null;

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
    _whoCreate = snapshotData['who_create'] as DocumentReference?;
    _whenCreate = snapshotData['when_create'] as DateTime?;
    _status = snapshotData['status'] is JobStatus
        ? snapshotData['status']
        : deserializeEnum<JobStatus>(snapshotData['status']);
    _views = getDataList(snapshotData['views']);
    _responce = getDataList(snapshotData['responce']);
    _category = snapshotData['category'] as DocumentReference?;
    _locationTitle = snapshotData['locationTitle'] as String?;
    _locationPlaceId = snapshotData['locationPlaceId'] as String?;
    _cityPlaceId = snapshotData['cityPlaceId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('services');

  static Stream<ServicesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ServicesRecord.fromSnapshot(s));

  static Future<ServicesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ServicesRecord.fromSnapshot(s));

  static ServicesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ServicesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ServicesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ServicesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ServicesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ServicesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createServicesRecordData({
  LatLng? location,
  bool? isRemote,
  String? title,
  int? price,
  String? description,
  DocumentReference? whoCreate,
  DateTime? whenCreate,
  JobStatus? status,
  DocumentReference? category,
  String? locationTitle,
  String? locationPlaceId,
  String? cityPlaceId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'location': location,
      'is_remote': isRemote,
      'title': title,
      'price': price,
      'description': description,
      'who_create': whoCreate,
      'when_create': whenCreate,
      'status': status,
      'category': category,
      'locationTitle': locationTitle,
      'locationPlaceId': locationPlaceId,
      'cityPlaceId': cityPlaceId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ServicesRecordDocumentEquality implements Equality<ServicesRecord> {
  const ServicesRecordDocumentEquality();

  @override
  bool equals(ServicesRecord? e1, ServicesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.location == e2?.location &&
        e1?.isRemote == e2?.isRemote &&
        e1?.title == e2?.title &&
        e1?.price == e2?.price &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.photo, e2?.photo) &&
        e1?.whoCreate == e2?.whoCreate &&
        e1?.whenCreate == e2?.whenCreate &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.views, e2?.views) &&
        listEquality.equals(e1?.responce, e2?.responce) &&
        e1?.category == e2?.category &&
        e1?.locationTitle == e2?.locationTitle &&
        e1?.locationPlaceId == e2?.locationPlaceId &&
        e1?.cityPlaceId == e2?.cityPlaceId;
  }

  @override
  int hash(ServicesRecord? e) => const ListEquality().hash([
        e?.location,
        e?.isRemote,
        e?.title,
        e?.price,
        e?.description,
        e?.photo,
        e?.whoCreate,
        e?.whenCreate,
        e?.status,
        e?.views,
        e?.responce,
        e?.category,
        e?.locationTitle,
        e?.locationPlaceId,
        e?.cityPlaceId
      ]);

  @override
  bool isValidKey(Object? o) => o is ServicesRecord;
}
