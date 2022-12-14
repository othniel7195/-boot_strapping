/*
 * @Author: jimmy.zhao
 * @Date: 2022-01-04 14:02:07
 * @LastEditTime: 2022-07-16 00:38:02
 * @LastEditors: jimmy.zhao
 * @Description:  
 * 
 * 
 */
//
//  screen_adapt_widget.dart
//  boot_strapping
//
//  Created by jimmy on 2022/1/4.
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'life_cycle_state.dart';

class SAStatelessWidget extends StatelessWidget {
  final Widget child;
  final Size designSize;
  final Size deviceSize;
  final Orientation orientation;
  final bool needLayout;
  const SAStatelessWidget(
      {Key? key,
      required this.child,
      required this.designSize,
      required this.deviceSize,
      required this.orientation,
      this.needLayout = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (needLayout) {
      ScreenUtil.init(
        context,
        designSize: designSize,
        minTextAdapt: false,
      );
    }

    return child;
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
  @protected
  bool needLayout();

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (needLayout()) {
      ScreenUtil.init(
        context,
        designSize: designSize(),
        minTextAdapt: false,
      );
    }

    return child(context: context);
  }
}

abstract class SALifecycleStatefulState<T extends StatefulWidget>
    extends LifecycleState<T> {
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
  @protected
  bool needLayout();

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (needLayout()) {
      ScreenUtil.init(
        context,
        designSize: designSize(),
        minTextAdapt: false,
      );
    }

    return child(context: context);
  }
}
