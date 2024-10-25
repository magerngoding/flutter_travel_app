import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel/features/destination/domain/usecase/search_destination_usecase.dart';

import '../../../domain/entities/destination_entity.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc
    extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final SearchDestinationUsecase _usecase;

  SearchDestinationBloc(this._usecase) : super(SearchDestinationInitial()) {
    on<OnSearchDestination>((event, emit) async {
      emit(SearchDestinationLoading());
      final result = await _usecase(query: event.query);
      result.fold(
        (failure) => emit(SearchDestinationFailure(failure.message)),
        (data) => emit(SearchDestinationLoaded(data)),
      );
    });
  }
}
