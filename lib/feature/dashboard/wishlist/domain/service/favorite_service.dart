
import 'package:dartz/dartz.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_exceptions.dart';

class FavoriteService{

  ApiClient apiClient;

  FavoriteService({required this.apiClient});

  Future<Either<String,dynamic>> getFavorite() async {
    try{
      final response = await apiClient.get(
      url: AppEndpoints.favorite, 
      );
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }

   Future<Either<String,dynamic>> addFavorite({required List<dynamic> favorite}) async {
    try{
      final response = await apiClient.put(
      url: AppEndpoints.favorite, 
      data: {
        "favorites": favorite
      }
      );
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }

   Future<Either<String,dynamic>> removeFavorite({required List<dynamic> favorite}) async {
    try{
      final response = await apiClient.delete(
      url: AppEndpoints.favorite, 
      data: {
        "favorites": favorite
      }
      );
    return Right(response);
    }catch(e){
        final ex = NetworkExceptions.getDioException(e);
        return Left(ex);
    }
   }
}