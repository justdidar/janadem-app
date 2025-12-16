import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:janadem/screens/user/profile/profile_screen.dart';
import 'package:janadem/screens/user/location/location_screen.dart';
import 'package:janadem/screens/user/add_problem/add_problem_screen.dart';


class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({Key? key}) : super(key: key);

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  late PersistentTabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const LocationScreen(),
      const AddProblemScreen(),
      const HomeScreen(), // GiftsScreen()
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          '${Assets().icn}home.svg',
          color: _currentIndex == 0 ? const Color(0xff056C5F) : const Color(0xff8B97A8),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          '${Assets().icn}location.svg',
          color: _currentIndex == 1 ? const Color(0xff056C5F) : const Color(0xff8B97A8),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          '${Assets().icn}plus.svg',
          color: _currentIndex == 2 ? const Color(0xff056C5F) : const Color(0xff8B97A8),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          '${Assets().icn}gift.svg',
          color: _currentIndex == 3 ? const Color(0xff056C5F) : const Color(0xff8B97A8),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          '${Assets().icn}profile.svg',
          color: _currentIndex == 4 ? const Color(0xff056C5F) : const Color(0xff8B97A8),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarHeight: 60,
        backgroundColor: Colors.white,
        navBarStyle: NavBarStyle.simple,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
