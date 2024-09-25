import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travoli/feature/dashboard/profile/domain/services/profile_service.dart';

import '../domain/modals/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileService profileService;
  ProfileBloc({required this.profileService}) : super(ProfileInitial()) {
    on<GetProfileEvent>(getProfile);
  }

  FutureOr<void> getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    final userProfile = await profileService.getProfile();
    userProfile.fold((l) {
       print("profile $l");
      emit(ProfileFailureState());
    }, 
    (r) {
      final profile = Profile.fromJson(r["data"]);
      emit(ProfileSuccessState(profile: profile));
    });
  }
}
