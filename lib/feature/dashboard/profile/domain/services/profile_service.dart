

import 'package:dartz/dartz.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_exceptions.dart';

class ProfileService{

  final ApiClient apiClient;

  ProfileService({required this.apiClient});

  Future<Either<String,dynamic>> getProfile() async {
    try{
      final response = await apiClient.get(
      url: AppEndpoints.profile, 
      );
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }
}