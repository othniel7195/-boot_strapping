//
//  screen_adapt_widget.dart
//  boot_strapping
//
//  Created by jimmy on 2022/1/4.
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SAStatelessWidget extends StatelessWidget {
  final Widget child;
  final Size designSize;
  const SAStatelessWidget(
      {Key? key, required this.child, required this.designSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: false, designSize: designSize, builder: () => child);
  }
}

abstract class SAStatefulState<T extends StatefulWidget> extends State<T> {
  @protected
  Size designSize();
  @protected
  Orientation orientation();
  @protected
  Widget child({required BuildContext context});
  @protected
  double deviceMaxWidth();
  @protected
  double deviceMaxHeight();

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: deviceMaxWidth(), maxHeight: deviceMaxHeight()),
        designSize: designSize(),
        minTextAdapt: false,
        orientation: orientation());
    return child(context: context);
  }
}
