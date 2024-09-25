import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_option_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ProfileInitial) {
                                   context.read<ProfileBloc>().add(GetProfileEvent());
                                }
                return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           (state is ProfileSuccessState)?
                                CustomText(
                                  text: "Hi ${state.profile.firstName}",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff0B0B0B),
                                  fontFamily: kSecondaryFontFamily,
                                ):  CustomText(
                                  text: "Hi :)",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff0B0B0B),
                                  fontFamily: kSecondaryFontFamily,
                                ),
                SpaceY(32.dx),
                CustomText(text: "Personal Information", fontSize: 10.sp, fontWeight: FontWeight.w700),
                SpaceY(16.dy),
                CustomText(text: "Full Name", fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xff121619),),
                SpaceY(8.dy),
                CustomText(text: (state is ProfileSuccessState)? "${state.profile.firstName}": "...", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                SpaceY(16.dy),
                CustomText(text: "Phone Number", fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xff121619),),
                SpaceY(8.dy),
                CustomText(text: (state is ProfileSuccessState)? "${state.profile.phoneNumber}": "...", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                SpaceY(16.dy),
                CustomText(text: "Email Address", fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xff121619),),
                SpaceY(8.dy),
                CustomText(text: (state is ProfileSuccessState)? "${state.profile.email}": "...", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                SpaceY(16.dy),
                CustomText(text: "Password", fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xff121619),),
                SpaceY(8.dy),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "********", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: kBlack, 
                        )
                      ),
                      child: CustomText(text: "Change Password", fontSize: 16.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SpaceY(32.dx),
                CustomText(text: "Support", fontSize: 10.sp, fontWeight: FontWeight.w800),
                SpaceY(24.dy),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outlined, size: 25,),
                        SpaceX(8.dy),
                        CustomText(text: "About Travoli", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                SpaceY(16.dx),
                Row(       
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AssetsImages.helpCenter, height: 25.dy, width: 25.dx),
                        SpaceX(8),
                        CustomText(text: "Help", fontSize: 14.sp, fontWeight: FontWeight.w700,color: Color(0xff121619),),
                      ],
                    ),
                  Icon(Icons.arrow_forward_ios)
                  ],
                ),
                 SpaceY(32.dx),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_sharp),
                    CustomText(text: "Sign out", fontSize: 16.sp, fontWeight: FontWeight.w500,),
                  ],
                ),

              ],
              );
  }),
        ),
      ),
    ));
  }
}
