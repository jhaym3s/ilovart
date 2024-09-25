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

  final cloudinary = first.Cloudinary.signedConfig(
    apiKey: "643859679157423",
    apiSecret: "tO7ZXys2qQsbC4Kby8HN7pRohEM",
    cloudName: "dolyintd3",
  );

  final cloudinaryPublic =
      CloudinaryPublic('CLOUD_NAME', 'UPLOAD_PRESET', cache: false);

  Future<Either<String, dynamic>> uploadToCloudinary(File file) async {
    print('Get your image from with 1');
    final response = await cloudinary.upload(
        file: file.path,
        fileBytes: file.readAsBytesSync(),
        resourceType: first.CloudinaryResourceType.image,
        folder: "travoli",
        fileName: 'uploadedApartments',
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });
    print('Get your image from with 2');
    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return Right(response.secureUrl);
    } else {
      return Left(response.error!);
    }
  }

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
      "property_type": property_type,
      "house_address": house_address,
      "house_direction": house_direction,
      "state": state,
      "lga": lga,
      "listing_type": listing_type,
      "house_features": jsonEncode(house_features),
      //"image": jsonEncode(images),
      //"video": jsonEncode(images[0]),
      "bills": jsonEncode(bills)
    };
    FormData formData = FormData();
    for (int i = 0; i < images.length; i++) {
      String? mimeType = lookupMimeType(images[i].path);
      print("changes $mimeType");
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
      formData.files.add(
      MapEntry(
        'video',
        await MultipartFile.fromFile(
          video.path,
          filename: images[0].path.split('/').last,
          contentType: DioMediaType.parse(mimeType)
        ),
      ),
    );
         } 
        //else if (mimeType == 'video/mp4') {
        //   await MultipartFile.fromFile(images[i].path,
        //       filename: images[i].path.split('/').last,
        //       contentType: DioMediaType.parse('multipart/form-data'));
        // } else {
        //   await MultipartFile.fromFile(images[i].path,
        //       filename: images[i].path.split('/').last,
        //       contentType: DioMediaType.parse('multipart/form-data'));
        // }
      //     formData.files.add(
      //   MapEntry(
      //     'image',
      //     await MultipartFile.fromFile(
      //       images[i].path,
      //       filename: images[i].path.split('/').last,
      //       contentType: DioMediaType.parse('multipart/form-data')
      //     ),
      //   ),
      // );
      }
    }
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


//  final serializedImages = images.map((file) {
      //   final bytes = file.readAsBytesSync();
      //   final base64String = base64Encode(bytes);
      //   return {
      //     'fileName': file.path.split('/').last,
      //     'fileData': base64String,
      //   };
      // }).toList();
