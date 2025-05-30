import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_strings.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claim%20details/presentation/screen/edit_claim_screen.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/add_materials_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/assign_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_card_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_describtion_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_id_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_status_widget.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/claim_details_text_item.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/priority_button.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/replies_widget.dart';
import 'package:technician/feature/claims/presentation/cubit/technical_state.dart';
import 'package:technician/feature/claims/presentation/cubit/technicial_cubit.dart';
import 'package:technician/feature/login/presentation/screen/login_screen.dart';
import 'package:technician/widgets/aligment_widget.dart';
import 'package:technician/widgets/all_files_widget.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/assign_menu.dart';
import 'package:technician/widgets/bar_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import '../../../../config/PrefHelper/helper.dart';
import '../../../../config/PrefHelper/helper.dart';

import '../../../../config/PrefHelper/prefs.dart';
import '../../../claims/data/models/technician_model.dart';
import '../widgets/reassign_button.dart';

class AssignedClaimsScreen extends StatefulWidget {
  String claimId;
  String referenceId;

  AssignedClaimsScreen(
      {super.key, required this.claimId, required this.referenceId});

  @override
  State<AssignedClaimsScreen> createState() => _AssignedClaimsScreenState();
}

class _AssignedClaimsScreenState extends State<AssignedClaimsScreen> {
  ClaimDetailsModel? claimDetailsModel;
  AlignmentWidget alignmentWidget = AlignmentWidget();
  late AssignMenu assignMenu;
  List<Datum> technicalList = [];
  List<String> _permissions = [];

  @override
  void initState() {
    super.initState();
    getData();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final permissions = Prefs.getStringList(AppStrings.permissions);
    if (permissions != null) {
      setState(() {
        _permissions = permissions;
      });
    }
  }

  void getData() {
    BlocProvider.of<TechnicalCubit>(context)
        .getAllTechnician(widget.claimId)
        .then((model) {
      setState(() {
        technicalList = model!.data;
      });
    });
    BlocProvider.of<ClaimDetailsCubit>(context)
        .getClaimDetails(widget.referenceId);
  }

  File? _selectedFile;
  ImagePicker picker = ImagePicker();
  File filePicker = File('');
  List<XFile> imageFiles = [];
  String route = Routes.assignedClaims;

