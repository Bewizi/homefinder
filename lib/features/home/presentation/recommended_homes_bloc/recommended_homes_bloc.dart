import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homefinder/features/home/domain/recommended_homes_domain.dart';
import 'package:homefinder/features/home/domain/recommended_homes_repository.dart';

part 'recommended_homes_event.dart';
part 'recommended_homes_state.dart';

class RecommendedHomesBloc
    extends Bloc<RecommendedHomesEvent, RecommendedHomesState> {
  RecommendedHomesBloc({
    required RecommendedHomesRepository recommendedHomesRepository,
  }) : _recommendedHomesRepository = recommendedHomesRepository,
       super(RecommendedHomesInitial()) {
    on<FetchRecommendedHomes>(_onFetchRecommendedHomes);
  }

  final RecommendedHomesRepository _recommendedHomesRepository;

  Future<void> _onFetchRecommendedHomes(
    FetchRecommendedHomes event,
    Emitter<RecommendedHomesState> emit,
  ) async {
    emit(RecommendedHomesLoading());
    try {
      final recommendedHomes = await _recommendedHomesRepository
          .getAllRecommendedHomes();
      emit(RecommendedHomesLoaded(recommendedHomes));
    } on Exception catch (e) {
      emit(RecommendedHomesError(e.toString()));
    }
  }
}
