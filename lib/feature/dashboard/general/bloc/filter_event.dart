part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  
}

class ApplyFilter extends FilterEvent{
  final String location; 
  final List<String> selectedRanges, apartmentTypes;
  ApplyFilter({required this.location, required this.selectedRanges, required this.apartmentTypes});
  @override
  List<Object?> get props => [location,selectedRanges, apartmentTypes];
}
