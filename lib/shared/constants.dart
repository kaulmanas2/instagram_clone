import 'package:flutter/material.dart';

Container instaText() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
    child: Text(
      "Instagram Clone",
      style: TextStyle(
          fontFamily: "Billabong",
          color: Colors.black,
          fontSize: 70.0
      ),
    ),
  );
}

Container languageSelection() {
  List<String> languages = ["English (United States)", "Hindi"];
  return Container(
    alignment: Alignment.center,
    color: Colors.white,
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

