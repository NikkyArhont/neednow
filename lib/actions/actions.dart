import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future createService(BuildContext context) async {
  ServicesRecord? newService;

  var servicesRecordReference = ServicesRecord.collection.doc();
  await servicesRecordReference.set({
    ...createServicesRecordData(
      location: FFAppState().newJobCreate.locationLatLng,
      isRemote: FFAppState().newJobCreate.isRemote,
      title: FFAppState().newJobCreate.title,
      price: FFAppState().newJobCreate.price,
      description: FFAppState().newJobCreate.description,
      whoCreate: currentUserReference,
      whenCreate: getCurrentTimestamp,
      status: JobStatus.hide,
      category: FFAppState().newJobCreate.category,
      locationTitle: FFAppState().newJobCreate.locationTitle,
      locationPlaceId: FFAppState().newJobCreate.placeId,
    ),
    ...mapToFirestore(
      {
        'photo': FFAppState().newJobCreate.photo,
      },
    ),
  });
  newService = ServicesRecord.getDocumentFromData({
    ...createServicesRecordData(
      location: FFAppState().newJobCreate.locationLatLng,
      isRemote: FFAppState().newJobCreate.isRemote,
      title: FFAppState().newJobCreate.title,
      price: FFAppState().newJobCreate.price,
      description: FFAppState().newJobCreate.description,
      whoCreate: currentUserReference,
      whenCreate: getCurrentTimestamp,
      status: JobStatus.hide,
      category: FFAppState().newJobCreate.category,
      locationTitle: FFAppState().newJobCreate.locationTitle,
      locationPlaceId: FFAppState().newJobCreate.placeId,
    ),
    ...mapToFirestore(
      {
        'photo': FFAppState().newJobCreate.photo,
      },
    ),
  }, servicesRecordReference);

  await currentUserReference!.update({
    ...mapToFirestore(
      {
        'my_services': FieldValue.arrayUnion([newService?.reference]),
      },
    ),
  });
  FFAppState().newJobCreate = CreateJobDataStruct();
}

Future terminateKYC(BuildContext context) async {
  while ((currentUserDocument?.myServices?.toList() ?? []).isNotEmpty) {
    await (currentUserDocument?.myServices?.toList() ?? [])
        .lastOrNull!
        .delete();
  }

  await currentUserReference!.update({
    ...createUserRecordData(
      kYCStatus: KycStatus.not_start,
    ),
    ...mapToFirestore(
      {
        'KYCimage': FieldValue.delete(),
      },
    ),
  });

  context.goNamed(MainWidget.routeName);
}

Future createOrder(BuildContext context) async {
  OrdersRecord? newOrder;

  var ordersRecordReference = OrdersRecord.collection.doc();
  await ordersRecordReference.set({
    ...createOrdersRecordData(
      location: FFAppState().newJobCreate.locationLatLng,
      isRemote: FFAppState().newJobCreate.isRemote,
      title: FFAppState().newJobCreate.title,
      price: FFAppState().newJobCreate.price,
      description: FFAppState().newJobCreate.description,
      whoCreate: currentUserReference,
      whenCreate: getCurrentTimestamp,
      status: JobStatus.hide,
      category: FFAppState().newJobCreate.category,
      locationTitle: FFAppState().newJobCreate.locationTitle,
      locationPlaceId: FFAppState().newJobCreate.placeId,
      note: FFAppState().newJobCreate.note,
      deadLine: FFAppState().newJobCreate.deadline,
    ),
    ...mapToFirestore(
      {
        'photo': FFAppState().newJobCreate.photo,
      },
    ),
  });
  newOrder = OrdersRecord.getDocumentFromData({
    ...createOrdersRecordData(
      location: FFAppState().newJobCreate.locationLatLng,
      isRemote: FFAppState().newJobCreate.isRemote,
      title: FFAppState().newJobCreate.title,
      price: FFAppState().newJobCreate.price,
      description: FFAppState().newJobCreate.description,
      whoCreate: currentUserReference,
      whenCreate: getCurrentTimestamp,
      status: JobStatus.hide,
      category: FFAppState().newJobCreate.category,
      locationTitle: FFAppState().newJobCreate.locationTitle,
      locationPlaceId: FFAppState().newJobCreate.placeId,
      note: FFAppState().newJobCreate.note,
      deadLine: FFAppState().newJobCreate.deadline,
    ),
    ...mapToFirestore(
      {
        'photo': FFAppState().newJobCreate.photo,
      },
    ),
  }, ordersRecordReference);

  await currentUserReference!.update({
    ...mapToFirestore(
      {
        'my_orders': FieldValue.arrayUnion([newOrder?.reference]),
      },
    ),
  });
  FFAppState().newJobCreate = CreateJobDataStruct();
}

Future pushNewMassage(BuildContext context) async {}

Future newMessPush(BuildContext context) async {}
