import 'package:dartz/dartz.dart';
import 'package:travoli/core/api/endpoints.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';

import '../../../../core/helpers/network_call_managers.dart';
import '../../../../core/helpers/network_exceptions.dart';

class AuthenticationService{
  AuthenticationService({required this.apiClient});
   final ApiClient  apiClient;

   Future<Either<String,dynamic>> registerUser({required String email,required String password,required String firstName,
   required String lastName,required String phoneNumber,required bool isAgent}) async {
    try{
      final response = await apiClient.authPost(
      url: AppEndpoints.registerUsers, 
      data: {
   "email": email,
   "password": password,
   "is_agent": isAgent,
   "first_name": firstName,
   "last_name": lastName,
   "phone_number": phoneNumber,
   "country_code": "+234",
   "country_iso_code_2": "NG"
    });
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }

   Future<Either<String,dynamic>> loginUser({required String email,required String password}) async {
    try{
      final response = await apiClient.authPost(
      url: AppEndpoints.loginUsers, 
      data: {
    "email": email,
    "password": password,
    });
    print("log in $response");
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }

   Future<Either<String,dynamic>> getOTP() async {
    final email = SharedPreferencesManager.getString(PrefKeys.email);
    final uId = SharedPreferencesManager.getString(PrefKeys.userId);
    try{
      final response = await apiClient.authPost(
      url: AppEndpoints.getOTP, 
      data: {
    "email": email,
    "uid": uId
    });
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }

   Future<Either<String,dynamic>> verifyOTP({required String otp}) async {
    try{
      final response = await apiClient.authPost(
      url: AppEndpoints.verifyOTP, 
      data: {
        "otp": otp
    });
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }


  
}