import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travoli/core/helpers/hive_repository.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';

import '../../../../core/configs/storage_box.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final HiveRepository _hiveRepository = HiveRepository();
  FilterBloc() : super(FilterInitial()) {
    on<ApplyFilter>(applyFilter);
  }

FutureOr<void> applyFilter(ApplyFilter event, Emitter<FilterState> emit) {
    emit(ApplyFilterLoadingState());
    final List<int> selectedRanges = [];
   void selectRange(String amount){
    switch (amount) {
    case "100k -350k":
     selectedRanges.addAll([100000,350000]); 
    case "350k - 500k":
     selectedRanges.addAll([350000,500000]); 
    case "500k - 1.5M":
     selectedRanges.addAll([500000,1500000]);
    case "1.5M - 3.5M":
     selectedRanges.addAll([1500000,3500000]);
    case "3.5M - 5M":
     selectedRanges.addAll([3500000,5000000]); 
    case "5M and Above":
     selectedRanges.addAll([5000000,100000000]); 
}}
    final List<Rentals> rentals = _hiveRepository.get(key: HiveKeys.rentals, name: HiveKeys.rentals);
    final List<Rentals> rentalsByLocation = rentals.where((element) => element.state == event.location).toList();
    if (rentalsByLocation.isNotEmpty){
     final  List<Rentals> rentalByType = rentalsByLocation.where((rental) => event.apartmentTypes.contains(rental.propertyType)).toList();
      if (rentalByType.isNotEmpty){
          for (var i = 0; i < event.selectedRanges.length; i++) {
            selectRange(event.selectedRanges[i]);
          }
      final min = selectedRanges.reduce((value, element) => value < element? value:element);
      final max = selectedRanges.reduce((value, element) => value > element? value:element);
     final List<Rentals> rentalByAmount = rentalByType.where((rental) =>  rental.bills.firstWhere((map) => map.name == "john").price>= min && rental.bills.firstWhere((map) => map.name == "john").price>= max).toList();  
     if(rentalByAmount.isNotEmpty){
        emit(ApplyFilterSuccessState(rentals: rentalByAmount));
     }else{
         emit(ApplyFilterFailureState(errorMessage: "No apartments available for this price range "));
     }
      }else{
         emit(ApplyFilterFailureState(errorMessage: "No apartment available for the apartment type selected"));
      }
    }else{
      emit(ApplyFilterFailureState(errorMessage: "No apartment available for this location"));
    } 
     }

}
