import 'package:flutter/material.dart';

import 'package:flutter_template/core/routes/router.dart';
import 'package:flutter_template/core/theme/app_theme.dart';
import 'package:flutter_template/features/auth/widgets/auth_wrapper.dart';
import 'package:flutter_template/features/auth/widgets/auth_listener.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (context, child) {
        return AuthWrapper(
          child: AuthListener(
            child: MediaQuery(
              data:
                  MediaQuery.maybeOf(
                    context,
                  )?.copyWith(textScaler: const TextScaler.linear(1.0)) ??
                  const MediaQueryData().copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
