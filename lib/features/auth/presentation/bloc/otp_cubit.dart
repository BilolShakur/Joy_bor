import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final Map<String, dynamic> user;
  OtpSuccess(this.user);
}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository repository;
  OtpCubit(this.repository) : super(OtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(OtpLoading());
    final result = await repository.verifyOtp(email: email, otp: otp);
    if (result != null && result['user'] != null) {
      emit(OtpSuccess(result['user']));
    } else {
      emit(OtpError('OTP noto‘g‘ri yoki muddat tugadi.'));
    }
  }
}
