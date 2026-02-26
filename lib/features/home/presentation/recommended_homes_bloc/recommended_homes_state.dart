part of 'recommended_homes_bloc.dart';

sealed class RecommendedHomesState extends Equatable {
  const RecommendedHomesState();

  @override
  List<Object> get props => [];
}

final class RecommendedHomesInitial extends RecommendedHomesState {}

final class RecommendedHomesLoading extends RecommendedHomesState {}

final class RecommendedHomesLoaded extends RecommendedHomesState {
  const RecommendedHomesLoaded(this.recommendedHomes);

  final List<RecommendedHomesDomain> recommendedHomes;

  @override
  List<Object> get props => [recommendedHomes];
}

final class RecommendedHomesError extends RecommendedHomesState {
  const RecommendedHomesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
