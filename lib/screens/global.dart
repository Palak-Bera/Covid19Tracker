import 'package:covid19/screens/global_stats.dart';
import 'package:flutter/material.dart';
import 'package:covid19/services/covid_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/global_summary.dart';
import 'tracker.dart';

CovidService covidService = CovidService();

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Future<GlobalSummaryModel> summary;

  @override
  void initState() {
    super.initState();
    summary = covidService.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "COVID-19 TRACKER",
                  style: GoogleFonts.righteous(
                      textStyle: TextStyle(color: textColor, fontSize: 25)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Global Corona Cases",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      summary = covidService.getGlobalSummary();
                    });
                  },
                  child: Icon(Icons.refresh, color: textColor, size: 30),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: summary,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                    child: Column(
                  children: [
                    Image.asset(
                      "images/error.png",
                    ),
                    Text(
                      "Something Went Wrong",
                      style: GoogleFonts.knewave(
                        textStyle: TextStyle(color: textColor, fontSize: 30),
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ));

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: SpinKitFoldingCube(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? textColor : Colors.white60,
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return !snapshot.hasData
                      ? Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "images/nodata.png",
                              ),
                              Text(
                                "No Data Found",
                                style: GoogleFonts.knewave(
                                  textStyle:
                                      TextStyle(color: textColor, fontSize: 30),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : GlobalStatistics(summary: snapshot.data);
              }
            },
          )
        ],
      ),
    );
  }
}
