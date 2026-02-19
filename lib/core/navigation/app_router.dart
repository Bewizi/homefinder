import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/variables/app_svg.dart';
import 'package:homefinder/features/auth/presentaion/pages/forgot/forgot_password.dart';
import 'package:homefinder/features/auth/presentaion/pages/signin/sign_in.dart';
import 'package:homefinder/features/auth/presentaion/pages/signup/sign_up.dart';
import 'package:homefinder/features/getStarted/get_started.dart';
import 'package:homefinder/features/home/presentation/pages/home_screen.dart';
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

//MAIN APP SHELL WITH BOTTOM NAV  (NESTESD ROUTING)
@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeBranchData>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home')],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
  }
}

// Branch data classes
class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

// Route classes (no annotations for nested routes)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

// Bottom nav scaffold
class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kExplore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kSaved),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kMessages),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppSvg.kProfile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
