abstract class ChangePasswordEvent {}

class CurrentPasswordChanged extends ChangePasswordEvent {
  final String password;
  CurrentPasswordChanged(this.password);
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String password;
  NewPasswordChanged(this.password);
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String password;
  ConfirmPasswordChanged(this.password);
}

class SubmitPasswordChange extends ChangePasswordEvent {}
