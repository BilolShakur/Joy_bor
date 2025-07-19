import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpResent extends OtpState {}

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Future<void> verifyOtp({
    required String fullName,
    required String email,
    required String password,
    required String otp,
  }) async {
    emit(OtpLoading());
    final success = await AuthRepository().activate(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: password,
      otp: otp,
    );
    if (success) {
      emit(OtpSuccess());
    } else {
      emit(OtpError("❌ Noto‘g‘ri OTP yoki muddati tugagan."));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(OtpLoading());
    final success = await AuthRepository().sendOtp(email);
    if (success) {
      emit(OtpResent());
      emit(OtpInitial());
    } else {
      emit(OtpError("❌ OTP yuborishda xatolik."));
    }
  }
}
