part of 'all_destination_bloc.dart';

sealed class AllDestinationState extends Equatable {
  const AllDestinationState();

  @override
  List<Object> get props => [];
}

final class AllDestinationInitial extends AllDestinationState {}

final class AllDestinationLoading extends AllDestinationState {}

final class AllDestinationFailure extends AllDestinationState {
  final String message;

  AllDestinationFailure(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class AllDestinationLoaded extends AllDestinationState {
  final List<DestinationEntity> data; // isi data ketika berhasil

  AllDestinationLoaded(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
