// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateJobDataStruct extends FFFirebaseStruct {
  CreateJobDataStruct({
    String? locationTitle,
    String? placeId,
    LatLng? locationLatLng,
    bool? isRemote,
    String? title,
    DocumentReference? category,
    int? price,
    int? deadline,
    String? description,
    List<String>? photo,
    String? note,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _locationTitle = locationTitle,
        _placeId = placeId,
        _locationLatLng = locationLatLng,
        _isRemote = isRemote,
        _title = title,
        _category = category,
        _price = price,
        _deadline = deadline,
        _description = description,
        _photo = photo,
        _note = note,
        super(firestoreUtilData);

  // "locationTitle" field.
  String? _locationTitle;
  String get locationTitle => _locationTitle ?? '';
  set locationTitle(String? val) => _locationTitle = val;

  bool hasLocationTitle() => _locationTitle != null;

  // "place_id" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  set placeId(String? val) => _placeId = val;

  bool hasPlaceId() => _placeId != null;

  // "locationLatLng" field.
  LatLng? _locationLatLng;
  LatLng? get locationLatLng => _locationLatLng;
  set locationLatLng(LatLng? val) => _locationLatLng = val;

  bool hasLocationLatLng() => _locationLatLng != null;

  // "isRemote" field.
  bool? _isRemote;
  bool get isRemote => _isRemote ?? false;
  set isRemote(bool? val) => _isRemote = val;

  bool hasIsRemote() => _isRemote != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "category" field.
  DocumentReference? _category;
  DocumentReference? get category => _category;
  set category(DocumentReference? val) => _category = val;

  bool hasCategory() => _category != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "deadline" field.
  int? _deadline;
  int get deadline => _deadline ?? 0;
  set deadline(int? val) => _deadline = val;

  void incrementDeadline(int amount) => deadline = deadline + amount;

  bool hasDeadline() => _deadline != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "photo" field.
  List<String>? _photo;
  List<String> get photo => _photo ?? const [];
  set photo(List<String>? val) => _photo = val;

  void updatePhoto(Function(List<String>) updateFn) {
    updateFn(_photo ??= []);
  }

  bool hasPhoto() => _photo != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  static CreateJobDataStruct fromMap(Map<String, dynamic> data) =>
      CreateJobDataStruct(
        locationTitle: data['locationTitle'] as String?,
        placeId: data['place_id'] as String?,
        locationLatLng: data['locationLatLng'] as LatLng?,
        isRemote: data['isRemote'] as bool?,
        title: data['title'] as String?,
        category: data['category'] as DocumentReference?,
        price: castToType<int>(data['price']),
        deadline: castToType<int>(data['deadline']),
        description: data['description'] as String?,
        photo: getDataList(data['photo']),
        note: data['note'] as String?,
      );

  static CreateJobDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateJobDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'locationTitle': _locationTitle,
        'place_id': _placeId,
        'locationLatLng': _locationLatLng,
        'isRemote': _isRemote,
        'title': _title,
        'category': _category,
        'price': _price,
        'deadline': _deadline,
        'description': _description,
        'photo': _photo,
        'note': _note,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'locationTitle': serializeParam(
          _locationTitle,
          ParamType.String,
        ),
        'place_id': serializeParam(
          _placeId,
          ParamType.String,
        ),
        'locationLatLng': serializeParam(
          _locationLatLng,
          ParamType.LatLng,
        ),
        'isRemote': serializeParam(
          _isRemote,
          ParamType.bool,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.DocumentReference,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'deadline': serializeParam(
          _deadline,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'photo': serializeParam(
          _photo,
          ParamType.String,
          isList: true,
        ),
        'note': serializeParam(
          _note,
          ParamType.String,
        ),
      }.withoutNulls;

  static CreateJobDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreateJobDataStruct(
        locationTitle: deserializeParam(
          data['locationTitle'],
          ParamType.String,
          false,
        ),
        placeId: deserializeParam(
          data['place_id'],
          ParamType.String,
          false,
        ),
        locationLatLng: deserializeParam(
          data['locationLatLng'],
          ParamType.LatLng,
          false,
        ),
        isRemote: deserializeParam(
          data['isRemote'],
          ParamType.bool,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['category'],
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        deadline: deserializeParam(
          data['deadline'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        photo: deserializeParam<String>(
          data['photo'],
          ParamType.String,
          true,
        ),
        note: deserializeParam(
          data['note'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CreateJobDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CreateJobDataStruct &&
        locationTitle == other.locationTitle &&
        placeId == other.placeId &&
        locationLatLng == other.locationLatLng &&
        isRemote == other.isRemote &&
        title == other.title &&
        category == other.category &&
        price == other.price &&
        deadline == other.deadline &&
        description == other.description &&
        listEquality.equals(photo, other.photo) &&
        note == other.note;
  }

  @override
  int get hashCode => const ListEquality().hash([
        locationTitle,
        placeId,
        locationLatLng,
        isRemote,
        title,
        category,
        price,
        deadline,
        description,
        photo,
        note
      ]);
}

CreateJobDataStruct createCreateJobDataStruct({
  String? locationTitle,
  String? placeId,
  LatLng? locationLatLng,
  bool? isRemote,
  String? title,
  DocumentReference? category,
  int? price,
  int? deadline,
  String? description,
  String? note,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CreateJobDataStruct(
      locationTitle: locationTitle,
      placeId: placeId,
      locationLatLng: locationLatLng,
      isRemote: isRemote,
      title: title,
      category: category,
      price: price,
      deadline: deadline,
      description: description,
      note: note,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CreateJobDataStruct? updateCreateJobDataStruct(
  CreateJobDataStruct? createJobData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    createJobData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCreateJobDataStructData(
  Map<String, dynamic> firestoreData,
  CreateJobDataStruct? createJobData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (createJobData == null) {
    return;
  }
  if (createJobData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && createJobData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final createJobDataData =
      getCreateJobDataFirestoreData(createJobData, forFieldValue);
  final nestedData =
      createJobDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = createJobData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCreateJobDataFirestoreData(
  CreateJobDataStruct? createJobData, [
  bool forFieldValue = false,
]) {
  if (createJobData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(createJobData.toMap());

  // Add any Firestore field values
  createJobData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCreateJobDataListFirestoreData(
  List<CreateJobDataStruct>? createJobDatas,
) =>
    createJobDatas
        ?.map((e) => getCreateJobDataFirestoreData(e, true))
        .toList() ??
    [];
