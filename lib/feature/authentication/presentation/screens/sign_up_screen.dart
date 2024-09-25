import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travoli/core/components/components.dart';
import 'package:travoli/core/components/custom_loader.dart';
import 'package:travoli/core/configs/configs.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_in_screen.dart';

//import 'number_verification.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/shared_preference_manager.dart';
import '../../domain/bloc/authentication_bloc.dart';
import 'step1.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "signUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          SingleChildScrollView(
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
                          text: "The best home experiences",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                      SpaceY(4.dy),
                      CustomText(
                        text:
                            "Register and let’s connect you to the best accommodation offers in Nigeria.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(20.dy),
                      NormalTextFormField(
                          hintText: "First Name",
                          labelText: "First Name",
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'),
                                allow: true)
                          ],
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'First Name can not be blank';
                            }
                            return null;
                          }),
                      SpaceY(12.dy),
                      NormalTextFormField(
                          hintText: "Last Name",
                          labelText: "Last Name",
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'),
                                allow: true)
                          ],
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Last Name can not be blank ';
                            }
                            return null;
                          }),
                      SpaceY(4.dy),
                      CustomText(
                        text:
                            "Make sure this name matches what you have on an Official ID.",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffA1A1A1),
                        fontFamily: kSecondaryFontFamily,
                      ),
                      SpaceY(12.dy),
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
                            if (!value!.emailIsValidated()) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          }),
                      SpaceY(12.dy),
                      NormalTextFormField(
                          hintText: "09012345678",
                          labelText: "Phone Number",
                          controller: numberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number ';
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
                          if (!value.passwordValidator()) {
                            return "Password must contain a number, special character, uppercase and lowercase letter";
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
                      RichText(
                        text: TextSpan(
                          text: 'By clicking continue, I agree with Travoli’s ',
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
                              text: 'Terms ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: const Color(0xff5C4500),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: kFontFamily),
                            ),
                            const TextSpan(text: ' and'),
                            TextSpan(
                              text: ' Conditions',
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
                      SpaceY(25.dy),
                      CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //context.read<AuthenticationBloc>().add(
                                  // RegisterUserEvent(
                                  //     password: passwordController.text,
                                  //     firstName: firstNameController.text,
                                  //     lastName: lastNameController.text,
                                  //     phoneNumber: numberController.text,
                                  //     isAgent: false,
                                  //     email: emailController.text));
                               Navigator.pushNamed(context, Step1.routeName,
                               arguments: {
                                    "password": passwordController.text,
                                      "firstName": firstNameController.text,
                                      "lastName": lastNameController.text,
                                      "phoneNumber": numberController.text,
                                      "email": emailController.text
                               });
                                SharedPreferencesManager.setStringList(PrefKeys.signUpDetails, [firstNameController.text, lastNameController.text,emailController.text, numberController.text,passwordController.text]);
                              //moveToNextScreen(context: context, page: Step1.routeName);
                            }
                          },
                          buttonText: "Continue"),
                          SpaceY(15.dy),
                        GestureDetector(
                          onTap: (){
                            moveAndClearStack(context: context, page: SignInScreen.routeName);
                          },
                          child: Center(
                            child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
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
                                  text: 'Sign in ',
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
          ),
    );
  }
}
