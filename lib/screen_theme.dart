//
//  screen_theme.dart
//  boot_strapping
//
//  Created by jimmy on 2021/12/20.
//

class ScreenTheme {
  ///Ipad
  static bool isIpad = false;

  ///小屏手机
  static bool isNarrow = false;

  static double valDouble(double phone, {double? pad, double? narrow}) {
    return (isNarrow && narrow != null)
        ? narrow
        : (isIpad ? (pad ?? phone) : phone);
  }

  static val<T>(T phone, {T? pad, T? narrow}) {
    return (isNarrow && narrow != null)
        ? narrow
        : (isIpad ? (pad ?? phone) : phone);
  }
}
