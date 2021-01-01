import 'package:flutter/material.dart';

class SystemThemeData {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      canvasColor: Colors.white,
      hintColor: Colors.grey,
      primaryColor: Colors.black,
      highlightColor: Colors.transparent,
      accentColor: Colors.black,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                ),
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.black,
                ),
          ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.black,
          ),

      primarySwatch: Colors.purple,
      backgroundColor: Colors.purple,
      indicatorColor: Colors.purple,
      buttonColor: Colors.purple,
      hoverColor: Colors.purple,
      focusColor: Colors.purple,
      disabledColor: Colors.purple,
      textSelectionColor: Colors.purple,
      cardColor: Colors.purple,

      brightness: Brightness.light,

      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       colorScheme: ColorScheme.light(),
      //     ),

      // textTheme: Theme.of(context).textTheme,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      canvasColor: Colors.black,
      hintColor: Colors.grey,
      primaryColor: Colors.white,
      highlightColor: Colors.transparent,
      accentColor: Colors.white,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.black,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                ),
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white,
                ),
          ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.white,
          ),

      primarySwatch: Colors.red,
      backgroundColor: Colors.red,
      indicatorColor: Colors.red,
      buttonColor: Colors.red,
      hoverColor: Colors.red,
      focusColor: Colors.red,
      disabledColor: Colors.red,
      textSelectionColor: Colors.red,
      cardColor: Colors.red,

      // accentColorBrightness: Brightness.light,
      // primaryColorBrightness: Brightness.light,
      brightness: Brightness.dark,

      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       colorScheme: ColorScheme.dark(),
      //     ),

      // textTheme: Theme.of(context).textTheme,
    );
  }
}
