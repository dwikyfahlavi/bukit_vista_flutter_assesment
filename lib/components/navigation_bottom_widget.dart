import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBottomWidget extends StatelessWidget {
  const NavigationBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<GuestProvider>(builder: (context, value, _) {
        return FluidNavBar(
          animationFactor: 1,
          onChange: ((selectedIndex) {
            value.setBottomNavItem(selectedIndex);
          }),
          icons: [
            FluidNavBarIcon(icon: Icons.home, extras: {"label": "Dashboard"}),
            FluidNavBarIcon(icon: Icons.account_balance_wallet, extras: {"label": "Finance"}),
            FluidNavBarIcon(icon: Icons.notifications, extras: {"label": "Notification"}),
            FluidNavBarIcon(icon: Icons.person, extras: {"label": "Profile"}),
          ],
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.grey[50],
              iconUnselectedForegroundColor: Colors.grey[800],
              iconSelectedForegroundColor: const Color(0xff3B9DF6)),
          scaleFactor: 1.5,
          defaultIndex: value.bottomNavItem,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        );
      });
}
