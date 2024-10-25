// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_travel/core/error/exceptions.dart';

import 'package:flutter_travel/core/error/failure.dart';
import 'package:flutter_travel/core/platform/network_info.dart';
import 'package:flutter_travel/features/destination/data/datasource/destination_local_data_souce.dart';
import 'package:flutter_travel/features/destination/data/datasource/destination_remote_datasource.dart';
import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/domain/repositories/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationLocalDataSource localDataSource;
  final DestinationRemoteDataSource remoteDataSource;

  DestinationRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<DestinationEntity>>> all() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDataSource.all();
        await localDataSource.cacheAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return Left(TimeoutFailure('Timeout. No Response!'));
      } on NotFoundException {
        return Left(NotFoundFailure('Data Not Found!'));
      } on ServerException {
        return Left(ServerFailure('Server Error!'));
      }
    } else {
      try {
        final result = await localDataSource.getAll();
        return Right(result.map((e) => e.toEntity).toList());
      } on CachedException {
        return Left(CachedFailure('Data is not Present!'));
      }
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return Left(TimeoutFailure('Timeout. No Response!'));
    } on NotFoundException {
      return Left(NotFoundFailure('Data Not Found!'));
    } on ServerException {
      return Left(ServerFailure('Server Error!'));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network!'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> top() async {
    try {
      final result = await remoteDataSource.top();
      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return Left(TimeoutFailure('Timeout. No Response!'));
    } on NotFoundException {
      return Left(NotFoundFailure('Data Not Found!'));
    } on ServerException {
      return Left(ServerFailure('Server Error!'));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network!'));
    }
  }
}
