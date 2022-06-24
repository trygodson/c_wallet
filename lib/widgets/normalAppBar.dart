import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class NormalAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool action;
  Uri? url;
  NormalAppBar({required this.title, this.url, this.action = false, Key? key})
      : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: action
            ? [
                GestureDetector(
                  onTap: () {
                    _launchInBrowser(url!);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(Icons.ios_share_outlined),
                  ),
                ),
              ]
            : [],
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(45);
}
