part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        password,
        confirmPassword,
      ];
}

final class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

final class GetUser extends AuthenticationEvent {
  const GetUser();

  @override
  List<Object?> get props => [];
}

final class ResetPassword extends AuthenticationEvent {
  final String email;
  const ResetPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [
        email,
      ];
}
