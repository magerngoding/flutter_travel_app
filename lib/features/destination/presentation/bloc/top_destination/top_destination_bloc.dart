import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel/features/destination/domain/usecase/get_top_destination_usecase.dart';

import '../../../domain/entities/destination_entity.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc
    extends Bloc<TopDestinationEvent, TopDestinationState> {
  final GetTopDestinationUsecase _usecase;

  TopDestinationBloc(this._usecase) : super(TopDestinationInitial()) {
    on<OnGetTopDestination>((event, emit) async {
      emit(TopDestinationLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(TopDestinationFailure(failure.message)),
        (data) => emit(TopDestinationLoaded(data)),
      );
    });
  }
}
