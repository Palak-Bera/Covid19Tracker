import 'package:covid19/screens/country.dart';
import 'package:covid19/screens/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'navigation_options.dart';

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
}

//global Variable
bool isDarkModeEnabled = true;
Color textColor = Colors.white;
Color sTextColor = HexColor("#120321");
Color _scaffoldBgcolor = Colors.white;



class Tracker extends StatefulWidget {
  Tracker({Key key}) : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;
  var parser = EmojiParser();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _scaffoldBgcolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // container for toggle switch
            Container(
              color: isDarkModeEnabled
                  ? HexColor("#120321")
                  : HexColor("#ffffff"),
              child: Padding(
                padding: const EdgeInsets.only(top: 17.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(top:10 , right: 10),
                      child: Container(
                        child: FlutterSwitch(
                          width: 100.0,
                          height: 45.0,
                          toggleSize: 45.0,
                          value: isDarkModeEnabled,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Color(0xFF2F363D),
                          inactiveToggleColor: Color(0xFF2F363D),
                          activeSwitchBorder: Border.all(
                            color: Colors.grey[400],
                            width: 5.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: Colors.grey[400],
                            width: 6.0,
                          ),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          activeIcon: Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF8E3A1),
                          ),
                          inactiveIcon: Icon(
                            Icons.wb_sunny,
                            color: Color(0xFFFFDF5D),
                          ),
                          onToggle: (val) {
                            setState(() {
                              isDarkModeEnabled = val;

                              if (val) {
                                textColor = Colors.white;
                                _scaffoldBgcolor = Colors.white;
                                sTextColor = Colors.black;
                              } else {
                                textColor = HexColor("#120321");
                                _scaffoldBgcolor = HexColor("#120321");
                                sTextColor = Colors.white;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main area
            Expanded(
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: isDarkModeEnabled
                      ? HexColor("#120321")
                      : HexColor("#ffffff"),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: navigationStatus == NavigationStatus.GLOBAL
                      ? Global()
                      : Country(),
                ),
              ),
            ),
            //NAvigation options
            Container(
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigationOption(
                      title: "GLOBAL",
                      selected: navigationStatus == NavigationStatus.GLOBAL,
                      onSelected: () {
                        setState(() {
                          navigationStatus = NavigationStatus.GLOBAL;
                        });
                      }),
                  NavigationOption(
                      title: "COUNTRY",
                      selected: navigationStatus == NavigationStatus.COUNTRY,
                      onSelected: () {
                        setState(() {
                          navigationStatus = NavigationStatus.COUNTRY;
                        });
                      })
                ],
              ),
            ),
            // Developer Tagline
            Container(
              child: Text(
                parser.emojify("With :heart: by Palak Bera"),
                style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isDarkModeEnabled ? Colors.black : Colors.white),
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
