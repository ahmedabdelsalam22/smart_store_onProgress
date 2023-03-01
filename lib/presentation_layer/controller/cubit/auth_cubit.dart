import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/domain_layer/repository/auth_repository.dart';

import '../auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitialState());

  final AuthRepository _authRepository;

  static AuthCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String emailAddress,
    required String password,
  }) {
    emit(RegisterLoadingState());
    _authRepository
        .createUserWithEmailAndPassword(
            emailAddress: emailAddress, password: password)
        .then((value) {
      emit(RegisterSuccessState());
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
    });
  }

  void userLogin({
    required String emailAddress,
    required String password,
  }) {
    emit(LoginLoadingState());
    _authRepository
        .signInWithEmailAndPassword(
            emailAddress: emailAddress, password: password)
        .then((value) {
      emit(LoginSuccessState());
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  void signOut() {
    emit(SignOutLoadingState());
    _authRepository.signOut().then((value) {
      emit(SignOutSuccessState());
    }).catchError((onError) {
      emit(SignOutErrorState(onError.toString()));
    });
  }
}
