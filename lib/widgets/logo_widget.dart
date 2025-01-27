import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({super.key});

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> {
  String versionNumber = '';

  @override
  void initState() {
    super.initState();
    getVersionNumber();
  }

  Future<void> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
    });
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.befalcon.com');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // height: 90.h,
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: _launchUrl,
        child: ListView(
          children: [
            Center(
              child: Text(
                'from'.tr,
                style: TextStyle(fontWeight: FontWeight.w400, color: const Color(0xFF808080), fontSize: 12.fSize),
              ),
            ),
            Center(
              child: Text(
                'beFalconSolutions'.tr,
                style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.black, fontSize: 14.fSize),
              ),
            ),
            Center(
              child: Text(
                'www.befalcon.com',
                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.loginPhaseFontColor, fontSize: 12.fSize),
              ),
            ),
            Center(
              child: Text(
                'Version: $versionNumber',
                style: TextStyle(fontWeight: FontWeight.w400, color: const Color(0xFF808080), fontSize: 12.fSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
