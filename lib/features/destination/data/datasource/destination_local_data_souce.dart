// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_travel/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_travel/features/destination/data/models/destination_model.dart';

const cacheAllDestinationKey = 'all_destination';

abstract class DestinationLocalDataSouce {
  Future<List<DestinationModel>> getAll();
  Future<bool> cahcheAll(List<DestinationModel> list);
}

class DestinationLocalDataSourceImpl implements DestinationLocalDataSouce {
  final SharedPreferences prefs;

  DestinationLocalDataSourceImpl({
    required this.prefs,
  });

  @override
  Future<bool> cahcheAll(List<DestinationModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allDestination = jsonEncode(listMap);
    return prefs.setString(cacheAllDestinationKey, allDestination);
  }

  @override
  Future<List<DestinationModel>> getAll() async {
    String? allDestinaion = prefs.getString(cacheAllDestinationKey);
    if (allDestinaion != null) {
      List listMap = List<Map<String, dynamic>>.from(jsonDecode(allDestinaion));
      List<DestinationModel> list =
          listMap.map((e) => DestinationModel.fromJson(e)).toList();
      return list;
    }
    throw CachedException();
  }
}
