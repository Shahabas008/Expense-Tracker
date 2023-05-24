import 'package:flutter/material.dart';
import 'package:money_management_app/UI/budget/budgetpage.dart';
import 'package:money_management_app/UI/home/homepage.dart';
import 'package:money_management_app/UI/morepage.dart';
import 'package:money_management_app/UI/stats.dart';

import '../utils/colors.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _selectedIndex = 0;

  List pages = [
    const HomePage(),
    const BudgetPage(),
    const StatsPage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      // extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: black),
        unselectedLabelStyle: TextStyle(color: primary),
        selectedItemColor: teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_strong_rounded),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      ),
    );
  }
}
