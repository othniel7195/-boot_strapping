//
//  my_route_observer.dart
//  boot_strapping
//
//  Created by jimmy on 2021/12/20.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    if (kDebugMode) {
      print("[FlutterRoute] screenName: $screenName");
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (kDebugMode) {
      if (route is PageRoute) {
        _sendScreenView(route);
      }
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (kDebugMode) {
      if (previousRoute is PageRoute && route is PageRoute) {
        _sendScreenView(previousRoute);
      }
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (kDebugMode) {
      if (newRoute is PageRoute) {
        _sendScreenView(newRoute);
      }
    }
  }
}
