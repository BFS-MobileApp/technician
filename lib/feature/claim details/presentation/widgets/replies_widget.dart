import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    hide ImageSource;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:technician/res/colors.dart';
import '../../../../config/PrefHelper/helper.dart';
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

import '../../../../config/PrefHelper/prefs.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/app_headline_widget.dart';

class RepliesWidget extends StatefulWidget {
  bool submitOnly;
  Comments comments;
  String claimId;
  String status;
  BuildContext ctx;
  int claimType;
  String referenceId;
  ClaimDetailsModel claimDetailsModel;

  RepliesWidget(
      {super.key,
      required this.claimType,
      required this.referenceId,
      required this.claimDetailsModel,
      required this.ctx,
      required this.submitOnly,
      required this.comments,
      required this.claimId,
      required this.status});

  @override
  State<RepliesWidget> createState() => _RepliesWidgetState();
}

class _RepliesWidgetState extends State<RepliesWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  String status = '';
  String lang = '';
  ImagePicker picker = ImagePicker();
  File filePicker = File('');
  List<XFile> imageFiles = [];
  ClaimDetailsModel? claimDetailsModel;
  int maxUploadFiles = Prefs.getInt(AppStrings.maxUploadFiles);
  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    } catch (e) {
      return dateStr; // fallback to original if parsing fails
    }
  }

  void showAttachmentDialog(
      BuildContext context,
      int maxUploadFiles,
      Function(List<File>) onFilesSelected,
      ) {
    List<XFile> selectedFiles = [];

    void showLimitDialog() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Upload Limit Reached'),
          content: Text(
            'You can upload a maximum of $maxUploadFiles files.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final bool limitReached =
                selectedFiles.length >= maxUploadFiles;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Attachment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  /// 🔢 Counter
                  Text(
                    '${selectedFiles.length} / $maxUploadFiles files selected',
                    style: TextStyle(
                      color: limitReached ? Colors.red : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📁 Gallery
                  SizedBox(
                    width: 220,
                    child: ElevatedButton.icon(
                      onPressed: limitReached
                          ? () => showLimitDialog()
                          : () async {
                        await pickImages((List<XFile> images) {
                          final remaining =
                              maxUploadFiles - selectedFiles.length;

                          if (images.length > remaining) {
                            showLimitDialog();
                            images = images.take(remaining).toList();
                          }

                          setState(() {
                            selectedFiles.addAll(images);
                          });
                        });
                      },
                      icon: const Icon(Icons.upload),
                      label: const Text('Upload Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        limitReached ? Colors.grey.shade300 : Colors.white,
                        foregroundColor:
                        limitReached ? Colors.grey : Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 📸 Camera
                  SizedBox(
                    width: 220,
                    child: ElevatedButton.icon(
                      onPressed: limitReached
                          ? () => showLimitDialog()
                          : () async {
                        await getImageFromCamera((List<XFile> images) {
                          final remaining =
                              maxUploadFiles - selectedFiles.length;

                          if (images.length > remaining) {
                            showLimitDialog();
                            images = images.take(remaining).toList();
                          }

                          setState(() {
                            selectedFiles.addAll(images);
                          });
                        });
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take a New Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        limitReached ? Colors.grey.shade300 : Colors.white,
                        foregroundColor:
                        limitReached ? Colors.grey : Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🖼 Preview
                  if (selectedFiles.isNotEmpty) ...[
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedFiles.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(selectedFiles[index].path),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: -5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFiles.removeAt(index);
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  /// ✅ Use
                  ElevatedButton(
                    onPressed: selectedFiles.isEmpty
                        ? null
                        : () {
                      onFilesSelected(
                        selectedFiles
                            .map((x) => File(x.path))
                            .toList(),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Use'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  void uploadFile(BuildContext context, List<File> selectedFiles) {
    if (selectedFiles.isNotEmpty) {
      context.read<ClaimDetailsCubit>().uploadCommentFile(
          context,
          widget.claimId,
          "latestCommentId",
          selectedFiles,
          widget.claimDetailsModel.data.status.toLowerCase(),
          widget.referenceId);
    }
  }

  Future<void> getImageFromCamera(Function(List<XFile>) updateImages) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      updateImages(
          [XFile(pickedFile.path)]); // Pass the new image as an XFile list
    } else {
      // Show a snackbar if no image was selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          margin: EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
          content: const Text('No Image Captured'),
        ),
      );
    }
  }

  Future<void> pickImages(Function(List<XFile>) updateImages) async {
    final ImagePicker picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.errorColor,
          margin: EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
          content: const Text('Only 4 Images Allowed'),
        ),
      );
      return;
    }

    if (pickedFiles.isNotEmpty) {
      updateImages(
          pickedFiles); // Call function to update images inside bottom sheet
    }
  }

  @override
  void initState() {
    super.initState();
    getLang();
  }

  getLang() {
    if (Helper.getCurrentLocal() == 'US') {
      setState(() {
        lang = 'US';
      });
    } else {
      lang = 'AR';
    }
  }

  void _addItem(String status, int submitCase) {
    if (_controller.text.isNotEmpty) {
      UserData userData =
          UserData(id: 0, refCode: '', name: '', email: '', avatar: '');
      User user = User(data: userData);
      CommentsData commentsData = CommentsData(
          id: 0,
          comment: _controller.text,
          createdAt: '',
          user: user,
          files: []);
      setState(() {
        widget.comments.data.insert(0, commentsData);
      });
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      BlocProvider.of<ClaimDetailsCubit>(context)
          .addComment(widget.claimId, _controller.value.text.toString(), status)
          .then((value) {
        if (!value) {
          widget.comments.data.removeAt(0);
        } else {
          _controller.clear();
          if (submitCase != 0) {
            Navigator.pop(widget.ctx, true);
          }
        }
      });
      BlocProvider.of<ClaimDetailsCubit>(context).getClaimDetails(widget.referenceId);
    }
  }

  void _submitButtonsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              SizedBox(
                height: 30.h,
              ),
              AppConst.submitButton
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        if (Helper.getCurrentLocal() == 'US') {
                          _addItem(widget.status.toLowerCase(), 0);
                        } else {
                          _addItem(getStatus(widget.status), 0);
                        }
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitIcon,
                          text: 'submit'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitNewButton && widget.claimType != 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('new', 1);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsNewIcon,
                          text: 'submitAsNew'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitAssignedButton && widget.claimType != 1
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('assigned', 2);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsAssignedIcon,
                          text: 'submitAsAssigned'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitStartedButton && widget.claimType != 2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('started', 3);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsStartedIcon,
                          text: 'submitAsStarted'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitDoneButton && widget.claimType != 3
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('completed', 4);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsCompletedIcon,
                          text: 'submitAsCompleted'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitClosedButton && widget.claimType != 4
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('closed', 5);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsClosedIcon,
                          text: 'submitAsClosed'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              AppConst.submitCancelledButton && widget.claimType != 5
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _addItem('cancelled', 6);
                      },
                      child: SubmitButton(
                          lang: lang,
                          image: AssetsManager.submitAsCancelledIcon,
                          text: 'submitAsCancelled'.tr),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget repliesWidget() {
    if (AppConst.viewUpdates) {
      return Padding(
        padding: EdgeInsets.all(10.0.adaptSize),
        child: Column(
          children: [
            AppHeadline(
              title: 'replies'.tr,
            ),
            SizedBox(height: 8.0.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: 'typeYourReplyHere'.tr,
                      filled: true,
                      fillColor: MColors.gray,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: AppColors.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: AppColors.whiteColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
              ],
            ),
            SizedBox(height: 8.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      showAttachmentDialog(context,
                          maxUploadFiles,
                          (List<File> selectedFiles) async {
                        uploadFile(context, selectedFiles);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          border: Border.all(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(8.adaptSize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              AssetsManager.upload,
                              color: Colors.white,
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'uploadFiles'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                            if (imageFiles.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    imageFiles.clear();
                                    filePicker.path == '';
                                  });
                                },
                                child: const Icon(Icons.close),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0.w),
                AppConst.submitButton ? Flexible(
                  child: InkWell(
                    onTap: () {
                      if (_controller.value.text.isEmpty) {
                        MessageWidget.showSnackBar(
                            'pleaseAddReplyFirst'.tr, AppColors.errorColor);
                      } else {
                        if (widget.submitOnly) {
                          if (Helper.getCurrentLocal() == 'US') {
                            _addItem(widget.status.toLowerCase(), 0);
                          } else {
                            _addItem(getStatus(widget.status), 0);
                          }
                        } else {
                          if(AppConst.submitButton && !AppConst.submitNewButton && !AppConst.submitAssignedButton
                          && !AppConst.submitStartedButton && !AppConst.submitDoneButton && !AppConst.submitClosedButton && !AppConst.submitCancelledButton){
                            if (Helper.getCurrentLocal() == 'US') {
                              _addItem(widget.status.toLowerCase(), 0);
                            } else {
                              _addItem(getStatus(widget.status), 0);
                            }
                          }else{
                            _submitButtonsMenu(context);
                          }

                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          border: Border.all(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(8.adaptSize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              AssetsManager.comment,
                              color: Colors.white,
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'submit'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ) : const SizedBox(),
              ],
            ),
            SizedBox(height: 16.0.h),
            BlocBuilder<ClaimDetailsCubit, ClaimDetailsState>(
              builder: (context, state) {
                if (state is ClaimDetailsIsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ClaimDetailsError) {
                  return Center(child: Text(state.msg, style: TextStyle(color: Colors.red)));
                }

                if (state is ClaimDetailsLoaded) {
                  final model = state.model;
                  final comments = model.data.comments.data
                    ..sort((a, b) {
                      final aDate = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(0);
                      final bDate = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(0);
                      return bDate.compareTo(aDate); // Newest first
                    });
                  return SizedBox(
                    height: comments.isEmpty ? 0 : 250.h,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          elevation: 1.0,
                          margin:const  EdgeInsets.symmetric(vertical: 4.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile Image
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(comments[index].user.data.avatar),
                                    ),
                                    SizedBox(width: 12),
                                    // Name and message
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comments[index].user.data
                                                .name ??
                                                '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            comments[index].comment ??
                                                '',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            _formatDate(comments[index].createdAt),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Delete Icon
                                    AppConst.deleteClaimRepliesAndUpdates ?
                                    InkWell(
                                      onTap: () async {
                                        final shouldDelete = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete Comment"),
                                              content: const Text("Are you sure you want to delete this comment?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(false); // User pressed No
                                                  },
                                                  child: const Text("No"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(true); // User pressed Yes
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (shouldDelete == true) {
                                          final commentId = comments[index].id.toString();
                                          final isDeleted = await context
                                              .read<ClaimDetailsCubit>()
                                              .deleteComment(commentId, widget.referenceId);

                                          if (!mounted) return;

                                          if (!isDeleted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Failed to delete comment"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Icon(Icons.delete, color: Colors.grey),
                                    ) : const SizedBox(),


                                  ],
                                ),

                                // Images (if any)
                                if (comments[index].files != null &&
                                    comments[index].files!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      children: comments[index].files!
                                          .take(2)
                                          .map((file) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Routes.fullScreenImage,
                                                arguments:
                                                FullScreenImageArguments(
                                                    image: file[
                                                    'file_url']));
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                              image: file['file_url'] !=
                                                  null
                                                  ? DecorationImage(
                                                image: NetworkImage(
                                                    file[
                                                    'file_url']),
                                                fit: BoxFit.cover,
                                              )
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    ),
                                  ),
                              ],

                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox(); // fallback in case of unexpected state
              },
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  String getStatus(String status) {
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
    return BlocConsumer<ClaimDetailsCubit, ClaimDetailsState>(
  listener: (context, state) {
    if (state is CommentDeleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Comment Deleted"),
          backgroundColor: Colors.red,
        ),
      );
    }else if (state is ClaimDetailsError){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              state.msg),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  builder: (context, state) {
      return repliesWidget();

  },
);
  }
}
