part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
 
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState{
  final Profile profile;

  ProfileSuccessState({required this.profile});
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileFailureState extends ProfileState{
  @override
  List<Object?> get props => [];
}


