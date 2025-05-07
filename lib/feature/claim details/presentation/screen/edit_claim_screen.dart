import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/new%20claim/data/models/avaliable_time_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../widgets/all_files_widget.dart';
import '../../../../widgets/app_headline_widget.dart';
import '../../../../widgets/svg_image_widget.dart';
import '../../../new claim/data/models/category_model.dart';
import '../../../new claim/data/models/claim_type_model.dart';
import '../../../new claim/data/models/unit_model.dart';
import '../../../new claim/presentation/cubit/new_claim_cubit.dart';
import '../../../new claim/presentation/cubit/new_claim_state.dart';

class EditClaimScreen extends StatefulWidget {
  final ClaimDetailsModel claimsModel;
  const EditClaimScreen(
      {super.key,
        required this.claimsModel});

  @override
  State<EditClaimScreen> createState() => _EditClaimScreenState();
}

class _EditClaimScreenState extends State<EditClaimScreen> {
   TextEditingController _descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedType;
  String? selectedTime;
  String? selectedPriorty;
  bool isDateTimeSelected = false;
  DateTime selectedDate = DateTime.now();
  File filePicker = File('');
  List<XFile> imageFiles = [];
  CategoryModel? categoryModel;
  CategoryModel? subCategoryModel;
  ClaimsTypeModel? typeModel;
  AvailableTimeModel? availableTimeModel;
  List<DropdownMenuItem<String>> categoryItems = [];
  List<DropdownMenuItem<String>> subCategoryItems = [];
  List<String> priorityItems = ['low', 'high', 'normal', 'medium', 'urgent'];
  List<DropdownMenuItem<String>> priorityDropdownItems  = [];
  List<DropdownMenuItem<String>> typeItems = [];
  List<DropdownMenuItem<String>> timeItems = [];
  ImagePicker picker = ImagePicker();
  void showAttachmentDialog(BuildContext context, Function(List<XFile>) onFilesSelected) {
    List<XFile> selectedFiles = [];

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
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
                          setBottomSheetState(() {
                            selectedFiles = images;
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
                          setBottomSheetState(() {
                            selectedFiles.addAll(images);
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
                    Text("Selected Files:", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                    setBottomSheetState(() {
                                      selectedFiles.removeAt(index);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close, size: 14, color: Colors.white),
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
                        onFilesSelected(selectedFiles);
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
      updateImages(pickedFiles); // Call function to update images inside bottom sheet
    }
  }
  Future<void> getImageFromCamera(Function(List<XFile>) updateImages) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      updateImages([XFile(pickedFile.path)]); // Pass the new image as an XFile list
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
  void getSubCategoriesItems(int id) {
    final matchedParent = categoryModel!.data.firstWhere((e) => e.id == id);
    final subCats = matchedParent.child;

    if (subCats != null && subCats.data.isNotEmpty) {
      final items = subCats.data
          .map((subCat) => DropdownMenuItem<String>(
        value: subCat.id.toString(),
        child: Text(subCat.name),
      ))
          .toList();

      // Check if default matches
      final matchingSubCat = subCats.data.firstWhere(
            (sc) => sc.name == widget.claimsModel.data.subCategory.name,
        orElse: () => subCats.data.first,
      );

      final defaultValue = matchingSubCat.id.toString();

      setState(() {
        subCategoryItems = items;
        selectedSubCategory = defaultValue;
      });

      // Optionally, load types based on default subcategory
      context.read<NewClaimCubit>().getClaimsType(defaultValue);
    } else {
      setState(() {
        subCategoryItems = [];
        selectedSubCategory = null;
      });
    }
  }



  @override
  void initState() {
    super.initState();
    intializeDate();
    context.read<NewClaimCubit>().getCategories(widget.claimsModel.data.unit.id.toString());
    context.read<NewClaimCubit>().
    getAvailableTimes("22");
    selectedDate = widget.claimsModel.data.availableDate;
    _descriptionController.text = widget.claimsModel.data.description;
  }
  void intializeDate() async{
    await initializeDateFormatting();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<NewClaimCubit, NewClaimState>(
          listener: (context, state) {
            if (state is CategoryLoaded) {
              setState(() {
                categoryModel = state.categoryModel;
                categoryItems = state.categoryModel.data
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id.toString(),
                          child: Text(e.name),
                        ))
                    .toList();
                if (categoryModel!.data.isNotEmpty) {
                  getSubCategoriesItems(widget.claimsModel.data.category.id);
                  final matchedCategory = categoryModel!.data.firstWhere(
                        (cat) => cat.name == widget.claimsModel.data.category.name,
                    orElse: () => categoryModel!.data.first,
                  );

                  selectedCategory = matchedCategory.id.toString();
                }
                priorityDropdownItems = priorityItems.map((priority) {
                  String assetIcon;

                  switch (priority.toLowerCase()) {
                    case 'urgent':
                      assetIcon = AssetsManager.urgentPriority;
                      break;
                    case 'high':
                      assetIcon = AssetsManager.highPriority;
                      break;
                    case 'medium':
                      assetIcon = AssetsManager.mediumPriority;
                      break;
                    case 'normal':
                      assetIcon = AssetsManager.normalPriority;
                      break;
                    case 'low':
                    default:
                      assetIcon = AssetsManager.lowPriority;
                  }

                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          assetIcon,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(priority[0].toUpperCase() + priority.substring(1)),
                      ],
                    ),
                  );
                }).toList();

                if (priorityItems.isNotEmpty) {
                  final matchedPriority = priorityItems.firstWhere(
                        (p) => p.toLowerCase() == widget.claimsModel.data.priority.toLowerCase(),
                    orElse: () => priorityItems.first,
                  );

                  selectedPriorty = matchedPriority;
                }

              });
            } else if (state is AddNewClaimLoaded) {
              // ✅ Update Success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Claim updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacementNamed(context, Routes.home);
            } else if (state is NewClaimError) {
              // ❌ Update Failed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ),
              );
            }
            else if (state is ClaimsTypeLoaded) {
              setState(() {
                typeModel = state.claimsTypeModel;
                typeItems = state.claimsTypeModel.data
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id.toString(),
                          child: Text(e.name),
                        ))
                    .toList();
                if (typeModel!.data.isNotEmpty) {
                  final matchedCategory = typeModel!.data.firstWhere(
                        (cat) => cat.name == widget.claimsModel.data.type.name,
                    orElse: () => typeModel!.data.first,
                  );

                  selectedType = matchedCategory.id.toString();
                }
              });
            } else if (state is AvailableTimesLoaded) {
              setState(() {
                availableTimeModel = state.availableTimeModel;
                timeItems = state.availableTimeModel.data
                    .map((e) => DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(e.name),
                        ))
                    .toList();
                if (availableTimeModel!.data.isNotEmpty) {
                  final matchedCategory = availableTimeModel!.data.firstWhere(
                        (cat) => cat.name == widget.claimsModel.data.availableTime,
                    orElse: () => availableTimeModel!.data.first,
                  );

                  selectedTime = matchedCategory.name;
                }
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  appHeader(),
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          elevation: 0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.claimsModel.data.referenceId,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue[600],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Unit',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 60),
                                    Row(
                                      children: [
                                        Text(
                                          widget.claimsModel.data.unit.building,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[900],
                                          ),
                                        ),
                                        const Text(" - "),
                                        Text(
                                          widget.claimsModel.data.unit.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Category
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedCategory,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      border: InputBorder.none,
                                      hintText: 'Claim Category',
                                    ),
                                    items: categoryItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                      getSubCategoriesItems(int.parse(value!));
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Sub Category
                                const Text(
                                  'Sub Category',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedSubCategory,
                                    items: subCategoryItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSubCategory = value;
                                      });
                                      context.read<NewClaimCubit>().getClaimsType(value!);
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Claim Sub Category',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Type
                                const Text(
                                  'Type',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedType,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      border: InputBorder.none,
                                      hintText: 'Claim Type',
                                    ),
                                    items: typeItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Priority
                                const Text(
                                  'Priority',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedPriorty,
                                    items: priorityDropdownItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPriorty = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Priority',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Available Date & Time',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {
                                    final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate:DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now().add(const Duration(days: 100000)));
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                        isDateTimeSelected = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.textFieldBorder),
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('yyyy-MM-dd', 'en').format(selectedDate),
                                          style: TextStyle(
                                            fontSize:14,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        const SVGImageWidget(image: AssetsManager.calender, width: 20, height: 20)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedTime,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      border: InputBorder.none,
                                      hintText: 'Available Time',
                                    ),
                                    items: timeItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTime = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Description
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  height: 140,
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      hintText: 'Type Your Complaints Here',
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AllFilesWidget(images: widget.claimsModel.data.comments,
                                  files: widget.claimsModel.data.files,
                                  ifUpdate: true,
                                  claimId: widget.claimsModel.data.id.toString(),),
                                SizedBox(height: 10.h,),
                                GestureDetector(
                                  onTap: () async {
                                    showAttachmentDialog(context, (List<XFile> selectedFiles) async {
                                      setState(() {
                                        imageFiles = selectedFiles;
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.textFieldBorder),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          const SVGImageWidget(image: AssetsManager.upload, width: 15, height: 15),
                                          SizedBox(width: 8.w),
                                          Text(
                                            imageFiles.isEmpty
                                                ? 'uploadAnyFiles'.tr
                                                : 'Selected (${imageFiles.length})',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
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
                                                filePicker = File('');
                                              });
                                            },
                                            child: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                // Buttons
                                Row(
                                  children: [
                                    // Update Button
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (selectedCategory != null &&
                                                selectedSubCategory != null &&
                                                selectedType != null &&
                                                selectedTime != null &&
                                                _descriptionController.text.trim().isNotEmpty) {

                                              // ✅ Check if user selected images
                                              if (imageFiles.isNotEmpty) {
                                                final files = imageFiles.map((xfile) => File(xfile.path)).toList();

                                                // ✅ Call uploadFile first
                                                final success = await context.read<ClaimDetailsCubit>().uploadFile(
                                                  context,
                                                  widget.claimsModel.data.id.toString(),
                                                  files,
                                                );

                                                if (!success) {
                                                  // ❌ Upload failed, show error and STOP
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Failed to upload files. Please try again.'), backgroundColor: Colors.red),
                                                  );
                                                  return; // Stop here
                                                }
                                              }

                                              // ✅ If upload successful or no files, continue updateClaim
                                              context.read<NewClaimCubit>().updateClaim(
                                                selectedCategory!,
                                                selectedSubCategory!,
                                                selectedType!,
                                                _descriptionController.text.trim(),
                                                selectedTime!,
                                                DateFormat('yyyy-MM-dd').format(selectedDate),
                                                widget.claimsModel.data.id.toString(),
                                                selectedPriorty!,
                                              );

                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Please fill all fields before updating.'), backgroundColor: Colors.red),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green[600],
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Update',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Cancel Button
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: AppStrings.appLocal != 'en'
                              ? RotatedBox(
                                  quarterTurns: 2,
                                  child: SvgPicture.asset(
                                    AssetsManager.backIcon,
                                    width: 16.w,
                                    height: 16.h,
                                  ),
                                )
                              : SvgPicture.asset(
                                  AssetsManager.backIcon,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.w),
                  child: AppHeadline(
                    title: "editClaim".tr,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
