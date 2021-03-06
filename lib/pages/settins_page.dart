import 'dart:async';
import 'package:Amplify/controller/song_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  SettingsPage(this._notify, {Key? key}) : super(key: key);
  final bool _notify;

  bool? val;
  bool _enabled = true;
  _launchURL() async {
    const url = 'https://sites.google.com/view/Amplify/home';
    if (!await canLaunch(url)) {
      await launch(url);
    }
  }

  restartNotify() {
    if (_enabled) {
      _enabled = false;
      Get.snackbar(
        "Amplify",
        "App need restart to change the settings",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Timer(const Duration(seconds: 5), () {
        _enabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffddbea9), Colors.brown],
          // colors: [Color(0xff3a2d2d), Colors.black],
          begin: Alignment.topLeft,
          end: FractionalOffset(0, 1),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leadingWidth: 70,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Settings",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 27,
            ),
          ),
          titleSpacing: 30,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                    right: 0,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    trailing: GetBuilder<SongController>(
                      id: "switch",
                      builder: (_controller) {
                        return Switch(
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          value: val ?? _notify,
                          onChanged: (value) async {
                            final prefs = await SharedPreferences.getInstance();
                            val = value;
                            prefs.setBool("notify", value);
                            _controller.update(["switch"]);
                            restartNotify();
                          },
                        );
                      },
                    ),
                    title: Text(
                      "Notification",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                  ),
                  child: ListTile(
                    onTap: () => Share.share(''
                        // 'check out my application :- https://play.google.com/store/apps/details?id=com.geca.Amplify',
                        ),
                    leading: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Share",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                  ),
                  child: ListTile(
                    // onTap: () => _launchURL(),
                    leading: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Privacy and policy",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                  ),
                  child: ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.receipt,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Terms and conditions",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      "About",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Amplify',
                        applicationIcon: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const Image(
                            height: 50,
                            image: AssetImage("assets/icons/icon.png"),
                          ),
                        ),
                        applicationVersion: '2.0.0',
                        children: [
                          const Text('Offline music player'),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.developer_mode,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Developers",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      //About page
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "version",
                      style: GoogleFonts.rubik(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "2.0.0",
                    style: GoogleFonts.rubik(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
