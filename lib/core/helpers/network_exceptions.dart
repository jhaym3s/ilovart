import 'dart:io';

import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return 'Request cancelled';
            case DioExceptionType.connectionTimeout:
              return 'Connection timed out!';
            case DioExceptionType.unknown:
              return 'Something went wrong here1!';
            case DioExceptionType.receiveTimeout:
              return 'Request timed out';
            // case DioExceptionType.receiveTimeout:
            //   return 'Took too much time please check your internet and try again';
            case DioExceptionType.sendTimeout:
              return 'Request timed out';
            case DioExceptionType.badCertificate:
               return 'Something went wrong here!';
            case DioExceptionType.badResponse:
              return error.response!.data["error"];
            case DioExceptionType.connectionError:
              return 'Connection error';
          }
        } else if (error is SocketException) {
          return 'No internet connection!';
        } else {
          return 'Unexpected error occurre';
        }
      } on FormatException {
        return 'Bad response format';
      } catch (err ) {
        return err.toString();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return 'Unexpected error occurred1';
      } else {
        return 'Unexpected error occurred3';
      }
    }
  }
}