import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/core/helpers/network_call_managers.dart';
import 'package:cloudinary/cloudinary.dart' as first;
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import '../../../../../core/api/endpoints.dart';
import '../../../../../core/helpers/network_exceptions.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:mime/mime.dart';

class RentalUpload {
  CustomApiClient customApiClient;
  ApiClient apiClient;
  RentalUpload({required this.customApiClient, required this.apiClient});


  

  Future<Either<String, dynamic>> uploadRental(
      {required String property_type,
      required String house_address,
      required String house_direction,
      required String state,
      required String lga,
      required String listing_type,
      required List<String> house_features,
      required List<File> images,
      required File video,
      required List<Bill> bills}) async {
    print("something $images");
    final otherParams = {
      "property_type": property_type.toLowerCase(),
      "house_address": house_address.toLowerCase(),
      "house_direction": house_direction.toLowerCase(),
      "state": state.toLowerCase(),
      "lga": lga.toLowerCase(),
      "listing_type": listing_type.toLowerCase(),
      "house_features": jsonEncode(house_features),
      "bills": jsonEncode(bills)
    };
    FormData formData = FormData();
    for (int i = 0; i < images.length; i++) {
      String? mimeType = lookupMimeType(images[i].path);
      if (mimeType == null) {
      } else {
       if (mimeType == 'image/jpeg' || mimeType == 'image/png'|| mimeType == 'image/heif'|| mimeType == 'image/heic') {
        formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            images[i].path,
            filename: images[i].path.split('/').last,
            contentType: DioMediaType.parse(mimeType)
          ),
        ),
      );  
         } 
      }
    }
    // String videoMimeType = lookupMimeType(video.path)!;
    //   formData.files.add(
    //   MapEntry(
    //     'video',
    //     await MultipartFile.fromFile(
    //       video.path,
    //       filename: video.path.split('/').last,
    //       contentType: DioMediaType.parse(videoMimeType)
    //     ),
    //   ),
    // );
    otherParams.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });
    
    try {
      final response = await apiClient.formDataPost(
        url: AppEndpoints.uploadRentals,
        data: formData,
      );
      return Right(response);
    } catch (e) {
      final ex = NetworkExceptions.getDioException(e);
      print("falure $e");
      return Left(ex);
    }
  }
}


