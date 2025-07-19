import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/success_screen/success.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/features/authentication/screens/login/login.dart';
import 'package:frontend/features/authentication/screens/signup/signup.dart';
import 'package:frontend/features/authentication/screens/splash/splash.dart';
import 'package:frontend/features/authentication/screens/verification/otp_verification.dart';
import 'package:frontend/features/dashboard/screens/home/home.dart';
import 'package:frontend/features/dashboard/screens/service/service_booking_screen.dart';
import 'package:frontend/features/dashboard/screens/service/service_confirm.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  late GoRouter router = GoRouter(
    // initialLocation: "/bookConfirm",
    initialLocation: "/navigationMenu",
    navigatorKey: navigatorKey,

    routes: [
      // GoRoute(
      //   name: RoutesConstant.authWrapper,
      //   path: "/",
      //   pageBuilder: (context, state) {
      //     return MaterialPage(child: AuthWrapper());
      //   },
      // ),
      GoRoute(
        name: RoutesConstant.splash,
        path: "/",
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: RoutesConstant.navigationMenu,
        path: "/navigationMenu",
        pageBuilder: (context, state) {
          return MaterialPage(child: NavigationMenu());
        },
        redirect: (context, state) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token == null) return '/login';
          return null;
        },
      ),
      GoRoute(
        name: RoutesConstant.login,
        path: "/login",
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: RoutesConstant.signup,
        path: "/signup",
        pageBuilder: (context, state) {
          return MaterialPage(child: SignupScreen());
        },
      ),
      GoRoute(
        name: RoutesConstant.otpVerify,
        path: "/otpVerify",
        pageBuilder: (context, state) {
          final email = state.extra as String;
          return MaterialPage(child: OtpVerificationScreen(email: email));
        },
      ),
      GoRoute(
        name: RoutesConstant.otpSuccess,
        path: "/otpSuccess",
        pageBuilder: (context, state) {
          return MaterialPage(child: SuccessScreen());
        },
      ),
      GoRoute(
        name: RoutesConstant.home,
        path: "/home",
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        },
      ),
      GoRoute(
        name: RoutesConstant.book,
        path: "/book",
        pageBuilder: (context, state) {
          final serviceId = state.extra as String;
          return MaterialPage(
            child: ServiceBookingScreen(serviceId: serviceId),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.bookConfirm,
        path: "/bookConfirm",
        pageBuilder: (context, state) {
          final bookingId = state.extra as String;
          return MaterialPage(
            child: ServiceConfirmScreen(bookingId: bookingId),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(body: Center(child: Text("Route not found"))),
      );
    },
  );
}

  // redirect: (BuildContext context, GoRouterState state) async {
    //   final loggedIn = await AuthService.isLoggedIn();

    //   final loggingIn = state.matchedLocation == '/login';

    //   if (!loggedIn && !loggingIn) {
    //     return '/login'; // Redirect to login if not logged in
    //   }

    //   if (loggedIn && loggingIn) {
    //     return '/dashboard'; // If already logged in, go to dashboard
    //   }

    //   return null; // No redirection
    // },