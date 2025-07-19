import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpOtpSent extends SignUpState {
  final String email;
  SignUpOtpSent(this.email);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository repository;
  SignUpCubit(this.repository) : super(SignUpInitial());

  Future<void> signUp({
    required String email,
    required String phoneNumber,
    required String fullName,
    required String country,
    required String city,
    required String zip,
    required String address,
    String? googleId,
    String? imgUrl,
  }) async {
    emit(SignUpLoading());
    final isRegistered = await repository.checkRegister(email);
    if (isRegistered) {
      emit(SignUpError('Bu email allaqachon ro‘yxatdan o‘tgan.'));
      return;
    }
    final created = await repository.createUser(
      email: email,
      phoneNumber: phoneNumber,
      fullName: fullName,
      country: country,
      city: city,
      zip: zip,
      address: address,
      googleId: googleId,
      imgUrl: imgUrl,
    );
    if (!created) {
      emit(SignUpError('Foydalanuvchi yaratishda xatolik.'));
      return;
    }
    final otpSent = await repository.sendOtp(email);
    if (otpSent) {
      emit(SignUpOtpSent(email));
    } else {
      emit(SignUpError('OTP yuborilmadi.'));
    }
  }
}
