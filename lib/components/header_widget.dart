import 'package:bukit_vista_flutter_assesment/components/theme.dart';
import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({
    Key? key,
    required this.title,
    this.displaySearchField = false,
    this.leading,
  }) : super(key: key);

  final String title;
  final bool displaySearchField;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GuestProvider>(context, listen: false);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      centerTitle: true,
      title: Text(
        title,
        style: titleAppbar,
      ),
      elevation: 0,
      bottom: displaySearchField
          ? PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          hintText: "Search your guest name",
                          fillColor: Colors.white,
                        ),
                        onSubmitted: (v) {
                          provider.search(v);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFEFB83E), borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => displaySearchField ? const Size.fromHeight(140) : const Size.fromHeight(60);
}
