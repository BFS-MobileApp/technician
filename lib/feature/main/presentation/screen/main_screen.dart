import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/home/presentation/screen/home_screen.dart';
import 'package:technician/feature/settings/presentation/screen/settings_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Text('Search Page');
      case 2:
        return const SettingsScreen();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  Icon(Icons.home_filled , size: 30.adaptSize,),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp , size: 30.adaptSize),
            label: 'calendar'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings , size: 30.adaptSize),
            label: 'settings'.tr,
          ),
        ],
        elevation: 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        selectedLabelStyle: const TextStyle(color: AppColors.mainColor),
        onTap: _onItemTapped,
      ),
    );
  }
}
