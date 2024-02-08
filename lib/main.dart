import 'package:flutter/material.dart';
import 'package:juzamma/core/ui_helper.dart';
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
      home: TabScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home-screen': (context) => const HomeScreen(),
        '/bookmark-list-screen': (context) => const BookmarkListScreen(),
        '/surah-list-screen': (context) => const SurahListScreen(),
      },
    );
  }
}
