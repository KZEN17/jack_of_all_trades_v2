import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/widgets/layouts/client_layout.dart';
import 'package:jack_of_all_trades/widgets/layouts/handyman_layout.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/common/chat_screen.dart';
import '../../features/common/notofications_screen.dart';
import '../../features/common/profile_screen.dart';
import '../../features/home/booking_history_screen.dart';
import '../../features/home/booking_screen.dart';
import '../../features/home/client_home_screen.dart';
import '../../features/home/handyman_home_screen.dart';
import '../../features/home/jobs_screen.dart';
import '../../features/home/service_details_screen.dart';
import '../../features/home/service_list_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/user_type_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Onboarding and auth routes
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/user-type',
        builder: (context, state) => const UserTypeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      // GoRoute(
      //   path: '/forgot-password',
      //   builder: (context, state) => const ForgotPasswordScreen(),
      // ),

      // Client routes
      ShellRoute(
        builder: (context, state, child) => ClientLayout(child: child),
        routes: [
          GoRoute(
            path: '/client/home',
            builder: (context, state) => const ClientHomeScreen(),
          ),
          GoRoute(
            path: '/client/services',
            builder: (context, state) => const ServiceListScreen(),
          ),
          GoRoute(
            path: '/client/services/:id',
            builder: (context, state) {
              final serviceId = state.pathParameters['id']!;
              return ServiceDetailsScreen(serviceId: serviceId);
            },
          ),
          GoRoute(
            path: '/client/book/:serviceId',
            builder: (context, state) {
              final serviceId = state.pathParameters['serviceId']!;
              return BookingScreen(serviceId: serviceId);
            },
          ),
          GoRoute(
            path: '/client/bookings',
            builder: (context, state) => const BookingHistoryScreen(),
          ),
          GoRoute(
            path: '/client/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Handyman routes
      ShellRoute(
        builder: (context, state, child) => HandymanLayout(child: child),
        routes: [
          GoRoute(
            path: '/handyman/home',
            builder: (context, state) => const HandymanHomeScreen(),
          ),
          GoRoute(
            path: '/handyman/jobs',
            builder: (context, state) => const JobsScreen(),
          ),
          GoRoute(
            path: '/handyman/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Common routes
      GoRoute(
        path: '/chat/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return ChatScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text(
              'Page not found: ${state.error}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
  );
}
