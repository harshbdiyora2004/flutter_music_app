import 'package:flutter/material.dart';
import 'package:music_app/screens/home.dart';
import 'package:music_app/screens/libray.dart';
import 'package:music_app/screens/search.dart';

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  int _selectedTab = 0;

  void _refreshLibrayScreen() {
    // Call the setState function to trigger a rebuild of the LibrayScreen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedTab,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
              if (_selectedTab == 2) {
                _refreshLibrayScreen();
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Your Library',
            ),
          ],
        ),
        body: Stack(
          children: [
            tabbarView(
              0,
              const HomeScreen(),
            ),
            tabbarView(
              1,
              const SearchScreen(),
            ),
            tabbarView(
              2,
              LibrayScreen(refreshCallback: _refreshLibrayScreen),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabbarView(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
