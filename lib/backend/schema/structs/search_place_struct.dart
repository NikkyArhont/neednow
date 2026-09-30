// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SearchPlaceStruct extends FFFirebaseStruct {
  SearchPlaceStruct({
    String? placeTitle,
    String? placeId,
    String? placeDescript,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _placeTitle = placeTitle,
        _placeId = placeId,
        _placeDescript = placeDescript,
        super(firestoreUtilData);

  // "placeTitle" field.
  String? _placeTitle;
  String get placeTitle => _placeTitle ?? '';
  set placeTitle(String? val) => _placeTitle = val;

  bool hasPlaceTitle() => _placeTitle != null;

  // "placeId" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  set placeId(String? val) => _placeId = val;

  bool hasPlaceId() => _placeId != null;

  // "placeDescript" field.
  String? _placeDescript;
  String get placeDescript => _placeDescript ?? '';
  set placeDescript(String? val) => _placeDescript = val;

  bool hasPlaceDescript() => _placeDescript != null;

  static SearchPlaceStruct fromMap(Map<String, dynamic> data) =>
      SearchPlaceStruct(
        placeTitle: data['placeTitle'] as String?,
        placeId: data['placeId'] as String?,
        placeDescript: data['placeDescript'] as String?,
      );

  static SearchPlaceStruct? maybeFromMap(dynamic data) => data is Map
      ? SearchPlaceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'placeTitle': _placeTitle,
        'placeId': _placeId,
        'placeDescript': _placeDescript,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'placeTitle': serializeParam(
          _placeTitle,
          ParamType.String,
        ),
        'placeId': serializeParam(
          _placeId,
          ParamType.String,
        ),
        'placeDescript': serializeParam(
          _placeDescript,
          ParamType.String,
        ),
      }.withoutNulls;

  static SearchPlaceStruct fromSerializableMap(Map<String, dynamic> data) =>
      SearchPlaceStruct(
        placeTitle: deserializeParam(
          data['placeTitle'],
          ParamType.String,
          false,
        ),
        placeId: deserializeParam(
          data['placeId'],
          ParamType.String,
          false,
        ),
        placeDescript: deserializeParam(
          data['placeDescript'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SearchPlaceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SearchPlaceStruct &&
        placeTitle == other.placeTitle &&
        placeId == other.placeId &&
        placeDescript == other.placeDescript;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([placeTitle, placeId, placeDescript]);
}

SearchPlaceStruct createSearchPlaceStruct({
  String? placeTitle,
  String? placeId,
  String? placeDescript,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SearchPlaceStruct(
      placeTitle: placeTitle,
      placeId: placeId,
      placeDescript: placeDescript,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SearchPlaceStruct? updateSearchPlaceStruct(
  SearchPlaceStruct? searchPlace, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    searchPlace
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSearchPlaceStructData(
  Map<String, dynamic> firestoreData,
  SearchPlaceStruct? searchPlace,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (searchPlace == null) {
    return;
  }
  if (searchPlace.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && searchPlace.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final searchPlaceData =
      getSearchPlaceFirestoreData(searchPlace, forFieldValue);
  final nestedData =
      searchPlaceData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = searchPlace.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSearchPlaceFirestoreData(
  SearchPlaceStruct? searchPlace, [
  bool forFieldValue = false,
]) {
  if (searchPlace == null) {
    return {};
  }
  final firestoreData = mapToFirestore(searchPlace.toMap());

  // Add any Firestore field values
  searchPlace.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSearchPlaceListFirestoreData(
  List<SearchPlaceStruct>? searchPlaces,
) =>
    searchPlaces?.map((e) => getSearchPlaceFirestoreData(e, true)).toList() ??
    [];
