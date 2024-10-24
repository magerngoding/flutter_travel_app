// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_travel/api/urls.dart';
import 'package:flutter_travel/core/error/exceptions.dart';
import 'package:flutter_travel/features/destination/data/models/destination_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/destination_entity.dart';

abstract class DestinationRemoteDatasource {
  Future<List<DestinationEntity>> all();
  Future<List<DestinationEntity>> top();
  Future<List<DestinationEntity>> search(String query);
}

class DestinationRemoteDatasourceImpl implements DestinationRemoteDatasource {
  final http.Client client;
  DestinationRemoteDatasourceImpl(
      this.client); // positional argument tidak menggunkan required

  @override
  Future<List<DestinationEntity>> all() async {
    Uri url = Uri.parse('${URLs.base}/destination/all.php');
    final response = await client.get(url).timeout(
          Duration(seconds: 3),
        );
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationEntity>> search(String query) async {
    Uri url = Uri.parse('${URLs.base}/destination/search.php');
    final response = await client.post(url, body: {
      'query': query,
    }).timeout(
      Duration(seconds: 3),
    );
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationEntity>> top() async {
    Uri url = Uri.parse('${URLs.base}/destination/top.php');
    final response = await client.get(url).timeout(
          Duration(seconds: 3),
        );
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
