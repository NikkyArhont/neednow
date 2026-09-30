import 'package:collection/collection.dart';

enum CurrentPage {
  main,
  orders,
  chats,
  profile,
}

enum ResponseType {
  offer,
  confirmed,
  denied,
  dispute,
  done,
  workComplete,
}

enum Tasks {
  all,
  debate,
  category,
  none,
}

enum KycStatus {
  not_start,
  check,
  denied,
  complite,
}

enum UserStatus {
  emploee,
  admin,
  user,
}

enum JobStatus {
  haveOffer,
  published,
  hide,
}

enum OfferType {
  formClient,
  fromWorker,
  agreed,
  denied,
}

enum DebateStatus {
  open,
  client,
  worker,
  separate,
  notStart,
}

enum AdminMenu {
  profile,
  emploees,
  category,
  users,
  chats,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (CurrentPage):
      return CurrentPage.values.deserialize(value) as T?;
    case (ResponseType):
      return ResponseType.values.deserialize(value) as T?;
    case (Tasks):
      return Tasks.values.deserialize(value) as T?;
    case (KycStatus):
      return KycStatus.values.deserialize(value) as T?;
    case (UserStatus):
      return UserStatus.values.deserialize(value) as T?;
    case (JobStatus):
      return JobStatus.values.deserialize(value) as T?;
    case (OfferType):
      return OfferType.values.deserialize(value) as T?;
    case (DebateStatus):
      return DebateStatus.values.deserialize(value) as T?;
    case (AdminMenu):
      return AdminMenu.values.deserialize(value) as T?;
    default:
      return null;
  }
}
