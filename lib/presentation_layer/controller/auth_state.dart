abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}

class SignOutLoadingState extends AuthState {}

class SignOutSuccessState extends AuthState {}

class SignOutErrorState extends AuthState {
  final String error;

  SignOutErrorState(this.error);
}

class saveUserDataLoadingState extends AuthState {}

class saveUserDataSuccessState extends AuthState {}

class saveUserDataErrorState extends AuthState {
  final String error;

  saveUserDataErrorState(this.error);
}
