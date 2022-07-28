import 'package:bukit_vista_flutter_assesment/components/header_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/navigation_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: "Finance",
        displaySearchField: false,
      ),
      body: Center(child: Text("Finance")),
      bottomNavigationBar: NavigationBottomWidget(),
    );
  }
}
