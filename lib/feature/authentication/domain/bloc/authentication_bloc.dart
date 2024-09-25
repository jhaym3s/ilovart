import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:travoli/feature/authentication/domain/services/auth_services.dart';

import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/shared_preference_manager.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationService authenticationService;
  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitialState()) {
    on<RegisterUserEvent>(createUser);
    on<LoginUserEvent>(signInUser);
     on<RequestOtpEvent>(getOtp);
    on<VerifyOtpEvent>(verifyOtp);
  }

  FutureOr<void> createUser(RegisterUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(RegisterUserLoadingState());
    final registerUser = await authenticationService.registerUser(email: event.email, password: event.password, firstName: event.firstName, lastName: event.lastName, phoneNumber: event.phoneNumber, isAgent: event.isAgent);
    registerUser.fold(
      (l) => emit(RegisterUserFailureState(errorMessage: l)), 
      (r) {
        SharedPreferencesManager.setString(PrefKeys.userId, r["data"]["_id"]);
        SharedPreferencesManager.setString(PrefKeys.email, r["data"]["email"]);
        emit(RegisterUserSuccessState());
      });
  }

  FutureOr<void> signInUser(LoginUserEvent event, Emitter<AuthenticationState> emit) async{
    emit(LoginUserLoadingState());
    final registerUser = await authenticationService.loginUser(email: event.email, password: event.password, );
    registerUser.fold(
      (l) => emit(LoginUserFailureState(errorMessage: l)), 
      (r) {
        if (r["data"]["is_agent"]== true) {
           SharedPreferencesManager.setBool(PrefKeys.isTenant, false);
        }
        print(r["data"]);
        SharedPreferencesManager.setBool(PrefKeys.isFirstTime, false);
         SharedPreferencesManager.setString(PrefKeys.userId, r["data"]["_id"]);
         SharedPreferencesManager.setString(PrefKeys.accessToken, r["data"]["access_token"]);
        SharedPreferencesManager.setString(PrefKeys.refreshToken, r["data"]["refresh_token"]);
        
        emit(LoginUserSuccessState(isAgent: r["data"]["is_agent"]));
      });
  }

  FutureOr<void> getOtp(RequestOtpEvent event, Emitter<AuthenticationState> emit) async {
      emit(RequestOTPLoadingState());
    final requestOtp = await authenticationService.getOTP();
    requestOtp.fold((l) => emit(RequestOTPFailureState(errorMessage: l)), 
    (r) => RequestOTPSuccessState());
  }

  FutureOr<void> verifyOtp(VerifyOtpEvent event, Emitter<AuthenticationState> emit) async{
    emit(VerifyOTPLoadingState());
    final requestOtp = await authenticationService.verifyOTP(otp: event.otp);
    requestOtp.fold((l) => emit(VerifyOTPFailureState(errorMessage: l)), 
    (r) => VerifyOTPSuccessState());
  }
}
