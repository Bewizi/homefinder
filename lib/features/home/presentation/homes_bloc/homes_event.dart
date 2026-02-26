part of 'homes_bloc.dart';

sealed class HomesEvent extends Equatable {
  const HomesEvent();

  @override
  List<Object> get props => [];
}

class FetchHomes extends HomesEvent {}
