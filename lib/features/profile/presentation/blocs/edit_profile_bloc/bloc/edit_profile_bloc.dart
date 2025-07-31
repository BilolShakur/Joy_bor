import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/features/profile/presentation/blocs/edit_profile_bloc/bloc/edit_profile_event.dart';
import 'package:joy_bor/features/profile/presentation/blocs/edit_profile_bloc/bloc/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState()) {
    on<FullNameChanged>((event, emit) {
      emit(
        state.copyWith(
          fullName: event.fullName,
          updateSuccess: false,
          error: null,
        ),
      );
    });

    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(email: event.email, updateSuccess: false, error: null),
      );
    });

    on<PhoneCountryCodeChanged>((event, emit) {
      emit(
        state.copyWith(
          phoneCountryCode: event.countryCode,
          updateSuccess: false,
          error: null,
        ),
      );
    });

    on<PhoneNumberChanged>((event, emit) {
      emit(
        state.copyWith(
          phoneNumber: event.phoneNumber,
          updateSuccess: false,
          error: null,
        ),
      );
    });

    on<UpdateProfileRequested>((event, emit) async {
      emit(state.copyWith(isUpdating: true, error: null, updateSuccess: false));

      // Simulate a network call or database update delay
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (state.fullName.isEmpty ||
          state.email.isEmpty ||
          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(state.email) ||
          state.phoneNumber.isEmpty) {
        emit(
          state.copyWith(
            isUpdating: false,
            error: 'Please fill all fields correctly.',
            updateSuccess: false,
          ),
        );
        return;
      }

      // If all validations pass
      emit(state.copyWith(isUpdating: false, updateSuccess: true));
    });
  }
}
