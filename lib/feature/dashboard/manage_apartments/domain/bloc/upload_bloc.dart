import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import '../services/upload_service.dart';
part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final RentalUpload rentalUpload;
  UploadBloc({required this.rentalUpload}) : super(UploadInitial()) {
    on<UploadRentalEvent>(uploadRental);
  }

  File convertXFileToFile(XFile xFile){
  final path = xFile.path;
  return File(path);
}


  FutureOr<void> uploadRental(UploadRentalEvent event, Emitter<UploadState> emit) async {
    emit(UploadRentalLoadingState());
    final xfiles = event.images;
    final imageFiles = xfiles.map((singleXFile)=> convertXFileToFile(singleXFile)).toList();
    final xVideo = event.video;
    final videoFile = convertXFileToFile(xVideo);
    final upload = await rentalUpload.uploadRental(
    property_type: event.property_type, 
    house_address: event.house_address, house_direction: event.house_direction, 
    state: event.state, lga: event.lga, listing_type: event.listing_type, 
    house_features: event.house_features, images: imageFiles, video: videoFile, 
    bills: event.bills);
    upload.fold((l){
      print("failure $l");
       emit(UploadRentalFailureState(failureMessage:  l=="failure request entity too large; image size can be 1024 kb max"? "Image or video size is too large": l));
    }, (r){
      print("failure $r");
      emit(UploadRentalSuccessState(successMessage:  "this is the success Message "));
    });
  }
}
