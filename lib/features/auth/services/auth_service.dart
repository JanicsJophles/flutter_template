import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk_auth;

class AuthService {
  final ClerkAuthState _clerk;

  AuthService(this._clerk);

  clerk_auth.User? get currentUser => _clerk.user;

  bool get isAuthenticated => _clerk.user != null;

  Future<void> signOut() async {
    await _clerk.signOut();
  }

  String getUserDisplayName(clerk_auth.User user) {
    if (user.firstName != null && user.lastName != null) {
      return '${user.firstName} ${user.lastName}';
    } else if (user.firstName != null) {
      return user.firstName!;
    } else if (user.lastName != null) {
      return user.lastName!;
    } else if (user.username != null) {
      return user.username!;
    } else {
      return 'User';
    }
  }

  String? getUserEmail(clerk_auth.User user) {
    return user.emailAddresses?.firstOrNull?.emailAddress;
  }
}
