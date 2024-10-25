part of 'top_destination_bloc.dart';

sealed class TopDestinationState extends Equatable {
  const TopDestinationState();

  @override
  List<Object> get props => [];
}

final class TopDestinationInitial extends TopDestinationState {}

final class TopDestinationLoading extends TopDestinationState {}

final class TopDestinationFailure extends TopDestinationState {
  final String message;

  TopDestinationFailure(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class TopDestinationLoaded extends TopDestinationState {
  final List<DestinationEntity> data; // isi data ketika berhasil

  TopDestinationLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
