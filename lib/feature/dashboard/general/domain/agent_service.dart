
import 'package:dartz/dartz.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_exceptions.dart';

class AgentService{

  ApiClient apiClient;

  AgentService({required this.apiClient});

  Future<Either<String,dynamic>> getAgentInfo({required String id}) async {
    try{
      final response = await apiClient.get(
      url: AppEndpoints.agentProfile,
      params: {"id": id}
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