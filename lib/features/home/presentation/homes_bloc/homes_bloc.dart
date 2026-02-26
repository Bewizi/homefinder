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
  }

  final HomesRepository _homesRepository;

  Future<void> _onFetchHomes(FetchHomes event, Emitter<HomesState> emit) async {
    emit(HomesLoading());
    try {
      final homes = await _homesRepository.getAllHomes();
      emit(HomesLoaded(homes));
    } on Exception catch (e) {
      emit(HomesError(e.toString()));
    }
  }
}
