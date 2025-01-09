import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/authentication/presentation/screens/number_verification.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_in_screen.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_up_screen.dart';
import '../../../../core/components/components.dart';
import '../../../../core/components/custom_loader.dart';
import '../../domain/bloc/authentication_bloc.dart';

class Step1 extends StatefulWidget {
  static const routeName = "step1";
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  late int action;
  @override
  void initState() {
    action = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = SharedPreferencesManager.getStringList(PrefKeys.signUpDetails) ;
    return Scaffold(
      //backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.dx),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state is RegisterUserFailureState) {
            hideOverlayLoader(context);
            //moveAndClearStack(context: context, page: SignUpScreen.routeName);
            ToastManager.errorToast(context, message: state.errorMessage.capitalize);
          }
          if (state is RegisterUserSuccessState) {
             context.read<AuthenticationBloc>().add(
              RequestOtpEvent()
             );
          }
          if (state is RequestOTPSuccessState) {
          hideOverlayLoader(context);
          moveAndClearStack(context: context, page: NumberVerificationScreen.routeName );
          }
           if (state is RequestOTPFailureState) {
            hideOverlayLoader(context);
             //moveAndClearStack(context: context, page: SignUpScreen.routeName);
            ToastManager.errorToast(context, message: state.errorMessage.capitalize);
          }
              },
              builder: (context, state) {
                if (state is RegisterUserLoadingState){
                    showOverlayLoader(context);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceY(20.dy),
                    // CustomText(
                    //   text: "Step 1/2 ",
                    //   fontSize: 12.sp,
                    //   fontWeight: FontWeight.w700,
                    //   color: const Color(0xff45403B),
                    // ),
                    SpaceY(16.dy),
                    CustomText(
                        text: "What are you looking for?",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700),
                    SpaceY(4.dy),
                    CustomText(
                      text:
                          "Let’s get you started with your favorite place or house listing with ease. No fear! You can change this later. ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: kSecondaryFontFamily,
                    ),
                    SpaceY(24.dy),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              action = 1;
                            });
                            
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.dx,vertical: 20.dy),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: action == 1
                                        ? const Color(0xff5C4500)
                                        : const Color(0xffE0DFDF))),
                            child: Column(
                              children: [
                                Image.asset(
                                  AssetsImages.rentHouse,
                                  height: 32.dy,
                                  width: 32.dx,
                                ),
                                SpaceY(8.dy),
                                CustomText(
                                    text: "Rent House",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              action = 2;
                            });
                          },
                          child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 30.dx,vertical: 20.dy),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: action == 2
                                        ? const Color(0xff5C4500)
                                        : const Color(0xffE0DFDF))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsImages.listHouse,
                                  height: 32.dy,
                                  width: 32.dx,
                                ),
                                SpaceY(8.dy),
                                CustomText(
                                    text: "List House",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SpaceY(48.dy),
                    CustomElevatedButton(
                        onPressed: () {
                         context.read<AuthenticationBloc>().add(
                                  RegisterUserEvent(
                                      password: data[4],
                                      firstName: data[0],
                                      lastName: data[1],
                                      phoneNumber: data[3],
                                      isAgent: action==1?false: true,
                                      email: data[2]));
                        },
                        buttonText: "Next Step"),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
