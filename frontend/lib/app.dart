import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/providers/app_providers.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiProvider(
          providers: AppProviders.providers,
          child: MaterialApp.router(
            title: 'ServiceOnWheels',
            theme: KAppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoutes().router,
          ),
        );
      },
    );
  }
}