  void showAttachmentDialog(
      BuildContext context, Function(List<File>) onFilesSelected) {
    List<XFile> selectedFiles = [];

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Attachment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await pickImages((List<XFile> images) {
                          setState(() {
                            selectedFiles =
                                images; // Update bottom sheet images
                          });
                        });
                      },
                      icon: Icon(Icons.upload, color: Colors.blue),
                      label: Text(
                        'Upload Photo',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.blue),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await getImageFromCamera((List<XFile> images) {
                          setState(() {
                            selectedFiles
                                .addAll(images); // Update bottom sheet images
                          });
                        });
                      },
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      label: Text(
                        'Take a New Photo',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.blue),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Show selected files as thumbnails
                  if (selectedFiles.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Text("Selected Files:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
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
                                  child: CircleAvatar(
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

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedFiles.isNotEmpty) {
                        List<File> filesToUpload = selectedFiles
                            .map((xFile) => File(xFile.path))
                            .toList();
                        onFilesSelected(
                            filesToUpload); // ✅ Pass list of selected files
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Use',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      minimumSize: Size(double.infinity, 45),
                    ),
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
          context, // ✅ Pass context for Snackbar & Reload
          widget.claimId,
          "latestCommentId",
          selectedFiles,
          claimDetailsModel!.data.status.toLowerCase(),
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

  Widget _buildClaimCard() {
    return ClaimDetailsCardItem(
        cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsIdWidget(id: claimDetailsModel!.data.referenceId),
        ClaimDetailsTextItem(
          itemName: 'unit'.tr,
          itemValue: claimDetailsModel!.data.unit.building +
              ' - ' +
              claimDetailsModel!.data.unit.name,
          isClickable: false,
          type: '',
        ),
        //ClaimDetailsTextItem(itemName: 'building'.tr, itemValue: claimDetailsModel!.data.unit.building , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'propertyUnit'.tr, itemValue: claimDetailsModel!.data.unit.name , isClickable: false, type: '',),
        ClaimDetailsTextItem(
          itemName: 'type'.tr,
          itemValue: claimDetailsModel!.data.category.name +
              '-' +
              claimDetailsModel!.data.subCategory.name +
              '-' +
              claimDetailsModel!.data.type.name,
          isClickable: false,
          type: '',
        ),
        ClaimDetailsStatusWidget(
            itemName: 'status'.tr,
            isStatus: true,
            itemValue: claimDetailsModel!.data.status),
        //ClaimDetailsTextItem(itemName: 'claimSubCategory'.tr, itemValue: claimDetailsModel!.data.subCategory.name , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'claimType'.tr, itemValue: claimDetailsModel!.data.type.name , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'createdAt'.tr, itemValue: Helper.convertSecondsToDate(claimDetailsModel!.data.createdAt.toString()) , isClickable: false, type: '',),
        //ClaimDetailsTextItem(itemName: 'assignTo'.tr, itemValue: employeeName() , isClickable: false, type: '',),
        ClaimDetailsStatusWidget(
            itemName: 'priority'.tr,
            isStatus: false,
            itemValue: claimDetailsModel!.data.priority),
        ClaimDetailsTextItem(
          itemName: 'availableTime'.tr,
          itemValue:
              '${Helper.convertSecondsToDate(claimDetailsModel!.data.availableDate.toString())} - ${Helper.getAvailableTime(claimDetailsModel!.data.availableTime)}',
          isClickable: false,
          type: '',
        ),
        //ClaimDetailsStatusWidget(itemName: 'status'.tr, isStatus: true, itemValue: claimDetailsModel!.data.status),
        ClaimDetailsDescriptionItem(
            itemValue: claimDetailsModel!.data.description),
        AllFilesWidget(
          images: claimDetailsModel!.data.comments,
          files: claimDetailsModel!.data.files,
          ifUpdate: false,
          claimId: widget.claimId,
        )
      ],
    ));
  }

  Widget _userInfoWidget() {
    return ClaimDetailsCardItem(
        cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsTextItem(
          itemName: 'createdAt'.tr,
          itemValue: Helper.convertSecondsToDate(
              claimDetailsModel!.data.createdAt.toString()),
          isClickable: false,
          type: '',
        ),
        ClaimDetailsTextItem(
          itemName: 'createdBy'.tr,
          itemValue: claimDetailsModel!.data.creator.data.name,
          isClickable: false,
          type: '',
        ),
        ClaimDetailsTextItem(
          itemName: 'phoneNumber'.tr,
          itemValue: claimDetailsModel!.data.creator.data.mobile,
          isClickable: true,
          type: AppStrings.tel,
        ),
        ClaimDetailsTextItem(
          itemName: 'emailAddress'.tr,
          itemValue: claimDetailsModel!.data.creator.data.email,
          isClickable: true,
          type: AppStrings.email,
        ),
      ],
    ));
  }

  Widget _statusInfoWidget() {
    return ClaimDetailsCardItem(
        cardChildWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaimDetailsTextItem(
          itemName: 'assignTo'.tr,
          itemValue: employeeName(),
          isClickable: false,
          type: '',
        ),
      ],
    ));
  }

  Widget _detailsWidget() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: AppBarItem(
                      title: 'claimDetails'.tr,
                      image: AssetsManager.backIcon2,
                    ),
                  ),
                 GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Are you sure?"),
                            content: const Text(
                                "Do you really want to delete this claim?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (_permissions.contains("delete_claims")) {
                                    Navigator.pop(context);
                                    await BlocProvider
                                        .of<ClaimDetailsCubit>(context)
                                        .deleteClaim(claimDetailsModel!.data.id
                                            .toString());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'You do not have permission to delete this claim.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        ),
                        child: SVGImageWidget(
                          image: AssetsManager.clearIcon,
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                  SizedBox(
                    width: 5.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_permissions.contains("update_claims")) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditClaimScreen(
                                      claimsModel: claimDetailsModel!,
                                    )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You do not have permission to update this claim.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: SVGImageWidget(
                      image: AssetsManager.editProfile,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.technicianHistory,
                        arguments: TechnicianHistoryArguments(
                            logList: claimDetailsModel!.data.logs,
                            employeesList: claimDetailsModel!.data.employees,
                            timeList: claimDetailsModel!.data.times)),
                    child: SVGImageWidget(
                      image: AssetsManager.timeHistory,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    // SizedBox(height: 20.h,),
                    _buildClaimCard(),
                    SizedBox(
                      height: 5.h,
                    ),
                    _userInfoWidget(),
                    SizedBox(
                      height: 5.h,
                    ),
                    _statusInfoWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppHeadline(
                      title: 'replies'.tr,
                    ),
                    RepliesWidget(
                      claimType: 1,
                      ctx: context,
                      submitOnly: false,
                      comments: claimDetailsModel!.data.comments,
                      claimId: widget.claimId,
                      status: claimDetailsModel!.data.status,
                    ),
                    _techWorkButtons(),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showAttachmentDialog(context,
                            (List<File> selectedFiles) async {
                          uploadFile(context, selectedFiles);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25, left: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.textFieldBorder),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8.adaptSize),
                          child: Row(
                            children: [
                              const SVGImageWidget(
                                  image: AssetsManager.upload,
                                  width: 15,
                                  height: 15),
                              SizedBox(width: 8.w),
                              Text(
                                'uploadAnyFiles'.tr,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mainColor,
                                ),
                              ),
                              const Spacer(),
                              imageFiles.isEmpty
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () async {
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
                    SizedBox(
                      height: 10.h,
                    ),
                    AddMaterialsButton(
                      materials: claimDetailsModel!.data.material,
                      referenceId: claimDetailsModel!.data.referenceId,
                      claimId: claimDetailsModel!.data.id,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReassignButton(
                      ctx: context,
                      estimateTime: claimDetailsModel!
                          .data.subCategory.estimationTime
                          .toString(),
                      btName: 'reassign'.tr,
                      technicalList: technicalList,
                      claimId: widget.claimId,
                      referenceId: widget.referenceId,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PriorityButton(
                      claimId: widget.claimId,
                      referenceId: widget.referenceId,
                      ctx: context,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String employeeName() {
    if (claimDetailsModel!.data.employees.isEmpty) {
      print('here');
      return 'notAssigned'.tr;
    } else {
      print('here1');
      claimDetailsModel!.data.employees.sort((a, b) {
        DateTime createdAtA = DateTime.parse(a.created_at);
        DateTime createdAtB = DateTime.parse(b.created_at);
        return createdAtA.compareTo(createdAtB); // Ascending order
      });
      return claimDetailsModel!
          .data.employees[claimDetailsModel!.data.employees.length - 1].name;
    }
  }

  Widget _techWorkButtons() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  BlocProvider.of<ClaimDetailsCubit>(context)
                      .startAndEndWork(widget.claimId)
                      .then((value) {
                    if (value) {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    }
                  });
                },
                child: AssignButton(
                  borderColor: AppColors.mainColor,
                  horizontalMargin: 0,
                  btText: 'start'.tr,
                  image: '',
                  width: 280.w,
                  height: 40,
                  btColor: AppColors.whiteColor,
                  btTextColor: AppColors.mainColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget checkTechnicalState(TechnicalState state) {
    if (state is TechnicianIsLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.mainColor,
        ),
      );
    } else if (state is TechnicianError) {
      bool isUnauthenticated = state.msg.contains('Unauthenticated.');
      return ErrorWidgetItem(
        onTap: () {
          if (isUnauthenticated) {
            Get.offAll(const LoginScreen());
          } else {
            getData();
          }
        },
        isUnauthenticated: isUnauthenticated,
      );
    } else if (state is TechnicianLoaded) {
      technicalList = state.model.data;
      return _detailsWidget();
    } else {
      return _detailsWidget();
    }
  }

  Widget checkState(ClaimDetailsState state) {
    if (state is ClaimDetailsIsLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.mainColor,
        ),
      );
    } else if (state is ClaimDetailsError) {
      bool isUnauthenticated = state.msg.contains('Unauthenticated.');
      return ErrorWidgetItem(
        onTap: () {
          if (isUnauthenticated) {
            Get.offAll(const LoginScreen());
          } else {
            getData();
          }
        },
        isUnauthenticated: isUnauthenticated,
      );
    } else if (state is ClaimDetailsLoaded) {
      claimDetailsModel = state.model;
      return _detailsWidget();
    } else {
      return _detailsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClaimDetailsCubit, ClaimDetailsState>(
      listener: (context, state) {
        if (state is ClaimDeleted) {
          print("✅ Claim deleted — navigating to home");
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home,
                (route) => false,
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
  child: Scaffold(
      body: BlocBuilder<ClaimDetailsCubit, ClaimDetailsState>(
        builder: (context, claimDetailsState) {
          return BlocBuilder<TechnicalCubit, TechnicalState>(
            builder: (context, technicalState) {
              if (claimDetailsState is ClaimDetailsIsLoading ||
                  technicalState is TechnicianIsLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.mainColor));
              } else if (claimDetailsState is ClaimDetailsError ||
                  technicalState is TechnicianError) {
                bool isUnauthenticated = false;
                if (claimDetailsState is ClaimDetailsError) {
                  isUnauthenticated =
                      claimDetailsState.msg.contains('Unauthenticated.');
                }
                return ErrorWidgetItem(
                  onTap: () {
                    if (isUnauthenticated) {
                      Get.offAll(const LoginScreen());
                    } else {
                      getData();
                    }
                  },
                  isUnauthenticated: isUnauthenticated,
                );
              } else if (claimDetailsState is ClaimDetailsLoaded &&
                  technicalState is TechnicianLoaded) {
                claimDetailsModel = claimDetailsState.model;
                technicalList = technicalState.model.data;
                return _detailsWidget();
              } else {
                return _detailsWidget();
              }
            },
          );
        },
      ),
    ),
);
  }
}
