import 'package:frontend/core/network/connectivity_provider.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/providers/timer_provider.dart';
import 'package:frontend/features/dashboard/providers/service_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => PasswordProvider()),
    ChangeNotifierProvider(create: (_) => ResendTimerProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => ServiceProvider()),
  ];
}
