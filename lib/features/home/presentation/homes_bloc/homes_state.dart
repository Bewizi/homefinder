part of 'homes_bloc.dart';

sealed class HomesState extends Equatable {
  const HomesState();

  @override
  List<Object> get props => [];
}

final class HomesInitial extends HomesState {}

final class HomesLoading extends HomesState {}

final class HomesLoaded extends HomesState {
  const HomesLoaded(this.homes);

  final List<HomesDomain> homes;

  @override
  List<Object> get props => [homes];
}

final class HomesError extends HomesState {
  const HomesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
