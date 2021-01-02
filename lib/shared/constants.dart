import 'package:flutter/material.dart';

Container instaText(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Text(
          "Instagram",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 60.0,
          ),
        ),
        Text(
          "Clone",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 60.0,
          ),
        ),
      ],
    ),
  );
}

Container languageSelection() {
  List<String> languages = ["English (United States)", "Hindi"];
  return Container(
    alignment: Alignment.center,
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        items: languages.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        }).toList(),
        value: languages[0],
        onChanged: (_) {},
      ),
    ),
  );
}
