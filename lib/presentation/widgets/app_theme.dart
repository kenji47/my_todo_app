// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeDark {

    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final body1 = textTheme.headline1!.copyWith(decorationColor: Colors.transparent);

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.red[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.red[100],
      toggleableActiveColor: Colors.red[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.red[300],
      ),
      textTheme: textTheme.copyWith(
        headline1: body1,
      ),
    );
  }

  static ThemeData get themeLight {

    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;
    final body1 = textTheme.headline1!.copyWith(decorationColor: Colors.transparent);

    return ThemeData.light().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.red[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.red[100],
      toggleableActiveColor: Colors.red[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.red[300],
      ),
      textTheme: textTheme.copyWith(
        headline1: body1,
      ),
    );
  }
}
