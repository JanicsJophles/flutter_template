import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk_auth;

class AuthRepository {
  final ClerkAuthState clerk;

  AuthRepository({required this.clerk});

  Future<clerk_auth.User?> getCurrentUser() async {
    return clerk.user;
  }

  Future<void> signIn() async {}

  Future<void> signUp() async {}

  Future<void> signOut() async {
    await clerk.signOut();
  }
}
