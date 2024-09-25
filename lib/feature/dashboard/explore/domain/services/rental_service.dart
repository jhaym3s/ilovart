import 'package:dartz/dartz.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_call_managers.dart';
import '../../../../../core/helpers/network_exceptions.dart';

class RentalService{
  RentalService({required this.apiClient});
   final ApiClient  apiClient;

   Future<Either<String,dynamic>> getRentals() async {
    try{
      final response = await apiClient.get(
      url: AppEndpoints.getRentals, 
      );
    return Right(response);
    }catch(e)
    {
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }
}