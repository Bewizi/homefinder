import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/features/getStarted/get_started.dart';

part 'app_router.g.dart';

final appRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: GetStartedRoute.path,
);

@TypedGoRoute<GetStartedRoute>(path: '/')
class GetStartedRoute extends GoRouteData with $GetStartedRoute {
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) => const GetStarted();
}
