import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/home/presentation/screen/home_screen.dart';
import 'package:technician/feature/settings/presentation/screen/settings_screen.dart';

import '../../../../core/utils/app_consts.dart';
import '../../../new claim/presentation/screen/new_claim_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (AppConst.createClaims.value) {
      if (index != 2) {
        setState(() {
          _selectedIndex = index;
        });
      }
    }else{
      if (index != 1) {
        setState(() {
          _selectedIndex = index;
        });
      }
    }
  }

  Widget _buildPageContent() {
    if (AppConst.createClaims.value) {
      switch (_selectedIndex) {
        case 0:
          return const HomeScreen();
        case 1:
          return const NewClaimScreen();
        case 2:
          return const Text('Search Page');
        case 3:
          return const SettingsScreen();
        default:
          return const SizedBox();
      }
    }else{
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  Icon(Icons.home_filled , size: 30.adaptSize,),
            label: 'home'.tr,
          ),
          if (AppConst.createClaims.value)
          BottomNavigationBarItem(
            icon: Icon(Icons.add , size: 30.adaptSize),
            label: 'addClaim'.tr,
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
      )),
    );
  }
}
