import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
