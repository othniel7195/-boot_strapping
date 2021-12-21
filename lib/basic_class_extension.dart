//
//  basic_class_extension.dart
//  boot_strapping
//
//  Created by jimmy on 2021/12/20.
//

import 'package:sprintf/sprintf.dart';

extension DateTimeCN on DateTime {
  String getNowDateCN() {
    var month = sprintf('%02i', [this.month]);
    var day = sprintf('%02i', [this.day]);
    return "$month.$day";
  }

  String getNowWeekdayCN() {
    List<String> weekdays = ["none", "一", "二", "三", "四", "五", "六", "日"];
    return weekdays[weekday];
  }
}
