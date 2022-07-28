import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bukit_vista_flutter_assesment/components/card_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/header_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/navigation_bottom_widget.dart';
import 'package:bukit_vista_flutter_assesment/components/theme.dart';
import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class DetailGuest extends StatefulWidget {
  final int index;
  const DetailGuest({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailGuest> createState() => _DetailGuestState();
}

class _DetailGuestState extends State<DetailGuest> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        Provider.of<GuestProvider>(context, listen: false).changeTabIndex(0);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: HeaderWidget(
          title: "Guest Details",
          displaySearchField: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Provider.of<GuestProvider>(context, listen: false).changeTabIndex(0);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Consumer<GuestProvider>(builder: (context, value, _) {
          final data = value.guest?[widget.index];
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: CardWidget(
                    imgUrl: "${data?.imgUrl}",
                    title: "${data?.name}",
                    subtitle:
                        "Guest since ${DateFormat('MMMM').format(data!.guestSince as DateTime)} ${data.guestSince?.year}",
                  ),
                ),
                DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          child: TabBar(
                            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                            indicatorWeight: 1,
                            onTap: (v) async {
                              await value.changeTabIndex(v);
                            },
                            tabs: [
                              Tab(
                                text: "Overview",
                              ),
                              Tab(
                                text: "Bookings",
                              ),
                              Tab(
                                text: "Personas",
                              ),
                            ],
                            labelColor: Color(0xFF3B9DF6),
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: MaterialIndicator(
                              color: Color(0xFF3B9DF6),
                              height: 6,
                              topLeftRadius: 0,
                              topRightRadius: 0,
                              bottomLeftRadius: 5,
                              bottomRightRadius: 5,
                              tabPosition: TabPosition.top,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildTabHome(context, value.tabIndex))
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget _buildTabHome(BuildContext context, int index) {
  if (index == 0) {
    return _buildOverviewContent(context, index);
  } else if (index == 1) {
    return _buildBookingContent(context, index);
  } else if (index == 2) {
    return _buildPersonasContent(context, index);
  }
  return _buildOverviewContent(context, index);
}

Widget _buildOverviewContent(BuildContext context, int index) {
  final provider = Provider.of<GuestProvider>(context, listen: false).guest?[index];
  return Column(
    children: [
      _buildListTile("Title", "${provider?.name}", false),
      _buildListTile("Phone Number", "+${provider?.phoneNumber}", false),
      _buildListTile("Guest Origin", "${provider?.location}", false),
    ],
  );
}

Widget _buildBookingContent(BuildContext context, int index) {
  final provider = Provider.of<GuestProvider>(context, listen: false).guest?[index];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    child: ListView.builder(
      itemCount: provider?.bookings?.length,
      itemBuilder: (context, xIndex) {
        final value = provider?.bookings?[xIndex];
        return InkWell(
          onTap: () {
            _showSheetWithoutList(context, xIndex, index);
          },
          child: CardWidget(
            leading: const Icon(
              Icons.home_outlined,
              color: Color(0xFFF0C47F),
            ),
            title: "${value?.id}",
            subtitle: "${value?.placeName}",
            bodyText:
                '${DateFormat("d MMM yyyy").format(value?.checkIn as DateTime)} - ${DateFormat("d MMM yyyy").format(value?.checkOut as DateTime)}',
            isRed: value?.status == "Canceled" ? true : false,
            statusMessage: value?.status,
          ),
        );
      },
    ),
  );
}

void _showSheetWithoutList(BuildContext context, int Xindex, int index) {
  final provider = Provider.of<GuestProvider>(context, listen: false).guest?[index];
  showStickyFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: .8,
    headerHeight: 20,
    context: context,
    isSafeArea: true,
    bottomSheetColor: Colors.transparent,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    headerBuilder: (context, offset) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Icon(
          Icons.remove,
          size: 30,
        ),
      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
        [
          _buildContainerCustom(
            "Check In",
            "Check out",
            DateFormat("hh:mm").format(provider?.bookings?[Xindex].checkIn as DateTime),
            DateFormat("hh:mm").format(provider?.bookings?[Xindex].checkOut as DateTime),
            true,
            DateFormat("MMM dd yyyy").format(provider?.bookings?[Xindex].checkIn as DateTime),
            DateFormat("MMM dd yyyy").format(provider?.bookings?[Xindex].checkOut as DateTime),
          ),
          _buildContainerCustom("Booking ID", "Booking Status", "${provider?.bookings?[Xindex].id}",
              "${provider?.bookings?[Xindex].status}", false, "", ""),
          _buildContainerCustom("Number of guest", "Booking value", "${provider?.bookings?[Xindex].numberGuest}",
              "${provider?.bookings?[Xindex].bookingValue}", false, "", ""),
          _buildListTile("Phone number", "${provider?.phoneNumber}", false),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Hosting Details",
              style: titleList,
            ),
          ),
          _buildListTile("Host", "${provider?.bookings?[Xindex].host}", false),
          _buildListTile("Profile Name", "${provider?.bookings?[Xindex].profileName}", false),
          _buildListTile("Property Unit", "${provider?.bookings?[Xindex].propertyUnit}", false),
          _buildListTile("Listing Name", "${provider?.bookings?[Xindex].listingName}", true),
        ],
      );
    },
  );
}

Widget _buildPersonasContent(BuildContext context, int index) {
  final provider = Provider.of<GuestProvider>(context, listen: false).guest?[index];
  return Center(
    child: Text("Empty"),
  );
}

Padding _buildListTile(String title, String subtitle, bool isRed) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: ListTile(
      title: Text(
        title,
        style: titleListTile,
      ),
      subtitle: Text(
        subtitle,
        style: isRed ? subtitleListTileRed : subtitleListTile,
      ),
      dense: true,
    ),
  );
}

Container _buildContainerCustom(
    String title, String title2, String subtitle, String subtitle2, bool centerIcon, String date, String date2) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30),
    margin: EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleListTile,
            ),
            Text(
              subtitle,
              style: subtitleListTile,
            ),
            Text(centerIcon ? date : ""),
          ],
        ),
        centerIcon
            ? Column(
                children: [Icon(Icons.nights_stay_outlined), Text("3 Nights")],
              )
            : Text(""),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title2, style: titleListTile),
            Text(
              subtitle2,
              style: subtitleListTile,
            ),
            Text(centerIcon ? date2 : "")
          ],
        ),
      ],
    ),
  );
}
