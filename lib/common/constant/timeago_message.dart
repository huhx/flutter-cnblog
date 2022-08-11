import 'package:timeago/timeago.dart';

class ZhMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '后';
  @override
  String lessThanOneMinute(int seconds) => '少于一分钟';
  @override
  String aboutAMinute(int minutes) => '1分钟';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String aboutAnHour(int minutes) => '1小时';
  @override
  String hours(int hours) => '$hours小时';
  @override
  String aDay(int hours) => '1天';
  @override
  String days(int days) => '$days日';
  @override
  String aboutAMonth(int days) => '1个月';
  @override
  String months(int months) => '$months月';
  @override
  String aboutAYear(int year) => '1年';
  @override
  String years(int years) => '$years年';
  @override
  String wordSeparator() => '';
}