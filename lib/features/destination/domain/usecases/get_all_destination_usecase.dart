import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/destination_entity.dart';
import '../repositories/destination_repository.dart';

class GetAllDestinationUseCase {
  final DestinationRepository _repository;

  GetAllDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.all();
  }
}
