import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginObscure extends LoginState {
  final bool isObscure;
  LoginObscure(this.isObscure);
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginCubit extends Cubit<LoginState> {
  bool _isObscure = true;
  LoginCubit() : super(LoginObscure(true));

  void toggleObscure(bool current) {
    _isObscure = !current;
    emit(LoginObscure(_isObscure));
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Iltimos, barcha maydonlarni to‘ldiring."));
      emit(LoginObscure(_isObscure));
      return;
    }
    emit(LoginLoading());
    final success = await AuthRepository().login(email, password);
    if (success) {
      emit(LoginSuccess());
    } else {
      emit(LoginError("Email yoki parol noto‘g‘ri."));
      emit(LoginObscure(_isObscure));
    }
  }
}
