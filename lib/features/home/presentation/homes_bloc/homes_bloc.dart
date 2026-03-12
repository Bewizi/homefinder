import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';
import 'package:homefinder/features/home/domain/homes_repository.dart';

part 'homes_event.dart';
part 'homes_state.dart';

class HomesBloc extends Bloc<HomesEvent, HomesState> {
  HomesBloc({required HomesRepository homesRepository})
    : _homesRepository = homesRepository,
      super(HomesInitial()) {
    on<FetchHomes>(_onFetchHomes);
    on<SearchHomes>(_onSearchHomes);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  final HomesRepository _homesRepository;
  List<HomesDomain> _allHomes = [];

  Future<void> _onFetchHomes(FetchHomes event, Emitter<HomesState> emit) async {
    emit(HomesLoading());
    try {
      _allHomes = await _homesRepository.getAllHomes();
      emit(HomesLoaded(_allHomes));
    } on Exception catch (e) {
      emit(HomesError(e.toString()));
    }
  }

  void _onSearchHomes(SearchHomes event, Emitter<HomesState> emit) {
    if (event.query.isEmpty) {
      emit(HomesLoaded(_allHomes));
    } else {
      final filteredHomes = _allHomes
          .where(
            (home) =>
                home.name.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();
      emit(HomesLoaded(filteredHomes));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<HomesState> emit) {
    if (state is HomesLoaded) {
      final currentState = state as HomesLoaded;
      final updatedHomes = currentState.homes.map((home) {
        if (home.id == event.homeId) {
          return home.copyWith(isFavourite: !home.isFavourite);
        }
        return home;
      }).toList();

      _allHomes = _allHomes.map((home) {
        if (home.id == event.homeId) {
          return home.copyWith(isFavourite: !home.isFavourite);
        }
        return home;
      }).toList();

      emit(HomesLoaded(updatedHomes));
    }
  }
}
