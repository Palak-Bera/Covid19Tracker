import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/covid_service.dart';
import '../models/country_list.dart';
import '../models/country_summary.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'country_stats.dart';
import '../screens/tracker.dart';

CovidService covidService = CovidService();

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final TextEditingController _typeAheadController = TextEditingController();
  Future<List<CountryModel>> countryList;
  Future<List<CountrySummaryModel>> summaryList;

  @override
  initState() {
    super.initState();
    countryList = covidService.getCountryList();
    this._typeAheadController.text = "India";
    summaryList = covidService.getCountrySummary("india");
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = [];
    for (var item in list) {
      matches.add(item.country);
    }
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: countryList,
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
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      "images/nodata.png",
                    ),
                    Text(
                      "No Data Found",
                      style: GoogleFonts.knewave(
                        textStyle: TextStyle(color: textColor, fontSize: 30),
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Heading
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 23),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "COVID-19 TRACKER",
                            style: GoogleFonts.righteous(
                                textStyle:
                                    TextStyle(color: textColor, fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                    // type country name
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      child: Text(
                        "Type the country name",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // TextForm field
                    TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: this._typeAheadController,
                        decoration: InputDecoration(
                          hintText: 'Type here country name',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 24.0, right: 16.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return _getSuggestions(snapshot.data, pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) {
                        this._typeAheadController.text = suggestion;
                        setState(() {
                          summaryList = covidService.getCountrySummary(snapshot
                              .data
                              .firstWhere(
                                  (element) => element.country == suggestion)
                              .slug);
                        });
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Statistics Data
                    FutureBuilder(
                      future: summaryList,
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
                                  textStyle:
                                      TextStyle(color: textColor, fontSize: 30),
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
                                      color: index.isEven
                                          ? Colors.white
                                          : Colors.white60,
                                    ),
                                  );
                                },
                              ),
                            );
                          // return CountryLoading(inputTextLoading: false);
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
                                            textStyle: TextStyle(
                                                color: textColor, fontSize: 30),
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                : CountryStatistics(
                                    summaryList: snapshot.data,
                                  );
                        }
                      },
                    ),
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
