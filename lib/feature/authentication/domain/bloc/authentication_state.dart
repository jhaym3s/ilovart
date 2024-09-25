part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable{}

final class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object?> get props =>[];
}

class RegisterUserLoadingState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}

class RegisterUserFailureState extends AuthenticationState{
  final String errorMessage;
  RegisterUserFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

class RegisterUserSuccessState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}

class LoginUserLoadingState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}

class LoginUserFailureState extends AuthenticationState{
  final String errorMessage;
  LoginUserFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

class LoginUserSuccessState extends AuthenticationState{
  final bool isAgent;
  LoginUserSuccessState({required this.isAgent});
  @override
  List<Object?> get props => [];
}


class RequestOTPLoadingState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}

class RequestOTPFailureState extends AuthenticationState{
  final String errorMessage;
  RequestOTPFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

class RequestOTPSuccessState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}


class VerifyOTPLoadingState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}

class VerifyOTPFailureState extends AuthenticationState{
  final String errorMessage;
  VerifyOTPFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

class VerifyOTPSuccessState extends AuthenticationState{
  @override
  List<Object?> get props => [];
}


