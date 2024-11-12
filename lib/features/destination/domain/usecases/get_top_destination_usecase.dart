import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/destination_entity.dart';
import '../repositories/destination_repository.dart';

class GetTopDestinationUseCase {
  final DestinationRepository _repository;

  GetTopDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.top();
  }
}
