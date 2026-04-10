part of 'homes_bloc.dart';

sealed class HomesEvent extends Equatable {
  const HomesEvent();

  @override
  List<Object> get props => [];
}

class FetchHomes extends HomesEvent {}

class SearchHomes extends HomesEvent {
  final String query;

  const SearchHomes(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFavorite extends HomesEvent {
  final String homeId;

  const ToggleFavorite(this.homeId);

  @override
  List<Object> get props => [homeId];
}

class FilterHomesByType extends HomesEvent {
  final String? type;

  const FilterHomesByType(this.type);

  @override
  List<Object> get props => [type ?? 'All'];
}
