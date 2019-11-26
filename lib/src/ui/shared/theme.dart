import 'package:flutter/material.dart';
import 'package:uet_comic/src/ui/shared/colors.dart';

final ThemeData kUetComicTheme = _buildShrineTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kUetComicBrown900);
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    // accentColor: kUetComicBrown900,
    // primaryColor: kUetComicPink100,
    primaryColor: Colors.blue[300],
    scaffoldBackgroundColor: kUetComicBackgroundWhite,
    cardColor: kUetComicBackgroundWhite,
    textSelectionColor: kUetComicPink100,
    errorColor: kUetComicErrorRed,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kUetComicPink100,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kUetComicBrown900),
    inputDecorationTheme: InputDecorationTheme(
      // border: CutCornersBorder(),
      border: OutlineInputBorder(),
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kUetComicBrown900,
        bodyColor: kUetComicBrown900,
      );
}

final RoundedRectangleBorder boderButton = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
);
final heightSpace = const SizedBox(height: 8);

final heightPadding = Padding(
  padding: const EdgeInsets.all(10),
);
