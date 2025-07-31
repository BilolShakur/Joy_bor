import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordState()) {
    on<CurrentPasswordChanged>((event, emit) {
      emit(state.copyWith(currentPassword: event.password));
    });

    on<NewPasswordChanged>((event, emit) {
      emit(state.copyWith(newPassword: event.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.password));
    });

    on<SubmitPasswordChange>((event, emit) async {
      if (state.newPassword != state.confirmPassword) {
        emit(state.copyWith(errorMessage: 'Passwords do not match'));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));
      await Future.delayed(Duration(seconds: 2)); // simulate API call

      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
