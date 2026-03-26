import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homefinder/features/profile/domain/profile_repository.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_event.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await _profileRepository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updateProfile(event.profile);
      emit(ProfileUpdated());
      add(LoadProfile()); // Reload profile after update
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
