import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_template/features/auth/bloc/auth_bloc.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) =>
          AuthBloc(clerk: ClerkAuth.of(context, listen: false)),
      child: child,
    );
  }
}
