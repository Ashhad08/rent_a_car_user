import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/extensions.dart';
import '../../../../domain/services/session_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../auth/login_sign_up_view.dart';
import '../../home_view/home_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _primaryController = PageController();
  final _secondaryController = PageController();

  final List<(String, String, String)> _onboardingData = [
    (
      'Instant Car Rental',
      'Browse, select, and book your ideal vehicle in minutes. From compact cars to luxury SUVs, find the perfect ride for any occasion.',
      Assets.imagesOnboarding1,
    ),
    (
      'Flexible Booking Options',
      'Enjoy hassle-free rentals with flexible pick-up and drop-off locations. Real-time availability and instant confirmations make travel planning a breeze.',
      Assets.imagesOnboarding2,
    ),
    (
      'Seamless Travel Experience',
      'Transparent pricing, detailed vehicle information, and 24/7 customer support. Your journey starts with just a few taps on our user-friendly app.',
      Assets.imagesOnboarding3,
    ),
  ];

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _primaryController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => Image.asset(
                _onboardingData[index].$3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: ListenableBuilder(
                listenable: _primaryController,
                builder: (context, _) {
                  final isLastPage = _primaryController.hasClients &&
                      (_primaryController.page?.round() ?? 0) == 2;

                  return isLastPage
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: () async {
                            await Future.wait([
                              _primaryController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              ),
                              _secondaryController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              ),
                            ]);
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SafeArea(
              child: Image.asset(
                Assets.imagesAppLogo,
                height: 60,
                width: 60,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: context.colorScheme.scrim.withOp(0.1),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 1.5,
                            colors: [
                              Colors.transparent,
                              context.colorScheme.scrim.withOp(0.3),
                            ],
                            stops: [0.8, 1.0],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 35),
                      child: Column(
                        children: [
                          PageView.builder(
                            controller: _secondaryController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _onboardingData.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Text(
                                  _onboardingData[index].$1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
                                10.height,
                                Text(
                                  _onboardingData[index].$2,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ).space(
                            height: context.screenHeight * 0.15,
                            width: double.infinity,
                          ),
                          SmoothPageIndicator(
                            controller: _primaryController,
                            count: _onboardingData.length,
                            effect: WormEffect(
                              dotWidth: 16,
                              dotHeight: 6,
                              radius: 10,
                              activeDotColor: context.colorScheme.primary,
                              dotColor: context.colorScheme.outline,
                            ),
                          ),
                          24.height,
                          ListenableBuilder(
                            listenable: Listenable.merge([
                              _primaryController,
                              _secondaryController,
                            ]),
                            builder: (context, _) {
                              final isLastPage = _primaryController
                                      .hasClients &&
                                  (_primaryController.page?.round() ?? 0) == 2;

                              return ElevatedButton(
                                onPressed: () async {
                                  if (isLastPage) {
                                    final isLoggedIn =
                                        await SessionManager().isLoggedIn();
                                    await Future.delayed(
                                        const Duration(seconds: 3));
                                    if (!mounted || !context.mounted) return;
                                    if (isLoggedIn) {
                                      getIt<NavigationHelper>().pushReplacement(
                                          context, const HomeView());
                                    } else {
                                      getIt<NavigationHelper>().pushReplacement(
                                          context, const LoginSignUpView());
                                    }
                                  } else {
                                    await Future.wait([
                                      _primaryController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      ),
                                      _secondaryController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      ),
                                    ]);
                                  }
                                },
                                child: Text(
                                  isLastPage ? 'Let\'s Ride' : 'Continue',
                                ),
                              ).space(height: 54, width: double.infinity);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
