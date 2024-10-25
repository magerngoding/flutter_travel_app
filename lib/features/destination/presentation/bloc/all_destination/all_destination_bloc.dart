import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/domain/usecase/get_all_destination_usecase.dart';

part 'all_destination_event.dart';
part 'all_destination_state.dart';

class AllDestinationBloc
    extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetAllDestinationUsecase _usecase;

  AllDestinationBloc(this._usecase) : super(AllDestinationInitial()) {
    on<OnGetAllDestination>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await _usecase.call();
      result.fold(
        (failure) => emit(AllDestinationFailure(failure.message)),
        (data) => emit(AllDestinationLoaded(data)),
      );
    });
  }
}
