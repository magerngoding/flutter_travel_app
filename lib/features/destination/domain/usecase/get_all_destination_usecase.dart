// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/domain/repositories/destination_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllDestinationUsecase {
  final DestinationRepository _repository;
  GetAllDestinationUsecase(
    this._repository,
  );

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.all();
  }
}
