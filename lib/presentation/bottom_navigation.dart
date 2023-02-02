import 'package:flutter/material.dart';

import 'pages.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ShoppingCartPage(),
    AccountPage()
  ];

  void _onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        elevation: 0,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "ShoppingCart",
              activeIcon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Account",
              activeIcon: Icon(Icons.account_circle))
        ],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
