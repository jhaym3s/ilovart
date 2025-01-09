import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/custom_loader.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/router/router.dart';
import '../../../../core/helpers/toast_manager.dart';
import '../../domain/bloc/authentication_bloc.dart';
import 'sign_in_screen.dart';
import 'step1.dart';

class NumberVerificationScreen extends StatefulWidget {
  static const routeName = "numberVerificationScreen";
  const NumberVerificationScreen({super.key});

  @override
  State<NumberVerificationScreen> createState() =>
      _NumberVerificationScreenState();
}

class _NumberVerificationScreenState extends State<NumberVerificationScreen> {
  final _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final email = SharedPreferencesManager.getString(PrefKeys.email);
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
           if (state is VerifyOTPFailureState) {
            hideOverlayLoader(context);
            ToastManager.errorToast(context, message: state.errorMessage.capitalize);
          }
          if (state is RegisterUserSuccessState) {
            hideOverlayLoader(context);
            moveAndClearStack(context: context, page: SignInScreen.routeName);
          }
          },
          builder: (context, state) {
            if(state is VerifyOTPLoadingState){
                showOverlayLoader(context);
            }
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceY(40.dy),
                    CustomText(
                        text: "Email Validation",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700),
                    SpaceY(4.dy),
                    CustomText(
                      text:
                          "Enter the six(6) digits code sent to your Email Address. ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: kSecondaryFontFamily,
                    ),
                    SpaceY(40.dy),
                    CustomPinCodeTextField(
                      controller: _pinController,
                      onComplete: (value) {},
                      onSaved: (value) {},
                      onSubmitted: (value) {},
                    ),
                    Center(
                      child: CustomText(
                        text: "2:00 ",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: kSecondaryFontFamily,
                      ),
                    ),
                    SpaceY(16.dy),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Didn’t receive code ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: kTextColorsLight,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kSecondaryFontFamily),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Resend code',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: const Color(0xff5C4500),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: kSecondaryFontFamily),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SpaceY(25.dy),
                    CustomElevatedButton(
                        onPressed: () {
                           context.read<AuthenticationBloc>().add(
              VerifyOtpEvent(otp: _pinController.text)
             );
                          moveToNextScreen(
                              context: context, page: Step1.routeName);
                        },
                        buttonText: "Verify Code"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
