import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homefinder/core/data/supabase_api.dart';
import 'package:homefinder/features/auth/domain/auth_domain.dart';
import 'package:homefinder/features/auth/domain/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<CreateAccount>(_onCreateAccount);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final session = supaBase.auth.currentSession;
    if (session != null) {
      final user = AuthDomain(
        id: session.user.id,
        email: session.user.email ?? '',
        fullName: session.user.userMetadata?['full_name']?.toString() ?? '',
        phoneNumber:
            session.user.userMetadata?['phone_number']?.toString() ?? '',
      );
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> _onCreateAccount(
    CreateAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.createAccount(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
      );
      // After signup, we can check status or assume they need to verify email
      add(CheckAuthStatus());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.login(event.email, event.password);
      add(CheckAuthStatus());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
