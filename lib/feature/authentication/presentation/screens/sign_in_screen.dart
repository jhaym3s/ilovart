import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/configs/storage_box.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/shared_preference_manager.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/dashbord.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/custom_loader.dart';
import '../../../../core/helpers/router/router.dart';
import '../../../dashboard/agent_dashboard.dart';
import '../../domain/bloc/authentication_bloc.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "signInScreen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final tenant = SharedPreferencesManager.getBool(PrefKeys.isTenant);
    return  Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginUserFailureState) {
          hideOverlayLoader(context);
          ToastManager.errorToast(context, message:state.errorMessage.capitalize);
          }
          if (state is LoginUserSuccessState) {
            hideOverlayLoader(context);
            moveAndClearStack(context: context, page: state.isAgent? AgentCustomNavigationBar.routeName: CustomNavigationBar.routeName);
          }
        },
        builder: (context, state) {
          if (state is LoginUserLoadingState) {
            showOverlayLoader(context);
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dx),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceY(20.dy),
                      CustomText(
                          text: "Welcome Home",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                      SpaceY(4.dy),
                      CustomText(
                        text:
                            "Sign in and connect you to the best accommodation offers in Nigeria.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(20.dy),
                      NormalTextFormField(
                          hintText: "Email",
                          labelText: "Email Address",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.emailIsValidated()) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          }),
                      SpaceY(12.dy),
                      PasswordTextFormField(
                        hintText: "*******",
                        labelText: "Password",
                        controller: passwordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        hidePassword: hidePassword,
                        suffixFunction: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      SpaceY(12.dy),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                        text:
                            "Forgot Password?",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: kFontFamily,
                        color: const Color(0xff5C4500),
                      ),
                      ),
                      SpaceY(25.dy),
                      CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthenticationBloc>().add(
                                  LoginUserEvent(
                                      password: passwordController.text,
                                      email: emailController.text));
                              //  Navigator.pushNamed(context, Step1.routeName,);
                              //moveToNextScreen(context: context, page: Step1.routeName);
                            }
                          },
                          buttonText: "Continue"),
                          SpaceY(15.dy),
                        GestureDetector(
                          onTap: (){
                            moveAndClearStack(context: context, page: SignUpScreen.routeName);
                          },
                          child: Center(
                            child: RichText(
                            text: TextSpan(
                              text: 'New to Travoli? ',
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
                                  text: 'Sign up ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: const Color(0xff5C4500),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: kFontFamily),
                                ),
                                
                              ],
                            ),
                                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}