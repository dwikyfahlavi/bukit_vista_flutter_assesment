import 'package:bukit_vista_flutter_assesment/components/header_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/navigation_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: "Notification",
        displaySearchField: false,
      ),
      body: Center(child: Text("Notification")),
      bottomNavigationBar: NavigationBottomWidget(),
    );
  }
}
