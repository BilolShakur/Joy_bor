import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String fullName;
  final String email;
  final String password;
  SignUpSuccess({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      emit(SignUpError("Iltimos, barcha maydonlarni to‘ldiring."));
      return;
    }
    emit(SignUpLoading());
    final isSignedUp = await AuthRepository().signUpUser(
      fullName: fullName,
      email: email,
      password: password,
    );
    if (isSignedUp) {
      emit(SignUpSuccess(fullName: fullName, email: email, password: password));
    } else {
      emit(SignUpError("Bu email allaqachon ro‘yxatdan o‘tgan."));
    }
  }
}
