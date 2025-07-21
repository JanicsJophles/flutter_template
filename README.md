# Flutter Template

A modern, production-ready Flutter template with authentication, state management, and beautiful UI components. Built with best practices and scalable architecture.

Still in development. I use AI to speed up some processes.

## 🚀 Features

- **🔐 Clerk Authentication** - Complete authentication system with sign-in, sign-up, and user management
- **🧭 AutoRoute Navigation** - Type-safe routing with code generation
- **📊 BLoC State Management** - Scalable state management with clean architecture
- **🎨 Material Design 3** - Beautiful UI with light/dark theme support
- **📱 Responsive Design** - Works perfectly on all screen sizes
- **⚡ Performance Optimized** - Fast, smooth animations and transitions
- **🛡️ Error Handling** - Comprehensive error handling and user feedback
- **🧪 Testing Ready** - Structured for easy testing and maintenance

## 🏗️ Architecture

This template follows **Clean Architecture** principles with a feature-based folder structure:

```
lib/
├── app.dart                          # Main app configuration
├── main.dart                         # App entry point
├── core/
│   ├── config/                       # App configuration
│   ├── di/                          # Dependency injection
│   ├── services/                    # Core services
│   ├── theme/
│   │   └── app_theme.dart           # Theme configuration
│   ├── routes/
│   │   ├── router.dart              # Route definitions
│   │   └── router.gr.dart           # Generated routes
│   └── utils/
│       ├── constants.dart           # App constants
│       └── validators.dart          # Form validation utilities
├── data/
│   ├── api/                         # API services
│   ├── local/                       # Local storage
│   └── repositories/                # Data repositories
└── features/
    ├── auth/
    │   ├── bloc/                    # Authentication BLoC
    │   ├── pages/                   # Auth pages
    │   ├── services/                # Auth services
    │   ├── repository/              # Auth repository
    │   └── widgets/                 # Auth-specific widgets
    └── home/
        ├── bloc/                    # Home feature BLoCs
        ├── pages/                   # Home pages
        └── widgets/                 # Home-specific widgets
```

## 🔐 Clerk Authentication

