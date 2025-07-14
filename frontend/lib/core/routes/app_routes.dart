// import 'package:flutter/material.dart';
// import 'package:frontend/core/routes/routes_constant.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class AppRoutes {
//   late GoRouter router = GoRouter(
//     // initialLocation: "/login",
//     initialLocation: "/",
//     navigatorKey: navigatorKey,

//     routes: [
//       GoRoute(
//         name: RoutesConstant.authWrapper,
//         path: '/',
//         builder: (context, state) => const AuthWrapper(),
//       ),
//       GoRoute(
//         name: RoutesConstant.login,
//         path: "/login",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: LoginScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.signup,
//         path: "/signup",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: SignupScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.dashboard,
//         path: "/dashboard",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: DashboardScreen());
//         },
//         redirect: (context, state) async {
//           final prefs = await SharedPreferences.getInstance();
//           final token = prefs.getString('token');
//           if (token == null) return '/login';
//           return null;
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.allStaff,
//         path: "/allStaff",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: AllStaffScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.createIssue,
//         path: "/createIssue",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: CreateIssueScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.room,
//         path: "/room",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: RoomAvailabilityScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.changeRoom,
//         path: "/changeRoom",
//         pageBuilder: (context, state) {
//           final requestedRoom = state.extra as String;
//           return MaterialPage(
//             child: ChangeRoomScreen(requestedRoom: requestedRoom),
//           );
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.request,
//         path: "/request",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: RoomChangeRequestScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.createStaff,
//         path: "/createStaff",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: CreateStaffScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.issue,
//         path: "/issue",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: IssueScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.profile,
//         path: "/profile",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: ProfileScreen());
//         },
//       ),
//       GoRoute(
//         name: RoutesConstant.myIssues,
//         path: "/myIssues",
//         pageBuilder: (context, state) {
//           return MaterialPage(child: MyIssueScreen());
//         },
//       ),
//     ],
//     errorPageBuilder: (context, state) {
//       return MaterialPage(
//         child: Scaffold(body: Center(child: Text("Route not found"))),
//       );
//     },
//   );
// }

//   // redirect: (BuildContext context, GoRouterState state) async {
//     //   final loggedIn = await AuthService.isLoggedIn();

//     //   final loggingIn = state.matchedLocation == '/login';

//     //   if (!loggedIn && !loggingIn) {
//     //     return '/login'; // Redirect to login if not logged in
//     //   }

//     //   if (loggedIn && loggingIn) {
//     //     return '/dashboard'; // If already logged in, go to dashboard
//     //   }

//     //   return null; // No redirection
//     // },