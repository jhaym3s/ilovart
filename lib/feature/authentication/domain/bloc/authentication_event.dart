part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable{}

class RegisterUserEvent extends AuthenticationEvent{
   final String email;
   final  String password; 
   final  String firstName;
   final  String lastName; 
   final  String phoneNumber;
   final  bool isAgent;
   RegisterUserEvent({required this.password, required this.firstName,required this.lastName,required this.phoneNumber,required this.isAgent, required this.email});
  @override
  List<Object?> get props => [email, password,firstName,lastName,phoneNumber, isAgent];
}

class LoginUserEvent extends AuthenticationEvent{
  final String email,password;
  LoginUserEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email,password];
}

class RequestOtpEvent extends AuthenticationEvent{
  RequestOtpEvent();
  @override
  List<Object?> get props => [];
}

class VerifyOtpEvent extends AuthenticationEvent{
  final String otp;
  VerifyOtpEvent({required this.otp});
  @override
  List<Object?> get props => [];
}
