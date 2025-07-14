import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityChecker(
      // ignore: deprecated_member_use
      child: WillPopScope(
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
                unselectedItemColor: KColors.darkGrey,
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
                    icon: Icon(Iconsax.home_2),
                    label: "Home",
                    activeIcon: Icon(Iconsax.home_25),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2),
                    label: "Home",
                    activeIcon: Icon(Iconsax.home_25),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2),
                    label: "Home",
                    activeIcon: Icon(Iconsax.home_25),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2),
                    label: "Home",
                    activeIcon: Icon(Iconsax.home_25),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NavigationProvider with ChangeNotifier {
  List<Widget> screens = [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.pink),
    Container(color: Colors.purple),
  ];

  int selectedIndex = 0;
  void onTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
