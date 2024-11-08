// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/presentation/pages/detail_destination_page.dart';
import 'package:flutter_travel/features/destination/presentation/pages/search_destination_page.dart';

import '../features/destination/presentation/pages/dashboard.dart';

class AppRoute {
  static const dashboard = '/';
  static const detailDestination = '/destination/detail';
  static const searchDestination = '/destination/search';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard: // Case 1
        return MaterialPageRoute(
          builder: (context) => Dashboard(),
        );

      case detailDestination: // Case 2
        final destination = settings.arguments;
        if (destination == null) return _invalidArgumentPage;
        if (destination is! DestinationEntity) return _invalidArgumentPage;
        return MaterialPageRoute(
          builder: (context) => DetailDestinationPage(
            destination: destination,
          ),
        );

      case searchDestination: // Case 3
        return MaterialPageRoute(
          builder: (context) => SearchDestinationPage(),
        );
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _invalidArgumentPage => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Invalid Arguments!'),
          ),
        ),
      );
  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Route Not Found!'),
          ),
        ),
      );
}
