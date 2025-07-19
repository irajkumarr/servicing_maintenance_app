import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/dashboard/screens/home/home.dart';
import 'package:frontend/features/dashboard/screens/service/service.dart';
import 'package:frontend/features/dashboard/screens/service/service_history.dart';
import 'package:icons_plus/icons_plus.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await CustomAlertBox.alertCloseApp(context);
      },
      child: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return Scaffold(
            body: navigationProvider.screens.elementAt(
              navigationProvider.selectedIndex,
            ),

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: KColors.white,
              elevation: 1,
              // iconSize: 24,
              iconSize: 18,

              currentIndex: navigationProvider.selectedIndex,
              selectedItemColor: KColors.primary,
              // ignore: deprecated_member_use
              unselectedItemColor: KColors.dark.withOpacity(0.7),
              type: BottomNavigationBarType.fixed,

              selectedLabelStyle: TextStyle(
                color: KColors.primary,
                fontSize: 10,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
              onTap: (value) {
                navigationProvider.onTap(value);
              },

              items: [
                BottomNavigationBarItem(
                  icon: Icon(EvaIcons.home_outline),
                  label: "Home",
                  // activeIcon: Icon(Iconsax.home_1_bulk),
                ),
                BottomNavigationBarItem(
                  icon: Icon(HeroIcons.wrench),
                  label: "Services",
                  // activeIcon: Icon(Iconsax.home_1_bulk),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: "History",
                  // activeIcon: Icon(Iconsax.home_1_bulk),
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () async {
                      await context.read<LoginProvider>().logout(context);
                    },
                    icon: Icon(Iconsax.user_outline),
                  ),
                  label: "Profile",

                  // activeIcon: Icon(Iconsax.home_1_bulk),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NavigationProvider with ChangeNotifier {
  List<Widget> screens = [
    HomeScreen(),
    ServiceScreen(),
    ServiceHistoryScreen(),
    Container(color: Colors.purple),
  ];

  int selectedIndex = 0;
  void onTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
