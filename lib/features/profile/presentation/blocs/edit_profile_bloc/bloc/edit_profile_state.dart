class EditProfileState {
  final String fullName;
  final String email;
  final String phoneCountryCode;
  final String phoneNumber;

  final bool isUpdating;
  final bool updateSuccess;
  final String? error;

  EditProfileState({
    this.fullName = '',
    this.email = '',
    this.phoneCountryCode = '+998',
    this.phoneNumber = '',
    this.isUpdating = false,
    this.updateSuccess = false,
    this.error,
  });

  EditProfileState copyWith({
    String? fullName,
    String? email,
    String? phoneCountryCode,
    String? phoneNumber,
    bool? isUpdating,
    bool? updateSuccess,
    String? error,
  }) {
    return EditProfileState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      error: error,
    );
  }
}
