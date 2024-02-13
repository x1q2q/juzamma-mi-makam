import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../components/svg.dart';
import 'home_screen.dart';
import 'bookmark_list_screen.dart';
import 'surah_list_screen.dart';
import '../components/audio_tabs.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  bool _isVisibleAudioTabs = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const SurahListScreen(),
    const BookmarkListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                body: _pages.elementAt(_selectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 2.0,
                  backgroundColor: darkgreenv1,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        activeIcon: Container(
                            child: SVG.homeIconLight, width: 35, height: 35),
                        icon: Container(
                            child: SVG.homeIcon, width: 35, height: 35),
                        label: 'Beranda',
                        tooltip: 'Beranda Aplikasi'),
                    BottomNavigationBarItem(
                        activeIcon: Container(
                            child: SVG.listIconLight, width: 35, height: 35),
                        icon: Container(
                            child: SVG.listIcon, width: 35, height: 35),
                        label: 'Surah',
                        tooltip: 'Daftar Semua Surah'),
                    BottomNavigationBarItem(
                        activeIcon: Container(
                            child: SVG.bookmarkIconLight,
                            width: 35,
                            height: 35),
                        icon: Container(
                            child: SVG.bookmarkIcon, width: 35, height: 35),
                        label: 'Disimpan',
                        tooltip: 'Daftar Surah Disimpan'),
                  ],
                  currentIndex: _selectedIndex,
                  unselectedItemColor: lightgreenv1,
                  selectedItemColor: Colors.white,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                ))));
  }
}
