import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/submit_button.dart';
import 'package:technician/widgets/message_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';

import '../../../../core/utils/app_colors.dart';

class RepliesWidget extends StatefulWidget {

  bool submitOnly;
  Comments comments;
  String claimId;
  String status;
  BuildContext ctx;
  int claimType;
  RepliesWidget({super.key , required this.claimType , required this.ctx , required this.submitOnly , required this.comments , required this.claimId , required this.status});

  @override
  State<RepliesWidget> createState() => _RepliesWidgetState();
}

class _RepliesWidgetState extends State<RepliesWidget> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  String status = '';
  String lang = '';


  @override
  void initState() {
    super.initState();
    getLang();
  }

  getLang(){
    if(Helper.getCurrentLocal() == 'US'){
      setState(() {
        lang = 'US';
      });
    } else {
      lang = 'AR';
    }
  }

  void _addItem(String status , int submitCase) {
    if (_controller.text.isNotEmpty) {
      UserData userData = UserData(id: 0, refCode: '', name: '', email: '', avatar: '');
      User user = User(data: userData);
      CommentsData commentsData = CommentsData(id: 0, comment: _controller.text, createdAt: '', user: user, files: []);
      setState(() {
        widget.comments.data.insert(0, commentsData);
      });
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      BlocProvider.of<ClaimDetailsCubit>(context).addComment(widget.claimId , _controller.value.text.toString() , status).then((value){
        if(!value){
          widget.comments.data.removeAt(0);
        } else {
          _controller.clear();
          if(submitCase != 0){
            Navigator.pop(widget.ctx , true);
          }
        }
      });
    }
  }

  void _submitButtonsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0.adaptSize),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h,),
              AppConst.submitButton ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  if(Helper.getCurrentLocal() == 'US'){
                    _addItem(widget.status.toLowerCase() , 0);
                  } else {
                    _addItem(getStatus(widget.status) , 0);
                  }
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitIcon, text: 'submit'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitNewButton&&widget.claimType !=0 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('new' , 1);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsNewIcon, text: 'submitAsNew'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitAssignedButton&&widget.claimType !=1 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('assigned' , 2);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsAssignedIcon, text: 'submitAsAssigned'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitStartedButton&&widget.claimType !=2 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('started' , 3);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsStartedIcon, text: 'submitAsStarted'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitDoneButton&&widget.claimType !=3 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('completed' , 4);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsCompletedIcon, text: 'submitAsCompleted'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitClosedButton&&widget.claimType !=4 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('closed' , 5);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsClosedIcon, text: 'submitAsClosed'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
              AppConst.submitCancelledButton&&widget.claimType !=5 ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _addItem('cancelled' , 6);
                },
                child: SubmitButton(lang: lang , image: AssetsManager.submitAsCancelledIcon, text: 'submitAsCancelled'.tr),
              ) : const SizedBox(),
              SizedBox(height: 10.h,),
            ],
          ),
        );
      },
    );
  }

  Widget repliesWidget(){
    if(AppConst.viewUpdates){
      return Padding(
        padding: EdgeInsets.all(10.0.adaptSize),
        child: Column(
          children: [
            SizedBox(
              height: widget.comments.data.isEmpty ? 0 : 120.h,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.comments.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    margin: EdgeInsets.symmetric(vertical: 4.0.w),
                    child: ListTile(
                      title: HtmlWidget(widget.comments.data[index].comment),
                      trailing: widget.comments.data[index].files!.isNotEmpty ? InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.fullScreenImage , arguments: FullScreenImageArguments(image: widget.comments.data[index].files![0]['file_url']));
                        },
                        child: Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            image: DecorationImage(
                              image: NetworkImage( widget.comments.data[index].files![0]['file_url']),
                              fit: BoxFit.cover, // Cover the entire container
                            ),
                          ),
                        ),
                      ) : const SizedBox(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: 'typeYourReplyHere'.tr,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
                InkWell(
                  onTap: (){
                    if(_controller.value.text.isEmpty){
                      MessageWidget.showSnackBar('pleaseAddReplyFirst'.tr , AppColors.errorColor);
                    } else {
                      if(widget.submitOnly){
                        if(Helper.getCurrentLocal() == 'US'){
                          _addItem(widget.status.toLowerCase() , 0);
                        } else {
                          _addItem(getStatus(widget.status) , 0);
                        }
                      } else {
                        _submitButtonsMenu(context);
                      }
                    }
                  },
                  child: SVGImageWidget(image: AssetsManager.comment,height: 26.h,width: 26.w,),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  String getStatus(String status){
    switch (status) {
      case 'تم اختيار فني':
        return "assigned";
      case 'جديد':
        return "new";
      case 'ملغي':
        return "cancelled";
      case 'مكتمل':
        return "completed";
      case 'بدأت':
        return "started";
      case 'مغلق':
        return "closed";
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return repliesWidget();
  }
}
