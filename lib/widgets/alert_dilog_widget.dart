import 'package:flutter/material.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:get/get.dart';

class AlertDialogWidget{

  final BuildContext context;
  final String title;
  final VoidCallback yesOnTap;


  AlertDialogWidget({required this.title, required this.yesOnTap , required this.context});

  void logOutDialog(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(title.tr , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 15.fSize),),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.h , left: 8.h, right: 15.w),
                child: InkWell(
                    onTap: yesOnTap,
                    child: Text("yes".tr , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 14.fSize , color: Colors.green),)
                ),
              ),
              SizedBox(width: 8.h,),
              Container(
                margin: EdgeInsets.only(top: 10.h , right: 15.w),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop(true);
                    },
                    child: Text("no".tr, style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 14.fSize , color: Colors.red),)
                ),
              ),
            ],
          );
        });
  }
}