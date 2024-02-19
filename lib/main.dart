import 'package:flutter/material.dart';
import 'core/ui_helper.dart';
import 'ui/screens/search_list_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/tab_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/bookmark_list_screen.dart';
import 'ui/screens/surah_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light().copyWith(
          primary: lightgreenv2,
          secondary: darkgreenv2,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/tab-screen': (context) => const TabScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/bookmark-list-screen': (context) => const BookmarkListScreen(),
        '/surah-list-screen': (context) => const SurahListScreen(),
        '/search-list-screen': (context) => const SearchListScreen()
      },
    );
  }
}
