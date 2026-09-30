import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

String? firstCharacter(String? fullName) {
  // функция получает строку а возвращает только первый символ

  if (fullName != null && fullName.isNotEmpty) {
    return fullName[0];
  }
  return null;
}

String searchCatTitles(
  List<DownloadCatStruct> listDownloadCat,
  DocumentReference listRefCat,
) {
  // функция получает массив список data Type состоящий из полей title и document referene из коллекции category, и ссылку на документ из коллекции category. На выходе она должна выдавать  title документа коллекции чья ссылка соответствует из массива ссылок
  for (var cat in listDownloadCat) {
    if (cat.refCat == listRefCat) {
      return cat.title;
    }
  }

  return '';
}

DocumentReference? getChoosenCat(
  String? titleCat,
  List<DownloadCatStruct>? docCat,
) {
  // функция получает  строку titleCat, и список data Type состоящий из полей title и document referene, возвращает ссылоку на документ в котором есть соответствующий titleCat
  if (titleCat == null || docCat == null) {
    return null;
  }

  for (var cat in docCat) {
    if (cat.title == titleCat) {
      return cat.refCat;
    }
  }

  return null;
}

int? filterServices(
  List<ServicesRecord>? orders,
  FilterDataStruct? filter,
) {
  /* --- 0. Базовые проверки ------------------------------------------- */
  if (orders == null) return null; // список не передан
  if (orders.isEmpty) return 0; // передан, но пуст
  if (filter == null) return orders.length; // фильтр не задан

  /* --- 1. Подготовка параметров фильтра ------------------------------- */

  //   1.1 Цена
  num? minPrice = filter.minPrice;
  num? maxPrice = filter.maxPrice;
  if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
    // если границы перепутаны, меняем местами
    final t = minPrice;
    minPrice = maxPrice;
    maxPrice = t;
  }

  //   1.2 Категории
  final List<DocumentReference> allowedCats =
      (filter.categories ?? const <DocumentReference>[])
          .whereType<DocumentReference>()
          .toList();

  //   1.3 Гео-фильтр
  final LatLng? userPoint = filter.userPoint;
  final double radiusKm = (filter.locationRadius ?? 10).toDouble();
  final bool useGeo = userPoint != null &&
      radiusKm > 0 &&
      !(userPoint.latitude == 0.0 && userPoint.longitude == 0.0);

  /* --- 2. Вспомогательные проверки ------------------------------------ */

  bool priceMatches(num? price) {
    if (price == null) return false; // у заказа нет цены
    if (minPrice != null && price < minPrice) return false;
    if (maxPrice != null && price > maxPrice) return false;
    return true;
  }

  bool categoryMatches(DocumentReference? cat) {
    if (allowedCats.isEmpty) return true; // фильтр по категориям не задан
    if (cat == null) return false; // у заказа нет категории
    // DocumentReference реализует ==, но добавим path на всякий случай
    return allowedCats.any((c) => c == cat || c.path == cat.path);
  }

  /* --- 3. Основной цикл ----------------------------------------------- */
  int matched = 0;

  for (final order in orders) {
    // 3.1 Цена
    if (!priceMatches(order.price)) continue;

    // 3.2 Категория
    if (!categoryMatches(order.category)) continue;

    // 3.3 Георадиус
    if (useGeo) {
      final inside = degreesToRadians(userPoint!, radiusKm, order.location);
      if (inside != true) continue;
    }

    matched++; // все проверки пройдены
  }

  return matched;
}

List<DownloadCatStruct>? savingCat(List<CategoryRecord>? downloadCat) {
// функция получает список документов коллекции category а на выходе она должна выдать список data type downloadCat в который она попарно запишет title документа и его reference  в поля data type title и refCat соответственно
  if (downloadCat == null) {
    return null;
  }

  List<DownloadCatStruct> result = [];

  for (var category in downloadCat) {
    result.add(
      createDownloadCatStruct(
        title: category.title,
        refCat: category.reference,
      ),
    );
  }

  return result;
}

List<double>? recountRaiting(List<int>? stars) {
  // функция получает список stars значения в нем могут быть только целочесленные от 1 до 5, вернуть функция должна список где первым элементом будет средняя оценка, то есть сумма всех оценок деленная на колличество, а затем доли колличества оценок 5, 4 ,3, 2, и 1. Все возвращаемые значения округлить до двух знаков после запятой
  if (stars == null || stars.isEmpty) {
    return null;
  }

  int totalStars = 0;
  int count5 = 0;
  int count4 = 0;
  int count3 = 0;
  int count2 = 0;
  int count1 = 0;

  for (var star in stars) {
    totalStars += star;
    if (star == 5) {
      count5++;
    } else if (star == 4) {
      count4++;
    } else if (star == 3) {
      count3++;
    } else if (star == 2) {
      count2++;
    } else if (star == 1) {
      count1++;
    }
  }

  double averageRating = totalStars / stars.length;
  double percent5 = (count5 / stars.length);
  double percent4 = (count4 / stars.length);
  double percent3 = (count3 / stars.length);
  double percent2 = (count2 / stars.length);
  double percent1 = (count1 / stars.length);

  return [
    double.parse(averageRating.toStringAsFixed(2)),
    double.parse(percent5.toStringAsFixed(2)),
    double.parse(percent4.toStringAsFixed(2)),
    double.parse(percent3.toStringAsFixed(2)),
    double.parse(percent2.toStringAsFixed(2)),
    double.parse(percent1.toStringAsFixed(2)),
  ];
}

