class DateUtil {
  static String getWeekFromDate(DateTime dateTime) {
    List<String> list = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
    return list[dateTime.weekday - 1];
  }

  static String getWeekFromString(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return getWeekFromDate(dateTime);
  }
}
