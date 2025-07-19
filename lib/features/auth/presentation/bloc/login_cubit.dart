import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginOtpSent extends LoginState {
  final String email;
  LoginOtpSent(this.email);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(String email) async {
    emit(LoginLoading());
    final isRegistered = await repository.checkRegister(email);
    if (!isRegistered) {
      emit(LoginError('Bu email ro‘yxatdan o‘tmagan.'));
      return;
    }
    final otpSent = await repository.sendOtp(email);
    if (otpSent) {
      emit(LoginOtpSent(email));
    } else {
      emit(LoginError('OTP yuborilmadi.'));
    }
  }
}
