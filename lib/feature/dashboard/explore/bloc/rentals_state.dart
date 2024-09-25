part of 'rentals_bloc.dart';

sealed class RentalsState extends Equatable {

}

final class RentalsInitial extends RentalsState {
  @override
  List<Object?> get props => [];
}

class GetRentalSuccessState extends RentalsState{
  final List<Rentals> rentals;

  GetRentalSuccessState({required this.rentals}); 
  @override
  List<Object?> get props => [];
}

class GetRentalFailureState extends RentalsState{
  final String errorMessage;

  GetRentalFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class GetRentalLoadingState extends RentalsState{
  @override
  List<Object?> get props => [];
}

