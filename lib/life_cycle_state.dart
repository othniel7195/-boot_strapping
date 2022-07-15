//
//  life_cycle_state.dart
//  boot_strapping
//
//  Created by jimmy on 2021/12/20.
//

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'my_route_observer.dart';

abstract class Lifecycle {
  /// 用于让子类去实现的初始化方法
  void onCreate() {}

  /// 用于让子类去实现的不可见变为可见时的方法
  void onResume() {}

  ///加载数据
  void onLoadData() {}

  /// 用于让子类去实现的可见变为不可见时调用的方法。pause之前调用的方法
  void onWillPause() {}

  /// 用于让子类去实现的可见变为不可见时调用的方法。
  void onPause() {}

  /// 用于让子类去实现的销毁方法。
  void onDestroy() {}

  /// app切回到后台
  void onBackground() {}

  /// app切回到前台
  void onForeground() {}
}

abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with Lifecycle {
  String tag = T.toString();
  late LifecycleManager lifecycleManager;

  @override
  T get widget => super.widget;

  LifecycleState() {
    lifecycleManager = LifecycleManager(this);
  }

  LifecycleState.fromLifeCycle(this.lifecycleManager);

  log(String log) {
    debugPrint('$tag --> $log');
  }

  @override
  void initState() {
    super.initState();
    lifecycleManager.init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lifecycleManager.initRoute(context);
  }

  @override
  void dispose() {
    lifecycleManager.destroy();
    super.dispose();
  }
}

final MyRouteObserver routeObserver = MyRouteObserver();

class _LifecycleWrap implements Lifecycle {
  List<Lifecycle> array;

  _LifecycleWrap(this.array);

  @override
  void onBackground() {
    for (var e in array) {
      e.onBackground();
    }
  }

  @override
  void onCreate() {
    for (var e in array) {
      e.onCreate();
    }
  }

  @override
  void onDestroy() {
    for (var e in array) {
      e.onDestroy();
    }
  }

  @override
  void onForeground() {
    for (var e in array) {
      e.onForeground();
    }
  }

  @override
  void onLoadData() {
    for (var e in array) {
      e.onLoadData();
    }
  }

  @override
  void onWillPause() {
    for (var e in array) {
      e.onWillPause();
    }
  }

  @override
  void onPause() {
    for (var e in array) {
      e.onPause();
    }
  }

  @override
  void onResume() {
    for (var e in array) {
      e.onResume();
    }
  }
}

class LifecycleManager with WidgetsBindingObserver, RouteAware {
  _LifecycleWrap? _lifecycleWrap;
  late Lifecycle _lifecycle;
  String? pageRouteName;

  LifecycleManager(this._lifecycle, {this.pageRouteName});

  LifecycleManager.fromArray(List<Lifecycle> array, {this.pageRouteName}) {
    _lifecycleWrap = _LifecycleWrap(array);
    _lifecycle = _lifecycleWrap!;
  }

  bool _isTop = true;
  bool onBackground = false;

  StreamSubscription? _subscriptionEvent;

  void init(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  void registerLifecycleListener(Lifecycle lifecycle) {
    if (_lifecycleWrap != null) {
      _lifecycleWrap?.array.add(lifecycle);
    }
  }

  _initialize() {
    _lifecycle.onCreate();
    _lifecycle.onForeground();
    _lifecycle.onResume();
    _lifecycle.onLoadData();
  }

  initRoute(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      var route = ModalRoute.of(context);
      if (route is PageRoute<dynamic>) {
        routeObserver.subscribe(this, route);
      }
    }
  }

  void destroy() {
    _subscriptionEvent?.cancel();
    routeObserver.unsubscribe(this);
    _lifecycle.onDestroy();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (kDebugMode) {
      print("[Lifecycle] state = ${state.toString()}");
    }

    switch (state) {
      case AppLifecycleState.resumed:
        if (_isTop) {
          onBackground = false;
          _lifecycle.onForeground();
          _lifecycle.onResume();
        }
        break;
      case AppLifecycleState.inactive:
        if (_isTop && !onBackground) {
          _lifecycle.onWillPause();
        }
        break;
      case AppLifecycleState.paused:
        if (_isTop) {
          _lifecycle.onBackground();
          onBackground = true;
          _lifecycle.onPause();
        }
        break;
      default:
        break;
    }
  }

  @override
  void didPush() {
    super.didPush();
    _isTop = true;
  }

  @override
  void didPushNext() {
    super.didPushNext();
    _lifecycle.onWillPause();
    _lifecycle.onPause();
    _isTop = false;
  }

  @override
  void didPop() {
    super.didPop();
    _lifecycle.onWillPause();
    _lifecycle.onPause();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _lifecycle.onResume();
    _isTop = true;
  }
}
