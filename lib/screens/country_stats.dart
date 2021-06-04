import 'package:covid19/screens/tracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/country_summary.dart';
import '../utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;



class CountryStatistics extends StatefulWidget {
  final List<CountrySummaryModel> summaryList;

  CountryStatistics({@required this.summaryList});

  @override
  _CountryStatisticsState createState() => _CountryStatisticsState();
}

class _CountryStatisticsState extends State<CountryStatistics> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        //data card 
        Row(
          children: [
            buildCard(
                "CONFIRMED",
                widget.summaryList[widget.summaryList.length - 1].confirmed,
                kConfirmedColor,
                size),
            buildCard("ACTIVE", widget.summaryList[widget.summaryList.length - 1].active,
                kActiveColor, size),
          ],
        ),
        Row(
          children: [
            buildCard(
                "RECOVERED",
                widget.summaryList[widget.summaryList.length - 1].recovered,
                kRecoveredColor,
                size),
            buildCard("DEATH", widget.summaryList[widget.summaryList.length - 1].death,
                kDeathColor, size),
          ],
        ),
        SizedBox(height: 20),
        //statics updated text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics Updated " +
                timeago.format(widget.summaryList[widget.summaryList.length - 1].date),
                textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(textStyle :     
            TextStyle(
             
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: 18 ,
            ), ),
          ),
        )
      ],
    );
  }

  Widget buildCard(String leftTitle, int leftValue, Color leftColor, var size) {
    return Card(
      color: leftColor,
      elevation: 1,
      child: Container(
        width: size.width * 0.5 - 40,
       padding: EdgeInsets.only(top : 20 , bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  leftTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              
                Text(
                  leftValue.toString().replaceAllMapped(reg, mathFunc),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
