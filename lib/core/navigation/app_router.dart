import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/features/auth/presentaion/pages/forgot/forgot_password.dart';
import 'package:homefinder/features/auth/presentaion/pages/signin/sign_in.dart';
import 'package:homefinder/features/auth/presentaion/pages/signup/sign_up.dart';
import 'package:homefinder/features/getStarted/get_started.dart';
import 'package:homefinder/features/onboarding/onboarding_screen.dart';
import 'package:homefinder/features/splash_screen/splash_screen.dart';

part 'app_router.g.dart';

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: SplashScreenRoute.path,
);

@TypedGoRoute<SplashScreenRoute>(path: SplashScreenRoute.path)
class SplashScreenRoute extends GoRouteData with $SplashScreenRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<GetStartedRoute>(path: GetStartedRoute.path)
class GetStartedRoute extends GoRouteData with $GetStartedRoute {
  static const path = '/get-started';

  @override
  Widget build(BuildContext context, GoRouterState state) => const GetStarted();
}

@TypedGoRoute<OnboardingRoute>(path: OnboardingRoute.path)
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  static const path = '/onboarding';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

@TypedGoRoute<SignUpRoute>(path: SignUpRoute.path)
class SignUpRoute extends GoRouteData with $SignUpRoute {
  static const path = '/sign-up';

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUp();
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData with $SignInRoute {
  static const path = '/sign-in';

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignIn();
}

@TypedGoRoute<ForgotPasswordRoute>(path: ForgotPasswordRoute.path)
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  static const path = '/forgot-password';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPassword();
}
