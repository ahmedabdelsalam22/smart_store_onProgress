import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/data_layer/models/user_model.dart';
import 'package:smart_store/domain_layer/repository/auth_repository.dart';

import '../../../domain_layer/repository/firestore_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._fireStoreRepository)
      : super(AuthInitialState());

  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;

  static AuthCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String emailAddress,
    required String password,
  }) {
    emit(RegisterLoadingState());
    _authRepository
        .createUserWithEmailAndPassword(
            emailAddress: emailAddress, password: password)
        .then((value) {
      verifyEmail();
      uploadUserToFireStore(name: name, email: emailAddress, uid: value!.uid);
      emit(RegisterSuccessState());
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
    });
  }

  verifyEmail() async {
    emit(verifyEmailLoadingState());
    final user = FirebaseAuth.instance.currentUser!;
    if (user.emailVerified) {
      emit(verifyEmailSuccessState());
    } else {
      await user.sendEmailVerification().then((value) {
        emit(verifyEmailSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(verifyEmailErrorState());
      });
    }
  }

  uploadUserToFireStore(
      {required String name, required String email, required String uid}) {
    emit(SaveUserDataLoadingState());

    UserModel userModel = UserModel(
      name: name,
      email: email,
    );

    _fireStoreRepository
        .uploadUserDataToFireStore(data: userModel.toMap(), uid: uid)
        .then((value) {
      debugPrint("user data saved to foreStore Success");
      emit(SaveUserDataSuccessState());
    }).catchError((onError) {
      emit(SaveUserDataErrorState(onError.toString()));
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
