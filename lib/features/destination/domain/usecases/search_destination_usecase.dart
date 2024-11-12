import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/destination_entity.dart';
import '../repositories/destination_repository.dart';

class SearchDestinationUseCase {
  final DestinationRepository _repository;

  SearchDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call(
      {required String query}) {
    return _repository.search(query);
  }
}
