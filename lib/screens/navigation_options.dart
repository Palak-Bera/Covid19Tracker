import 'package:flutter/material.dart';
import '../screens/tracker.dart';


class NavigationOption extends StatelessWidget {

  final String title;
  final bool selected;
  final Function() onSelected;

  NavigationOption(
      {@required this.title,
      @required this.selected,
      @required this.onSelected});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          // Text
          Text(
            title,
            style: TextStyle(
                color: selected ? sTextColor : Colors.grey[400],
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
          
          // For Dot
          selected
              ? Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: sTextColor, shape: BoxShape.circle),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
