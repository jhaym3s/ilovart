part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  
}

final class FilterInitial extends FilterState {
  @override
  List<Object?> get props => [];
}

class ApplyFilterLoadingState extends FilterState{
  @override
  List<Object?> get props => [];
}

class ApplyFilterSuccessState extends FilterState{
  final List<Rentals> rentals;
  ApplyFilterSuccessState({required this.rentals});
  @override
  List<Object?> get props => [rentals];
}

class ApplyFilterFailureState extends FilterState{
  final String errorMessage;
  ApplyFilterFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
