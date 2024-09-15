import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Pages/home_page.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) => ChangeNotifierProvider(
        create: (context) => NewsProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NEWS',
            theme: light,
            darkTheme: dark,
            home: const HomePage()),
      ),
    );
  }
}
