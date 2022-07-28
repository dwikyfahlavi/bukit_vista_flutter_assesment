import 'package:bukit_vista_flutter_assesment/components/card_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/header_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/navigation_bottom_widget.dart';
import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/detail_guest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const HeaderWidget(
        title: "Guest List",
        displaySearchField: true,
      ),
      body: Consumer<GuestProvider>(
        builder: (context, value, _) {
          final isLoading = value.state == GuestProviderState.loading;
          final isError = value.state == GuestProviderState.error;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (isError) {
            return const Center(
              child: Text("No data result"),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              itemCount: value.baru!.isEmpty ? value.guest?.length : value.baru?.length,
              itemBuilder: (context, index) {
                final data = value.guest?[index];

                return CardWidget(
                  imgUrl: "${value.baru!.isEmpty ? data?.imgUrl : value.baru?[index].imgUrl}",
                  title: "${value.baru!.isEmpty ? data?.name : value.baru?[index].name}",
                  subtitle: "${value.baru!.isEmpty ? data?.location : value.baru?[index].location}",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGuest(index: index)));
                  },
                );
              });
        },
      ),
      bottomNavigationBar: const NavigationBottomWidget(),
    );
  }
}
