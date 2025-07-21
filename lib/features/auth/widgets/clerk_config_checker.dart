import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class ClerkConfigChecker extends StatelessWidget {
  const ClerkConfigChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Clerk Configuration',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                try {
                  final authState = ClerkAuth.of(context, listen: false);
                  final env = authState.env;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Publishable Key: ${authState.config.publishableKey.substring(0, 20)}...',
                      ),
                      const SizedBox(height: 4),
                      Text('Environment: ${env.toString()}'),
                      const SizedBox(height: 4),
                      Text('User Settings: ${env.user.toString()}'),
                      const SizedBox(height: 4),
                      Text(
                        'Password Settings: ${env.user.passwordSettings.toString()}',
                      ),
                    ],
                  );
                } catch (e) {
                  return Text('Error loading config: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
