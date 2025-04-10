import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../config/PrefHelper/helper.dart';

import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/notification/data/models/notification_model.dart';
import 'package:technician/feature/notification/presentation/cubit/notification_cubit.dart';
import 'package:technician/feature/notification/presentation/cubit/notification_state.dart';
import 'package:technician/feature/notification/presentation/widgets/notification_item.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/empty_data_widget.dart';
import 'package:technician/widgets/error_widget.dart';

import '../../../login/presentation/screen/login_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationModel? model;


  @override
  void initState() {
    super.initState();
    getData();
  }

  String extractClaimId(String url) {
    final regex = RegExp(r'claims/([^/]+)');
    final match = regex.firstMatch(url);
    return match != null ? match.group(1) ?? '' : '';
  }

  Widget screenWidget(){
    return Container(
      color: const Color(0xFFFAF6F9),
      child: ListView(
        children: [
          SizedBox(height: 15.h,),
          AppBarItem(title: 'notification'.tr,image: AssetsManager.backIcon2,),
          SizedBox(
            height: MediaQuery.of(context).size.height-100,
            child: ListView.builder(itemCount: model!.data.length , itemBuilder: (ctx , pos){
              return NotificationItem(date: model!.data[pos].diffDate, items: model!.data[pos].items, notificationDate: Helper.convertSecondsToDate(model!.data[pos].date.toString()));
            }),
          )
        ],
      ),
    );
  }

  getData()=>BlocProvider.of<NotificationCubit>(context).getNotifications();

  Widget checkState(NotificationState state){
    if(state is NotificationIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is NotificationError){
      bool isUnauthenticated = state.error.contains('Unauthenticated.');
      return ErrorWidgetItem(onTap: (){
        if(isUnauthenticated){
          Get.offAll(const LoginScreen());
        }else{
          getData();
        }
      },
        isUnauthenticated: isUnauthenticated,
      );
    } else if(state is NotificationLoaded){
      if(state.model.data.isEmpty){
        return EmptyDataWidget();
      }
      model = state.model;
      return screenWidget();
    } else {
      return screenWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NotificationCubit , NotificationState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
