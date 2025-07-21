import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/home/pages/home_page.dart';
import 'package:flutter_template/features/auth/pages/clerk_auth_page.dart';
import 'package:flutter_template/features/auth/pages/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: ClerkAuthRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
