import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/feature/dashboard/explore/domain/models/rentals.dart';
import 'package:travoli/feature/dashboard/explore/domain/services/rental_service.dart';

import '../../../../core/helpers/hive_repository.dart';

part 'rentals_event.dart';
part 'rentals_state.dart';

class RentalsBloc extends Bloc<RentalsEvent, RentalsState> {
  final HiveRepository _hiveRepository = HiveRepository();
  RentalService rentalService;
  RentalsBloc({required this.rentalService}) : super(RentalsInitial()) {
    on<GetRentalsEvent>(getRental);
  }

  FutureOr<void> getRental(GetRentalsEvent event, Emitter<RentalsState> emit) async {
    emit(GetRentalLoadingState());
    final rentals = await rentalService.getRentals();
    rentals.fold((l) {
      print("error omo  $l");
      emit(GetRentalFailureState(errorMessage: l));
    }, 
    (r) {
      final  rentalList = (r["data"] as List);
      print("rental $rentalList");
      final rentals = rentalList.map((e) => Rentals.fromJson(e)).toList();
      _hiveRepository.add<List<Rentals>>(name: HiveKeys.rentals, key: HiveKeys.rentals, item: rentals);
      emit(GetRentalSuccessState(rentals: rentals));
    });
  }

  
}
