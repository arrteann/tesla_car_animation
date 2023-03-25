import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_animation/constant.dart';

class AppBottomNavigation extends StatelessWidget {
  AppBottomNavigation({
    super.key,
    required this.selectedTab,
    required this.onTap,
  });

  final int selectedTab;
  final ValueChanged<int> onTap;

  final List<String> _icons = [
    "assets/icons/Lock.svg",
    "assets/icons/Charge.svg",
    "assets/icons/Temp.svg",
    "assets/icons/Tyre.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedTab,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        _icons.length,
        (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _icons[index],
            color: index == selectedTab ? primaryColor : Colors.white54,
          ),
          label: "",
        ),
      ),
    );
  }
}
