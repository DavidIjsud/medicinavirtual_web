import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/login.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      localizationsDelegates: [
   // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
              const Locale('en'), // English
              const Locale('es'), // Hebrew
              
            ],
      title: 'Topico Avanzado',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
