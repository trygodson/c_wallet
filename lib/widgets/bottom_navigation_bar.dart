import 'package:flutter/material.dart';
import 'package:wallet/utils/appColors.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  BottomNavigationBarItem _icons(IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
        ),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: AppColors.navyBlue2,
      unselectedItemColor: AppColors.grey,
      currentIndex: 0,
      items: [
        _icons(
          Icons.home,
        ),
        _icons(Icons.chat_bubble_outline),
        _icons(Icons.notifications_none),
        _icons(Icons.person_outline),
      ],
    );
  }
}
