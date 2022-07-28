import 'package:bukit_vista_flutter_assesment/components/theme.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.title,
      this.isRed = false,
      this.leading,
      this.imgUrl,
      this.subtitle,
      this.bodyText,
      this.onTap,
      this.statusMessage})
      : super(key: key);

  final String title;
  final Widget? leading;
  final String? imgUrl;
  final String? subtitle;
  final String? bodyText;
  final String? statusMessage;
  final bool isRed;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Row(
              crossAxisAlignment: imgUrl != null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      radius: imgUrl != null ? 28 : 15,
                      backgroundColor: const Color(0xFFF7EAC0),
                      backgroundImage: imgUrl != null ? NetworkImage(imgUrl!) : null,
                      child: leading,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: titleList,
                      ),
                      if (subtitle != null && bodyText != null) const SizedBox(height: 10),
                      if (subtitle != null) Text(subtitle!, style: subtitleList),
                      if (bodyText != null)
                        Text(
                          bodyText!,
                          style: textTheme.caption,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (statusMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: isRed ? const Color(0xFFFBC3C6) : const Color(0xFFBAF2B6),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              statusMessage!,
                              style: TextStyle(color: isRed ? Colors.red : Colors.green),
                            ),
                          ),
                        ),
                      if (onTap != null)
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.blue),
                        )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
