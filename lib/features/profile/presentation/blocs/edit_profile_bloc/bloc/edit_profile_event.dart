abstract class EditProfileEvent {}

class FullNameChanged extends EditProfileEvent {
  final String fullName;
  FullNameChanged(this.fullName);
}

class EmailChanged extends EditProfileEvent {
  final String email;
  EmailChanged(this.email);
}

class PhoneCountryCodeChanged extends EditProfileEvent {
  final String countryCode;
  PhoneCountryCodeChanged(this.countryCode);
}

class PhoneNumberChanged extends EditProfileEvent {
  final String phoneNumber;
  PhoneNumberChanged(this.phoneNumber);
}

class UpdateProfileRequested extends EditProfileEvent {}
