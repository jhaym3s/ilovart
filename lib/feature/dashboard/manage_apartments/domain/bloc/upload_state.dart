part of 'upload_bloc.dart';

sealed class UploadState extends Equatable {
  const UploadState();
  
 
}

final class UploadInitial extends UploadState {
   @override
  List<Object> get props => [];
}

class UploadImagesLoadingState extends UploadState{
   @override
  List<Object> get props => [];
}

class UploadImagesFailureState extends UploadState{
   @override
  List<Object> get props => [];
}

class UploadImagesSuccessState extends UploadState{
   @override
  List<Object> get props => [];
}

class UploadRentalLoadingState extends UploadState{
   @override
  List<Object> get props => [];
}

class UploadRentalFailureState extends UploadState{
  final String failureMessage ;
  const UploadRentalFailureState({required this.failureMessage});
   @override
  List<Object> get props => [];
}

class UploadRentalSuccessState extends UploadState{
  final String successMessage ;
  const UploadRentalSuccessState({required this.successMessage});
   @override
  List<Object> get props => [];
}

