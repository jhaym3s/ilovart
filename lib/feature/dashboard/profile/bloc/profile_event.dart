part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
 
}

class GetProfileEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}
