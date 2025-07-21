import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_template/features/auth/bloc/auth_state.dart';

class AuthDebug extends StatelessWidget {
  const AuthDebug({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final clerkUser = ClerkAuth.userOf(context);

        return Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Auth Debug Info',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('BLoC State: ${state.runtimeType}'),
                Text(
                  'Clerk User: ${clerkUser != null ? "Authenticated" : "Not Authenticated"}',
                ),
                if (clerkUser != null) ...[
                  Text('User ID: ${clerkUser.id}'),
                  Text(
                    'Email: ${clerkUser.emailAddresses?.firstOrNull?.emailAddress ?? "N/A"}',
                  ),
                ],
                if (state is AuthAuthenticated) ...[
                  Text('BLoC User ID: ${state.user.id}'),
                ],
                if (state is AuthFailure) ...[Text('Error: ${state.message}')],
              ],
            ),
          ),
        );
      },
    );
  }
}
