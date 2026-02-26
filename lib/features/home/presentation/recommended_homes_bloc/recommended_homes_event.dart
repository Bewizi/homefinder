part of 'recommended_homes_bloc.dart';

sealed class RecommendedHomesEvent extends Equatable {
  const RecommendedHomesEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendedHomes extends RecommendedHomesEvent {}
