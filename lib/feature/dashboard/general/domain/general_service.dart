
import 'package:dartz/dartz.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_exceptions.dart';

class GeneralService{

  CustomApiClient apiClient;

  GeneralService({required this.apiClient});

  Future<Either<String,dynamic>> getStates() async {
    try{
      final response = await apiClient.get(
      url: AppEndpoints.nigerianStates, 
      );
      print("states $response");
    return Right(response);
    }catch(e){
      print("states error $e");
        final ex = NetworkExceptions.getDioException(e);
        print("states error 1 $ex");
        return Left(ex);
    }
   }

  
}