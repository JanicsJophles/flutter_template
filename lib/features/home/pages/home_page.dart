import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_template/core/routes/router.dart';
import 'package:flutter_template/core/theme/app_theme.dart';
import 'package:flutter_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_template/features/auth/bloc/auth_event.dart';
import 'package:flutter_template/features/auth/bloc/auth_state.dart';
import 'package:flutter_template/features/auth/services/auth_service.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || _isDisposed) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (!mounted || _isDisposed) {
                return const SizedBox.shrink();
              }

              if (state is AuthAuthenticated) {
                return IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    if (!mounted || _isDisposed) return;
                    _showMenu(context, state);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (!mounted || _isDisposed) return;

          if (state is AuthUnauthenticated) {
            context.router.replace(const ClerkAuthRoute());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AuthService(
                            ClerkAuth.of(context, listen: false),
                          ).getUserDisplayName(state.user),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AuthService(
                                ClerkAuth.of(context, listen: false),
                              ).getUserEmail(state.user) ??
                              '',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 32),

              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              _buildActionCard(
                context,
                icon: Icons.person,
                title: 'Profile',
                subtitle: 'View and edit your profile',
                onTap: () {}, // Will be implemented later
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppTheme.primaryColor),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfile(BuildContext context, AuthAuthenticated state) {
    if (!mounted || _isDisposed) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${AuthService(ClerkAuth.of(context, listen: false)).getUserDisplayName(state.user)}',
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${AuthService(ClerkAuth.of(context, listen: false)).getUserEmail(state.user) ?? 'N/A'}',
            ),
            const SizedBox(height: 8),
            Text('User ID: ${state.user.id}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context, AuthAuthenticated state) {
    if (!mounted || _isDisposed) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                AuthService(
                  ClerkAuth.of(context, listen: false),
                ).getUserDisplayName(state.user),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _showProfile(context, state);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(const AuthSignOutRequested());
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