LatLng parsCoordinate(dynamic latlngnJson) {
  // функция принимает json данные latlonJson {   "lat": 45.036035,   "lng": 38.97457060000001 } (Это был примерданных) в которых есть координаты, а возвращать должна тип данных LatLng
  if (latlngnJson != null && latlngnJson is Map<String, dynamic>) {
    double lat = latlngnJson['lat'] ?? 0.0;
    double lng = latlngnJson['lng'] ?? 0.0;
    return LatLng(lat, lng);
  } else {
    return LatLng(0.0, 0.0);
  }
}

int? summBalance(List<int>? listTrans) {
  // функция получает массив чисел listTrans и выдает их сумму
  if (listTrans == null || listTrans.isEmpty) {
    return null;
  }

  int sum = 0;
  for (int num in listTrans) {
    sum += num;
  }

  return sum;
}

DateTime? countFinishedTime(
  DateTime? start,
  int? deadline,
) {
  // функция получает дату start и число deadline, должна вернуть новую дату которая будет через deadline дней от даты start
  if (start == null || deadline == null) {
    return null;
  }

  return start.add(Duration(days: deadline));
}

List<SearchPlaceStruct>? parsPlaces(
  List<String>? city,
  List<String>? placeID,
  List<String>? placeDescription,
) {
// функция будет получать 2 массива строк city и place Id, и должна создать список из data type, куда последовательно впишет элементы из этих двух массивов данные из масива city запишет в поле placeTitle а placeId в placeid
  if (city == null ||
      placeID == null ||
      placeDescription == null ||
      city.length != placeID.length) {
    return null;
  }

  List<SearchPlaceStruct> searchPlaces = [];
  for (int i = 0; i < city.length; i++) {
    searchPlaces.add(SearchPlaceStruct(
        placeTitle: city[i],
        placeId: placeID[i],
        placeDescript: placeDescription[i]));
  }

  return searchPlaces;
}

bool? degreesToRadians(
  LatLng? userC,
  double? radius,
  LatLng? jobC,
) {
  // // функция должна проверить находится ли координата jobC на расстоянии radius в киллометрах  от координат userC. Не используй сторонние библиотеки
  if (userC == null || jobC == null || radius == null || radius < 0) {
    return null;
  }
  double _degreesToRadians(double degrees) => degrees * math.pi / 180;
  const double earthRadius = 6371; // Radius of the Earth in kilometers
  double dLat = _degreesToRadians(jobC.latitude - userC.latitude);
  double dLon = _degreesToRadians(jobC.longitude - userC.longitude);

  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_degreesToRadians(userC.latitude)) *
          math.cos(_degreesToRadians(jobC.latitude)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  double distance = earthRadius * c; // Distance in kilometers

  return distance <= radius;
}

LatLng? reternZeroLoc() {
  // нужна фенкция которая просто возвращает координаты со значением 0, 0
  return const LatLng(0.0, 0.0);
}

int? filterOrders(
  List<OrdersRecord>? orders,
  FilterDataStruct? filter,
) {
  /* --- 0. Базовые проверки ------------------------------------------- */
  if (orders == null) return null; // список не передан
  if (orders.isEmpty) return 0; // передан, но пуст
  if (filter == null) return orders.length; // фильтр не задан

  /* --- 1. Подготовка параметров фильтра ------------------------------- */

  //   1.1 Цена
  num? minPrice = filter.minPrice;
  num? maxPrice = filter.maxPrice;
  if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
    // если границы перепутаны, меняем местами
    final t = minPrice;
    minPrice = maxPrice;
    maxPrice = t;
  }

  //   1.2 Категории
  final List<DocumentReference> allowedCats =
      (filter.categories ?? const <DocumentReference>[])
          .whereType<DocumentReference>()
          .toList();

  //   1.3 Гео-фильтр
  final LatLng? userPoint = filter.userPoint;
  final double radiusKm = (filter.locationRadius ?? 10).toDouble();
  final bool useGeo = userPoint != null &&
      radiusKm > 0 &&
      !(userPoint.latitude == 0.0 && userPoint.longitude == 0.0);

  /* --- 2. Вспомогательные проверки ------------------------------------ */

  bool priceMatches(num? price) {
    if (price == null) return false; // у заказа нет цены
    if (minPrice != null && price < minPrice) return false;
    if (maxPrice != null && price > maxPrice) return false;
    return true;
  }

  bool categoryMatches(DocumentReference? cat) {
    if (allowedCats.isEmpty) return true; // фильтр по категориям не задан
    if (cat == null) return false; // у заказа нет категории
    // DocumentReference реализует ==, но добавим path на всякий случай
    return allowedCats.any((c) => c == cat || c.path == cat.path);
  }

  /* --- 3. Основной цикл ----------------------------------------------- */
  int matched = 0;

  for (final order in orders) {
    // 3.1 Цена
    if (!priceMatches(order.price)) continue;

    // 3.2 Категория
    if (!categoryMatches(order.category)) continue;

    // 3.3 Георадиус
    if (useGeo) {
      final inside = degreesToRadians(userPoint!, radiusKm, order.location);
      if (inside != true) continue;
    }

    matched++; // все проверки пройдены
  }

  return matched;
}
