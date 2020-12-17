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

String profilePicURL = "https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
List<String> posts = [
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/2273580/pexels-photo-2273580.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845730/pexels-photo-5845730.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/4913466/pexels-photo-4913466.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  "https://images.pexels.com/photos/5845682/pexels-photo-5845682.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
];