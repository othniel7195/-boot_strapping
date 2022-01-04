//
//  screen_adapt_widget.dart
//  boot_strapping
//
//  Created by jimmy on 2022/1/4.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SAStatelessWidget extends StatelessWidget {
  final Widget child;
  final Size designSize;
  const SAStatelessWidget(
      {Key? key, required this.child, required this.designSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(minTextAdapt: false, builder: () => child);
  }
}

class SAStatefulState<T extends StatefulWidget> extends State<T> {
  final Widget _child;
  final Size _designSize;
  final Orientation _orientation;
  SAStatefulState(
      {required Widget child,
      required Size designSize,
      required Orientation orientation})
      : _child = child,
        _designSize = designSize,
        _orientation = orientation;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: _designSize,
        minTextAdapt: false,
        orientation: _orientation);
    return _child;
  }
}
