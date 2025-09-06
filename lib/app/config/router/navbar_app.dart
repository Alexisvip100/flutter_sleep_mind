import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sleep_mind/app/presentation/pages/home.dart';
import 'package:sleep_mind/app/presentation/pages/sleep.dart';
import 'package:sleep_mind/app/presentation/pages/profile.dart';

class NavBarApp extends StatefulWidget {
  const NavBarApp({super.key});

  @override
  State<NavBarApp> createState() => _NavBarAppState();
}

class _NavBarAppState extends State<NavBarApp> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      navBarHeight: 60,
      navBarStyle: NavBarStyle.style3,
      backgroundColor: const Color.fromARGB(255, 38, 53, 100),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: const Color.fromARGB(255, 38, 53, 100),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const SleepScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white70,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bedtime),
        title: 'Sleep',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white70,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: 'Profile',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white70,
      ),
    ];
  }
}
