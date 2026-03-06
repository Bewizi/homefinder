part of 'homes_bloc.dart';

sealed class HomesEvent extends Equatable {
  const HomesEvent();

  @override
  List<Object> get props => [];
}

class FetchHomes extends HomesEvent {}

class ToggleFavorite extends HomesEvent {
  final String homeId;
  const ToggleFavorite(this.homeId);

  @override
  List<Object> get props => [homeId];
}
