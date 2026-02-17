import 'dart:async';
import 'dart:developer';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Catch Flutter framework errors
    FlutterError.onError = (details) {
      log('Flutter Error', error: details.exception, stackTrace: details.stack);
      if (kReleaseMode) {
        // Here you would send to Crashlytics or Sentry
      }
    };

    // Catch platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      log('Platform Error', error: error, stackTrace: stack);
      return true;
    };

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    const clerkKey = String.fromEnvironment(
      'CLERK_PUBLISHABLE_KEY',
      defaultValue: 'pk_test_bXVzaWNhbC1sb3VzZS0xMi5jbGVyay5hY2NvdW50cy5kZXYk',
    );

    runApp(
      ClerkAuth(
        config: ClerkAuthConfig(
          publishableKey: clerkKey,
          loading: const Center(child: CircularProgressIndicator()),
        ),
        child: const App(),
      ),
    );
  }, (error, stack) {
    log('Zoned Guarded Error', error: error, stackTrace: stack);
  });
}
