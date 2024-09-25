import 'package:flutter/material.dart';
import 'package:travoli/core/components/custom_elevated_button.dart';
import 'package:travoli/core/configs/constants.dart';
import 'package:travoli/core/helpers/router/router.dart';
import 'package:travoli/feature/authentication/presentation/screens/sign_up_screen.dart';

import '../../../../core/configs/configs.dart';
import '../widget/onboarding_content.dart';
import 'step1.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "/onboarding";
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rippleAnimationController;
  late PageController _pageController;
  //late Animation<double> _rippleAnimation;
  int currentIndex = 0;
  static const _kDuration = Duration(milliseconds: 1000);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );
  }

  void nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  void skipFunction() {
    _pageController.animateToPage(1, duration: _kDuration, curve: _kCurve);
  }

  void onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _rippleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(children: [
      SizedBox(
        height: kScreenHeight(context).dy - 250.dy,
        child: PageView(
          controller: _pageController,
          onPageChanged: onChangedFunction,
          children:  [
            OnBoardingItem(
              image: AssetsImages.onboarding1,
              title: "Find your next home sharp sharp!",
              currentIndex: currentIndex,
              positionIndex: 0,
              positionIndex2: 1,
              description:
                  "Let’s find homes you will love at any location across Africa",
            ),
            OnBoardingItem(
             image: AssetsImages.onboarding2,
              currentIndex: currentIndex,
               positionIndex2: 1,
              positionIndex: 0,
              title: "Post your rental listing for free",
              description:
                  "As a Landlord/Project Manger make your accommodation reached out to people. Sign up and let’s get started.",
            ),
          ],
        ),
      ),
        CustomElevatedButton(onPressed:currentIndex==0? skipFunction : (){
          moveToNextScreen(context: context, page: SignUpScreen.routeName);
        }, 
       buttonText: currentIndex==0?"Next":"Get Started"),
      SpaceY(16.dy),
      //Login
      // GestureDetector(
      //    onTap: (){},
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //        Text('Already have an account? ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w700, color: const Color(0xff33383F)),),
      //       Text(
      //         "Login",
      //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w700, color: kPrimaryColor),
      //       )
      //     ],
      //   ),
      // ),
      SpaceY(32.dy)
        ]),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex;
  final int currentIndex;
  const Indicator({
    Key? key,
    required this.positionIndex,
    required this.currentIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 8.dy,
        width: 8,
        decoration: BoxDecoration(
          // border: Border.all(color: k),
          color: positionIndex == currentIndex
              ? kPrimaryColor
              : Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

