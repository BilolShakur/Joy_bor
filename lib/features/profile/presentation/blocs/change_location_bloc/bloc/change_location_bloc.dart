import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/features/profile/presentation/blocs/change_location_bloc/bloc/change_location_event.dart';
import 'package:joy_bor/features/profile/presentation/blocs/change_location_bloc/bloc/change_location_state.dart';

class ChangeLocationBloc
    extends Bloc<ChangeLocationEvent, ChangeLocationState> {
  ChangeLocationBloc() : super(ChangeLocationState()) {
    on<CountryChanged>((event, emit) {
      emit(
        state.copyWith(
          country: event.country,
          updateSuccess: false,
          error: null,
        ),
      );
    });

    on<CityChanged>((event, emit) {
      emit(state.copyWith(city: event.city, updateSuccess: false, error: null));
    });

    on<ZipChanged>((event, emit) {
      emit(state.copyWith(zip: event.zip, updateSuccess: false, error: null));
    });

    on<AddressChanged>((event, emit) {
      emit(
        state.copyWith(
          address: event.address,
          updateSuccess: false,
          error: null,
        ),
      );
    });

    on<UpdateLocation>((event, emit) async {
      emit(state.copyWith(isUpdating: true, error: null, updateSuccess: false));

      // Simulate update delay (replace with your actual logic, e.g. API call)
      await Future.delayed(const Duration(seconds: 2));

      // Simple validation example
      if (state.country.isEmpty ||
          state.city.isEmpty ||
          state.zip.isEmpty ||
          state.address.isEmpty) {
        emit(
          state.copyWith(
            isUpdating: false,
            error: "Please fill all fields",
            updateSuccess: false,
          ),
        );
        return;
      }

      // On success:
      emit(state.copyWith(isUpdating: false, updateSuccess: true));
    });
  }
}
