import 'package:flutter/material.dart';

import '../../data/dao/place_dao.dart';
import '../screens/home_screen.dart';
import '../screens/place_screen.dart';

class AppRouter {
  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case PlaceScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          final args = routeSettings.arguments as PlaceDAO;
          return PlaceScreen(username: args.username!);
        });
      default:
        return null;
    }
  }
}
