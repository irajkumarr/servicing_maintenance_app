import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  late GoRouter router = GoRouter(
    // initialLocation: "/login",
    initialLocation: "/navigationMenu",
    navigatorKey: navigatorKey,

    routes: [
      GoRoute(
        name: RoutesConstant.navigationMenu,
        path: "/navigationMenu",
        pageBuilder: (context, state) {
          return MaterialPage(child: NavigationMenu());
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