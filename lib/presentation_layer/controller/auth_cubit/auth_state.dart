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

class SaveUserDataLoadingState extends AuthState {}

class SaveUserDataSuccessState extends AuthState {}

class SaveUserDataErrorState extends AuthState {
  final String error;

  SaveUserDataErrorState(this.error);
}

class GetUserDataLoadingState extends AuthState {}

class GetUserDataSuccessState extends AuthState {}

class GetUserDataErrorState extends AuthState {
  final String error;

  GetUserDataErrorState(this.error);
}