[Clerk](https://clerk.com) is a complete authentication and user management solution that provides:

### Key Features
- **Pre-built UI Components** - Beautiful, customizable sign-in/sign-up forms
- **Multi-factor Authentication** - SMS, email, authenticator apps
- **Social Logins** - Google, GitHub, Apple, and more
- **User Management** - Profile management, account settings
- **Security** - JWT tokens, session management, security best practices

### Setup Instructions

1. **Create a Clerk Account**
   ```bash
   # Visit https://clerk.com and create an account
   ```

2. **Create a New Application**
   - Go to your Clerk dashboard
   - Click "Add Application"
   - Choose "Flutter" as your framework

3. **Get Your Keys**
   - Copy your **Publishable Key** from the Clerk dashboard
   - Replace the key in `lib/main.dart`:

   ```dart
   ClerkAuth(
     config: ClerkAuthConfig(
       publishableKey: 'pk_test_YOUR_KEY_HERE',
       loading: const Center(child: CircularProgressIndicator()),
     ),
     child: const App(),
   ),
   ```

4. **Configure Authentication Methods**
   - In your Clerk dashboard, go to "User & Authentication"
   - Enable the authentication methods you want (email, social logins, etc.)
   - Customize your sign-in/sign-up forms

### Usage in Code

```dart
// Get current user
final user = ClerkAuth.userOf(context);

// Check authentication status
final isAuthenticated = user != null;

// Sign out
await ClerkAuth.of(context, listen: false).signOut();

// Access user data
final email = user?.emailAddresses?.firstOrNull?.emailAddress;
final name = user?.firstName;
```

## 🧭 AutoRoute Navigation

[AutoRoute](https://pub.dev/packages/auto_route) provides type-safe routing with code generation.

### Key Features
- **Type Safety** - Compile-time route checking
- **Code Generation** - Automatic route generation
- **Deep Linking** - Support for deep links and web URLs
- **Nested Routes** - Complex navigation structures
- **Route Guards** - Authentication and permission checks

### Route Definition

```dart
// lib/core/routes/router.dart
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: ClerkAuthRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
```

### Usage in Code

```dart
// Navigate to a route
context.router.push(const HomeRoute());

// Replace current route
context.router.replace(const ClerkAuthRoute());

// Navigate with parameters
context.router.push(ProfileRoute(userId: '123'));

// Go back
context.router.pop();
```

### Code Generation

After defining routes, generate the route code:

```bash
flutter packages pub run build_runner build
```

## 📊 BLoC State Management

[BLoC (Business Logic Component)](https://bloclibrary.dev/) provides predictable state management.

### Key Concepts

- **Events** - User actions that trigger state changes
- **States** - Immutable data that represents the UI state
- **BLoCs** - Components that handle business logic and state transitions

### Example BLoC Structure

```dart
// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

// States
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated({required this.user});
}
class AuthUnauthenticated extends AuthState {}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // Check authentication status
    // Emit appropriate state
  }
}
```

### Usage in Widgets

```dart
// Listen to state changes
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) {
      context.router.replace(const HomeRoute());
    }
  },
  child: YourWidget(),
)

// Build UI based on state
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return CircularProgressIndicator();
    } else if (state is AuthAuthenticated) {
      return Text('Welcome ${state.user.name}');
    }
    return Text('Please sign in');
  },
)
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the template**
   ```bash
   git clone <your-repo-url>
   cd flutter_template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Clerk**
   - Follow the Clerk setup instructions above
   - Replace the publishable key in `lib/main.dart`

4. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 Customization

### Theme Customization

Edit `lib/core/theme/app_theme.dart` to customize colors and styles:

```dart
class AppTheme {
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color secondaryColor = Color(0xFF10B981);
  
  static ThemeData lightTheme = ThemeData(
    // Your custom light theme
  );
  
  static ThemeData darkTheme = ThemeData(
    // Your custom dark theme
  );
}
```

### Adding New Features

1. **Create a new feature folder** in `lib/features/`
2. **Add BLoC files** for state management
3. **Create pages and widgets**
4. **Update routing** in `lib/core/routes/router.dart`
5. **Generate routes**: `flutter packages pub run build_runner build`

Example structure:
```
lib/features/profile/
├── bloc/
│   ├── profile_bloc.dart
│   ├── profile_event.dart
│   └── profile_state.dart
├── pages/
│   └── profile_page.dart
└── widgets/
    └── profile_form.dart
```

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc: ^9.1.1` - State management
- `equatable: ^2.0.7` - Value equality
- `auto_route: ^10.1.0+1` - Navigation
- `clerk_flutter: ^0.0.10-beta` - Authentication
- `clerk_auth: ^0.0.10-beta` - Clerk SDK

### Development Dependencies
- `flutter_lints: ^5.0.0` - Code linting
- `auto_route_generator: ^10.2.3` - Route generation
- `build_runner: ^2.4.8` - Code generation

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
API_BASE_URL=https://api.example.com
```

### Build Configuration

Update `pubspec.yaml` for your app:

```yaml
name: your_app_name
description: Your app description
version: 1.0.0+1
```

## 🚀 Deployment

### Android
1. Update `android/app/build.gradle.kts`
2. Configure signing
3. Build APK: `flutter build apk --release`

### iOS
1. Update `ios/Runner/Info.plist`
2. Configure signing in Xcode
3. Build: `flutter build ios --release`

### Web
1. Build: `flutter build web --release`
2. Deploy to your hosting service

## 🧪 Testing

The template includes a basic widget test. Add more tests as needed:

```dart
// test/widget_test.dart
testWidgets('Authentication flow test', (WidgetTester tester) async {
  await tester.pumpWidget(const App());
  
  // Test authentication flow
  expect(find.byType(SplashScreen), findsOneWidget);
});
```

## 📝 Code Style

This template follows Flutter's official style guide and uses:
- **BLoC pattern** for state management
- **Feature-based architecture** for scalability
- **Consistent naming conventions**
- **Proper error handling**
- **Comprehensive documentation**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page
2. Create a new issue with detailed information
3. Contact the maintainers

## 🔄 Updates

To keep your template up to date:

```bash
git pull origin main
flutter pub get
flutter packages pub run build_runner build
```

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
- [AutoRoute Documentation](https://pub.dev/packages/auto_route)
- [Clerk Documentation](https://clerk.com/docs)
- [Material Design](https://material.io/design)

---

**Happy coding! 🎉**

Built with ❤️ using Flutter, Clerk, AutoRoute, and BLoC.
