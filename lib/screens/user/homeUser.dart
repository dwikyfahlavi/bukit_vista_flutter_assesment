import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/dashboard.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/finance.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/notification.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/profile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUser createState() => _HomeUser();
}

class _HomeUser extends State<HomeUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final value = Provider.of<GuestProvider>(context, listen: false);
      await value.getAllGuest();
    });
  }

  @override
  Widget build(BuildContext context) => buildPages();

  Widget buildPages() {
    final provider = Provider.of<GuestProvider>(context);
    final navigationItem = provider.bottomNavItem;

    switch (navigationItem) {
      case 0:
        return Dashboard();
      case 1:
        return FinanceScreen();
      case 2:
        return NotificationScreen();
      case 3:
        return ProfileScreen();
    }
    return Dashboard();
  }
}
