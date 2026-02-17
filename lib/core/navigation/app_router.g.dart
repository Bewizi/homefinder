// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$splashScreenRoute];

RouteBase get $splashScreenRoute => GoRouteData.$route(
  path: '/',
  factory: $SplashScreenRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'get-started',
      factory: $GetStartedRoute._fromState,
    ),
  ],
);

mixin $SplashScreenRoute on GoRouteData {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      SplashScreenRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GetStartedRoute on GoRouteData {
  static GetStartedRoute _fromState(GoRouterState state) => GetStartedRoute();

  @override
  String get location => GoRouteData.$location('/get-started');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
