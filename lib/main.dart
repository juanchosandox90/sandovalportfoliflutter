import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandovalportfolio/Screens/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Sandoval Portfolio',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          )),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
