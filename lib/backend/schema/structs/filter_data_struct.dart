// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilterDataStruct extends FFFirebaseStruct {
  FilterDataStruct({
    LatLng? userPoint,
    int? minPrice,
    int? maxPrice,
    String? cityPlaceId,
    List<DocumentReference>? categories,
    double? locationRadius,
    String? cityTitle,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userPoint = userPoint,
        _minPrice = minPrice,
        _maxPrice = maxPrice,
        _cityPlaceId = cityPlaceId,
        _categories = categories,
        _locationRadius = locationRadius,
        _cityTitle = cityTitle,
        super(firestoreUtilData);

  // "userPoint" field.
  LatLng? _userPoint;
  LatLng? get userPoint => _userPoint;
  set userPoint(LatLng? val) => _userPoint = val;

  bool hasUserPoint() => _userPoint != null;

  // "minPrice" field.
  int? _minPrice;
  int get minPrice => _minPrice ?? 0;
  set minPrice(int? val) => _minPrice = val;

  void incrementMinPrice(int amount) => minPrice = minPrice + amount;

  bool hasMinPrice() => _minPrice != null;

  // "maxPrice" field.
  int? _maxPrice;
  int get maxPrice => _maxPrice ?? 1000000;
  set maxPrice(int? val) => _maxPrice = val;

  void incrementMaxPrice(int amount) => maxPrice = maxPrice + amount;

  bool hasMaxPrice() => _maxPrice != null;

  // "cityPlaceId" field.
  String? _cityPlaceId;
  String get cityPlaceId => _cityPlaceId ?? '';
  set cityPlaceId(String? val) => _cityPlaceId = val;

  bool hasCityPlaceId() => _cityPlaceId != null;

  // "categories" field.
  List<DocumentReference>? _categories;
  List<DocumentReference> get categories => _categories ?? const [];
  set categories(List<DocumentReference>? val) => _categories = val;

  void updateCategories(Function(List<DocumentReference>) updateFn) {
    updateFn(_categories ??= []);
  }

  bool hasCategories() => _categories != null;

  // "locationRadius" field.
  double? _locationRadius;
  double get locationRadius => _locationRadius ?? 0.0;
  set locationRadius(double? val) => _locationRadius = val;

  void incrementLocationRadius(double amount) =>
      locationRadius = locationRadius + amount;

  bool hasLocationRadius() => _locationRadius != null;

  // "CityTitle" field.
  String? _cityTitle;
  String get cityTitle => _cityTitle ?? '';
  set cityTitle(String? val) => _cityTitle = val;

  bool hasCityTitle() => _cityTitle != null;

  static FilterDataStruct fromMap(Map<String, dynamic> data) =>
      FilterDataStruct(
        userPoint: data['userPoint'] as LatLng?,
        minPrice: castToType<int>(data['minPrice']),
        maxPrice: castToType<int>(data['maxPrice']),
        cityPlaceId: data['cityPlaceId'] as String?,
        categories: getDataList(data['categories']),
        locationRadius: castToType<double>(data['locationRadius']),
        cityTitle: data['CityTitle'] as String?,
      );

  static FilterDataStruct? maybeFromMap(dynamic data) => data is Map
      ? FilterDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userPoint': _userPoint,
        'minPrice': _minPrice,
        'maxPrice': _maxPrice,
        'cityPlaceId': _cityPlaceId,
        'categories': _categories,
        'locationRadius': _locationRadius,
        'CityTitle': _cityTitle,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userPoint': serializeParam(
          _userPoint,
          ParamType.LatLng,
        ),
        'minPrice': serializeParam(
          _minPrice,
          ParamType.int,
        ),
        'maxPrice': serializeParam(
          _maxPrice,
          ParamType.int,
        ),
        'cityPlaceId': serializeParam(
          _cityPlaceId,
          ParamType.String,
        ),
        'categories': serializeParam(
          _categories,
          ParamType.DocumentReference,
          isList: true,
        ),
        'locationRadius': serializeParam(
          _locationRadius,
          ParamType.double,
        ),
        'CityTitle': serializeParam(
          _cityTitle,
          ParamType.String,
        ),
      }.withoutNulls;

  static FilterDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FilterDataStruct(
        userPoint: deserializeParam(
          data['userPoint'],
          ParamType.LatLng,
          false,
        ),
        minPrice: deserializeParam(
          data['minPrice'],
          ParamType.int,
          false,
        ),
        maxPrice: deserializeParam(
          data['maxPrice'],
          ParamType.int,
          false,
        ),
        cityPlaceId: deserializeParam(
          data['cityPlaceId'],
          ParamType.String,
          false,
        ),
        categories: deserializeParam<DocumentReference>(
          data['categories'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['category'],
        ),
        locationRadius: deserializeParam(
          data['locationRadius'],
          ParamType.double,
          false,
        ),
        cityTitle: deserializeParam(
          data['CityTitle'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FilterDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FilterDataStruct &&
        userPoint == other.userPoint &&
        minPrice == other.minPrice &&
        maxPrice == other.maxPrice &&
        cityPlaceId == other.cityPlaceId &&
        listEquality.equals(categories, other.categories) &&
        locationRadius == other.locationRadius &&
        cityTitle == other.cityTitle;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userPoint,
        minPrice,
        maxPrice,
        cityPlaceId,
        categories,
        locationRadius,
        cityTitle
      ]);
}

FilterDataStruct createFilterDataStruct({
  LatLng? userPoint,
  int? minPrice,
  int? maxPrice,
  String? cityPlaceId,
  double? locationRadius,
  String? cityTitle,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FilterDataStruct(
      userPoint: userPoint,
      minPrice: minPrice,
      maxPrice: maxPrice,
      cityPlaceId: cityPlaceId,
      locationRadius: locationRadius,
      cityTitle: cityTitle,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FilterDataStruct? updateFilterDataStruct(
  FilterDataStruct? filterData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    filterData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFilterDataStructData(
  Map<String, dynamic> firestoreData,
  FilterDataStruct? filterData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (filterData == null) {
    return;
  }
  if (filterData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && filterData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final filterDataData = getFilterDataFirestoreData(filterData, forFieldValue);
  final nestedData = filterDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = filterData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFilterDataFirestoreData(
  FilterDataStruct? filterData, [
  bool forFieldValue = false,
]) {
  if (filterData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(filterData.toMap());

  // Add any Firestore field values
  filterData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFilterDataListFirestoreData(
  List<FilterDataStruct>? filterDatas,
) =>
    filterDatas?.map((e) => getFilterDataFirestoreData(e, true)).toList() ?? [];
