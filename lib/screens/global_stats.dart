import 'package:covid19/screens/navigation_global.dart';
import 'package:covid19/screens/tracker.dart';
import 'package:covid19/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../models/global_summary.dart';
import 'package:timeago/timeago.dart' as timeago;

enum NavigationStatus {
  TODAY,
  TOTAL,
}

CovidService covidService = CovidService();

class GlobalStatistics extends StatefulWidget {
  final GlobalSummaryModel summary;

  GlobalStatistics({@required this.summary});

  @override
  _GlobalStatisticsState createState() => _GlobalStatisticsState();
}

class _GlobalStatisticsState extends State<GlobalStatistics> {
  Future<GlobalSummaryModel> summary;
  NavigationStatus navigationStatus = NavigationStatus.TODAY;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Navigation Card
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavigationOption(
                  title: "TODAY",
                  selected: navigationStatus == NavigationStatus.TODAY,
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.TODAY;
                    });
                  }),
              NavigationOption(
                  title: "TOTAL",
                  selected: navigationStatus == NavigationStatus.TOTAL,
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.TOTAL;
                    });
                  })
            ],
          ),
        ),
        SizedBox(height: 30),
        navigationStatus == NavigationStatus.TODAY
            ?
            // today cases
            // cases card
            Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCard("CONFIRMED", widget.summary.newConfirmed,
                          kConfirmedColor, size),
                      buildCard("RECOVERED", widget.summary.newRecovered,
                          kRecoveredColor, size),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                          "DEATH", widget.summary.newDeaths, kDeathColor, size),
                    ],
                  ),
                ],
              )
            :
            // total cases
            // cases card
            Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCard("CONFIRMED", widget.summary.totalConfirmed,
                          kConfirmedColor, size),
                      buildCard(
                          "ACTIVE",
                          widget.summary.totalConfirmed -
                              widget.summary.totalRecovered -
                              widget.summary.totalDeaths,
                          kActiveColor,
                          size),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCard("RECOVERED", widget.summary.totalRecovered,
                          kRecoveredColor, size),
                      buildCard("DEATH", widget.summary.totalDeaths,
                          kDeathColor, size),
                    ],
                  ),
                ],
              ),

        //Statistics Updated Text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Text(
            "Statistics Updated " + timeago.format(widget.summary.date),
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              textStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildCard(String title, int totalCount, Color color, var size) {
    return Card(
      elevation: 1,
      color: color,
      child: Container(
        width: size.width * 0.5 - 40,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
            Text(
              totalCount.toString().replaceAllMapped(reg, mathFunc),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
