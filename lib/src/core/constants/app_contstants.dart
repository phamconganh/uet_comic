class RoutePaths {
  static const String Login = 'login';
  static const String Base = '/';
  static const String Chapter = 'chapter';
  static const String Comic = 'comic';
}

class KeyValue {
  dynamic key;
  dynamic value;
  KeyValue({this.key, this.value});
}

enum Age { UNDER_12, FROM_12_TO_18, UPPER_18 }
enum Sort { DESC_VIEW, ASC_VIEW }
enum TypeLogin { GG, FB }
enum StatusLogin { ERROR, SUCCESS, CANCEL }

final List<KeyValue> states = [
  KeyValue(key: 0, value: "Chưa hoàn thành"),
  KeyValue(key: 1, value: "Đã hoàn thành")
];
final List<KeyValue> genders = [
  KeyValue(key: 1, value: "Nữ"),
  KeyValue(key: 0, value: "Nam")
];
final List<KeyValue> ages = [
  KeyValue(key: Age.UNDER_12, value: "Dưới 12 tuổi"),
  KeyValue(key: Age.FROM_12_TO_18, value: "Từ 12 đến 18 tuổi"),
  KeyValue(key: Age.UPPER_18, value: "Trên 18 tuổi")
];
final List<KeyValue> sorts = [
  KeyValue(key: Sort.DESC_VIEW, value: "Lượt xem giảm dần"),
  KeyValue(key: Sort.ASC_VIEW, value: "Lượt xem tăng dần")
];
