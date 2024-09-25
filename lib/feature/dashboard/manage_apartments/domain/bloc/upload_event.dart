part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();
}
class UploadRentalEvent extends UploadEvent {
  final String property_type;
  final String house_address;
  final String house_direction;
  final String state;
  final String lga;
  final String listing_type;
  final List<String> house_features;
  final List<XFile> images;
  final XFile video;
  final List<Bill> bills;

  const UploadRentalEvent(
      {required this.property_type,
      required this.house_address,
      required this.house_direction,
      required this.state,
      required this.lga,
      required this.listing_type,
      required this.house_features,
      required this.images,
      required this.video,
      required this.bills});
  @override
  List<Object?> get props => [property_type,house_address,house_address, house_direction,state,lga,listing_type,house_features,images, video,bills];
}
