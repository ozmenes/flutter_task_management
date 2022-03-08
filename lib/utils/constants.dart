import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

double pixel = 16;
EdgeInsets defPadding = EdgeInsets.symmetric(horizontal: pixel);

const bgColor = Color(0xFF121212);
const Color blueColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color _white = Colors.white;
const primaryColor = blueColor;
final Color darHeader = Colors.grey.shade800;


class MyThemes {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'ProductSans',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColor,
    backgroundColor: darHeader,
    colorScheme: const ColorScheme.dark(),
    primaryColor: darHeader,
    secondaryHeaderColor: Colors.grey.shade900.withOpacity(0.5),
    iconTheme: IconThemeData(color: Colors.purple.shade200),
    appBarTheme: AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.purple.shade200,
      ),
      actionsIconTheme: IconThemeData(color: Colors.purple.shade200),
    ),
    drawerTheme:
    DrawerThemeData(backgroundColor: Colors.grey.shade900, elevation: 8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.purple.shade200,
      unselectedItemColor: Colors.grey[700],
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.purple.shade200,
          height: 1.3),
      headline3: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.3),
      headline2: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: Colors.purple.shade200,
          height: 1.4),
      subtitle1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.purple.shade200,
          height: 1.3),
      caption: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
          height: 1.2),
    ),
  );
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'ProductSans',
    scaffoldBackgroundColor: _white,
    backgroundColor: _white,
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
    primaryColor: blueColor,
    secondaryHeaderColor: Colors.grey.shade200,
    iconTheme: IconThemeData(
      color: Colors.purple.shade700,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.purple.shade700,
      ),
      actionsIconTheme: IconThemeData(color: Colors.purple.shade700),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.purple.shade700,
      unselectedItemColor: Colors.grey[600],
    ),

    textTheme: TextTheme(
      headline4: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.indigoAccent.shade700,
          height: 1.3),
      headline3: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.3),
      headline2: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: Colors.purple.shade700,
          height: 1.4),
      subtitle1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.purple.shade700,
          height: 1.3),
      caption: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
          height: 1.2),
    ),
  );
}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey.shade400:Colors.grey
    )
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade400
      )
  );
}