import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:technician/feature/settings/presentation/cubit/settings_state.dart';
import 'package:technician/feature/settings/presentation/widgets/url_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/image_loader_widget.dart';
import 'package:technician/widgets/loading_item.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _language = true , _notification = true;
  String name = '' , email = '' , image = '';
  double width = 26 , height = 26;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    getData();
  }

  void setData(String realName , String realEmail , String realImage){
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        name = realName;
        email = realEmail;
        image = realImage;
      });
    });
  }

  void logOut(){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    Prefs.setBool(AppStrings.login, false);
  }

  void checkLanguage(){
    if(Helper.getCurrentLocal() == 'AR'){
      setState(() {
        _language = false;
      });
    } else {
      setState(() {
        _language = true;
      });
    }
    if(Prefs.isContain(AppStrings.userNotification) && Prefs.getBool(AppStrings.userNotification) == true){
      setState(() {
        _notification = true;
      });
    } else {
      setState(() {
        _notification = false;
      });
    }
  }

  getData() =>BlocProvider.of<SettingsCubit>(context).getUserInfo();

  Widget _screenWidget(){
    return Column(
      children: [
        SizedBox(height: 20.h,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),

          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.main);
                  },
                  child: RotatedBox(
                    quarterTurns: 4,
                    child: SVGImageWidget(
                      image: AssetsManager.backIcon,
                      height: 15.h,
                      width: 9.w,
                    ),
                  )
              ),
              SizedBox(width: 10.w,),
              Container(
                width: 4.w,
                height: 20.h,
                margin: EdgeInsetsDirectional.only(end: 2.w),
                decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(4)),
              ),
              SizedBox(width: 5.w,),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: TextWidget(text: 'profile'.tr , fontSize: 18.fSize,),
              ),
              const Spacer(),
              editProfileButton()
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              profileWidget(),
              settingsWidget(),
              SizedBox(height: 12.h,),
              accountWidget()
            ],
          ),
        ),
      ],
    );
  }

  Widget editProfileButton() => InkWell(
    onTap: ()=>Navigator.pushNamed(context, Routes.editProfile),
    child: Container(
      width: 28.w,
      height: 28.w,
      padding: EdgeInsets.all(6.adaptSize),
      decoration:
      BoxDecoration(border: Border.all(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(8)),
      child: SVGImageWidget(image: AssetsManager.editProfile, width: 250.w, height: 250.w),
    ),
  );

  Widget profileWidget() => Card(
    elevation: 3,
    child: Container(
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 15.w,),
      child: Column(
        children: [

          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ImageLoader(imageUrl: image , width: 72.w,height: 72.h,fit: BoxFit.cover)),
              SizedBox(width: 8.w,),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.notificationHomeTittleColor, fontSize: 16.fSize)),
                    Text(email, style: TextStyle(fontWeight: FontWeight.w500, color: const  Color(0xFF8C8CA1) , fontSize: 12.fSize)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );

  Widget accountWidget() {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Row(
              children: [
                SVGImageWidget(image: AssetsManager.notificationSetting, width: width, height: height),
                SizedBox(width: 5.w,),
                Text('notification'.tr, style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w500, color: AppColors.lightTextColor.withOpacity(0.8))),
                const Spacer(),
                Transform.scale(
                    scale: 0.6.w,
                    child:CupertinoSwitch(
                        activeColor: const Color(0xff44A4F2),
                        value: _notification,
                        onChanged: (value) {
                          setState(() {
                            _notification = value;
                            Prefs.setBool(AppStrings.userNotification, value);
                          });
                        }
                    )),
              ],
            ),
            divider(),
            InkWell(
              onTap: () {
                logOut();
              },
              child: Row(
                children: [
                  SVGImageWidget(image: AssetsManager.logOut, width: width, height: height),
                  SizedBox(width: 8.w,),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: TextWidget(text: 'logOut'.tr, fontSize: 18 , fontWeight: FontWeight.w500,fontColor: AppColors.lightTextColor.withOpacity(0.8),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsWidget() {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            // language
            Row(
              children: [
                SVGImageWidget(image: AssetsManager.language, width: 26.w, height: 26.h),
                SizedBox(width: 5.w,),
                Text('language'.tr, style: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.w500,
                    color: AppColors.lightTextColor.withOpacity(0.8))),
                const Spacer(),
                Transform.scale(
                    scale: 0.6.w,
                    child:CupertinoSwitch(
                        activeColor: const Color(0xff44A4F2),
                        value: _language,
                        onChanged: (value) {
                          BlocProvider.of<SettingsCubit>(context).changeLang();
                          setState(() {
                            _language = value;
                          });
                        }
                    )),
              ],
            ),
            divider(),
            const URLWidget(itemName: 'help', url: AppStrings.help, image: AssetsManager.help , isSVG: true,),
            divider(),
            const URLWidget(itemName: 'support', url: AppStrings.contact, image: AssetsManager.support , isSVG: true,) ,
            divider(),
            const URLWidget(itemName: 'privacy', url: AppStrings.privacyPolicy, image: AssetsManager.privacy , isSVG: true,),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Column(
      children: [
        SizedBox(height: 14.h,),
        const Divider(
          color: AppColors.grey,
        ),
        SizedBox(height: 14.h,),
      ],
    );
  }

  Widget checkState(SettingsState state){
    if(state is SettingsIsLoading){
      return const LoadingItem();
    } else if(state is SettingsError){
      return ErrorWidgetItem(onTap: (){});
    } else if(state is SettingsLoaded) {
      setData(state.userInfo.name , state.userInfo.email , state.userInfo.image);
      return _screenWidget();
    } else if(state is SettingsLoadedWithoutData){
      return _screenWidget();
    } else {
      return _screenWidget();
    }
  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SettingsCubit , SettingsState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
