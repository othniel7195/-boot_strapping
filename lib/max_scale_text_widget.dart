//
//  max_scale_text_widget.dart
//  boot_strapping
//
//  Created by jimmy on 2021/12/20.
//

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class MaxScaleTextWidget extends StatelessWidget {
  final double max;
  final Widget child;
  const MaxScaleTextWidget({Key? key, this.max = 1.2, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var scale = math.min(max, data.textScaleFactor);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: scale), child: child);
  }
}
