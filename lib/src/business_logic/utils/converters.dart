
class Converters {
  static DateTime? timestampFromJson(int? time) {
    return time != null ? DateTime.fromMillisecondsSinceEpoch(time) : null;
  }

  static int? timestampToJson(DateTime? dt) {
    return dt?.millisecondsSinceEpoch;
  }
}