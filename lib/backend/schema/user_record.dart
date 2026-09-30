import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "adress" field.
  LatLng? _adress;
  LatLng? get adress => _adress;
  bool hasAdress() => _adress != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "reviews" field.
  List<DocumentReference>? _reviews;
  List<DocumentReference> get reviews => _reviews ?? const [];
  bool hasReviews() => _reviews != null;

  // "achivments" field.
  List<DocumentReference>? _achivments;
  List<DocumentReference> get achivments => _achivments ?? const [];
  bool hasAchivments() => _achivments != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "chats" field.
  List<DocumentReference>? _chats;
  List<DocumentReference> get chats => _chats ?? const [];
  bool hasChats() => _chats != null;

  // "balance" field.
  int? _balance;
  int get balance => _balance ?? 0;
  bool hasBalance() => _balance != null;

  // "transactions" field.
  List<DocumentReference>? _transactions;
  List<DocumentReference> get transactions => _transactions ?? const [];
  bool hasTransactions() => _transactions != null;

  // "tasks" field.
  Tasks? _tasks;
  Tasks? get tasks => _tasks;
  bool hasTasks() => _tasks != null;

  // "my_services" field.
  List<DocumentReference>? _myServices;
  List<DocumentReference> get myServices => _myServices ?? const [];
  bool hasMyServices() => _myServices != null;

  // "my_orders" field.
  List<DocumentReference>? _myOrders;
  List<DocumentReference> get myOrders => _myOrders ?? const [];
  bool hasMyOrders() => _myOrders != null;

  // "my_works" field.
  List<DocumentReference>? _myWorks;
  List<DocumentReference> get myWorks => _myWorks ?? const [];
  bool hasMyWorks() => _myWorks != null;

  // "essence" field.
  UserStatus? _essence;
  UserStatus? get essence => _essence;
  bool hasEssence() => _essence != null;

  // "myNotifications" field.
  List<DocumentReference>? _myNotifications;
  List<DocumentReference> get myNotifications => _myNotifications ?? const [];
  bool hasMyNotifications() => _myNotifications != null;

  // "hasNewNot" field.
  bool? _hasNewNot;
  bool get hasNewNot => _hasNewNot ?? false;
  bool hasHasNewNot() => _hasNewNot != null;

  // "last_achivment" field.
  String? _lastAchivment;
  String get lastAchivment => _lastAchivment ?? '';
  bool hasLastAchivment() => _lastAchivment != null;

  // "isWorker" field.
  bool? _isWorker;
  bool get isWorker => _isWorker ?? false;
  bool hasIsWorker() => _isWorker != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "cityPlaceId" field.
  String? _cityPlaceId;
  String get cityPlaceId => _cityPlaceId ?? '';
  bool hasCityPlaceId() => _cityPlaceId != null;

  // "KYCStatus" field.
  KycStatus? _kYCStatus;
  KycStatus? get kYCStatus => _kYCStatus;
  bool hasKYCStatus() => _kYCStatus != null;

  // "KYCimage" field.
  List<String>? _kYCimage;
  List<String> get kYCimage => _kYCimage ?? const [];
  bool hasKYCimage() => _kYCimage != null;

  // "KYCReport" field.
  String? _kYCReport;
  String get kYCReport => _kYCReport ?? '';
  bool hasKYCReport() => _kYCReport != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _adress = snapshotData['adress'] as LatLng?;
    _rating = castToType<double>(snapshotData['rating']);
    _reviews = getDataList(snapshotData['reviews']);
    _achivments = getDataList(snapshotData['achivments']);
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _chats = getDataList(snapshotData['chats']);
    _balance = castToType<int>(snapshotData['balance']);
    _transactions = getDataList(snapshotData['transactions']);
    _tasks = snapshotData['tasks'] is Tasks
        ? snapshotData['tasks']
        : deserializeEnum<Tasks>(snapshotData['tasks']);
    _myServices = getDataList(snapshotData['my_services']);
    _myOrders = getDataList(snapshotData['my_orders']);
    _myWorks = getDataList(snapshotData['my_works']);
    _essence = snapshotData['essence'] is UserStatus
        ? snapshotData['essence']
        : deserializeEnum<UserStatus>(snapshotData['essence']);
    _myNotifications = getDataList(snapshotData['myNotifications']);
    _hasNewNot = snapshotData['hasNewNot'] as bool?;
    _lastAchivment = snapshotData['last_achivment'] as String?;
    _isWorker = snapshotData['isWorker'] as bool?;
    _city = snapshotData['city'] as String?;
    _cityPlaceId = snapshotData['cityPlaceId'] as String?;
    _kYCStatus = snapshotData['KYCStatus'] is KycStatus
        ? snapshotData['KYCStatus']
        : deserializeEnum<KycStatus>(snapshotData['KYCStatus']);
    _kYCimage = getDataList(snapshotData['KYCimage']);
    _kYCReport = snapshotData['KYCReport'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  LatLng? adress,
  double? rating,
  DateTime? lastActiveTime,
  int? balance,
  Tasks? tasks,
  UserStatus? essence,
  bool? hasNewNot,
  String? lastAchivment,
  bool? isWorker,
  String? city,
  String? cityPlaceId,
  KycStatus? kYCStatus,
  String? kYCReport,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'adress': adress,
      'rating': rating,
      'last_active_time': lastActiveTime,
      'balance': balance,
      'tasks': tasks,
      'essence': essence,
      'hasNewNot': hasNewNot,
      'last_achivment': lastAchivment,
      'isWorker': isWorker,
      'city': city,
      'cityPlaceId': cityPlaceId,
      'KYCStatus': kYCStatus,
      'KYCReport': kYCReport,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.adress == e2?.adress &&
        e1?.rating == e2?.rating &&
        listEquality.equals(e1?.reviews, e2?.reviews) &&
        listEquality.equals(e1?.achivments, e2?.achivments) &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        listEquality.equals(e1?.chats, e2?.chats) &&
        e1?.balance == e2?.balance &&
        listEquality.equals(e1?.transactions, e2?.transactions) &&
        e1?.tasks == e2?.tasks &&
        listEquality.equals(e1?.myServices, e2?.myServices) &&
        listEquality.equals(e1?.myOrders, e2?.myOrders) &&
        listEquality.equals(e1?.myWorks, e2?.myWorks) &&
        e1?.essence == e2?.essence &&
        listEquality.equals(e1?.myNotifications, e2?.myNotifications) &&
        e1?.hasNewNot == e2?.hasNewNot &&
        e1?.lastAchivment == e2?.lastAchivment &&
        e1?.isWorker == e2?.isWorker &&
        e1?.city == e2?.city &&
        e1?.cityPlaceId == e2?.cityPlaceId &&
        e1?.kYCStatus == e2?.kYCStatus &&
        listEquality.equals(e1?.kYCimage, e2?.kYCimage) &&
        e1?.kYCReport == e2?.kYCReport;
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.adress,
        e?.rating,
        e?.reviews,
        e?.achivments,
        e?.lastActiveTime,
        e?.chats,
        e?.balance,
        e?.transactions,
        e?.tasks,
        e?.myServices,
        e?.myOrders,
        e?.myWorks,
        e?.essence,
        e?.myNotifications,
        e?.hasNewNot,
        e?.lastAchivment,
        e?.isWorker,
        e?.city,
        e?.cityPlaceId,
        e?.kYCStatus,
        e?.kYCimage,
        e?.kYCReport
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}
