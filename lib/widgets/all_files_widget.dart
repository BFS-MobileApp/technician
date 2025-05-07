import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/widgets/text_widget.dart';
import '../feature/new claim/presentation/cubit/new_claim_cubit.dart';
import '../feature/new claim/presentation/cubit/new_claim_state.dart';

class AllFilesWidget extends StatefulWidget {
  final Comments images;
  final int height;
  final List<FileElement> files;
  final bool ifUpdate;
  final String claimId;

  const AllFilesWidget({
    super.key,
    required this.images,
    this.height = 100,
    required this.files,
    required this.ifUpdate,
    required this.claimId,
  });

  @override
  State<AllFilesWidget> createState() => _AllFilesWidgetState();
}

class _AllFilesWidgetState extends State<AllFilesWidget> {
  bool _isDeleting = false;
  List<FileElement> _displayedFiles = [];

  @override
  void initState() {
    super.initState();

    final commentFiles = widget.images.data
        .expand((element) => (element.files ?? []).map((f) => FileElement.fromJson(f)))
        .where((f) => f.fileId != null && f.fileUrl != null)
        .toList();

    final directFiles = widget.files
        .where((f) => f.fileId != null && f.fileUrl != null)
        .toList();

    _displayedFiles = widget.ifUpdate ? directFiles : [...commentFiles, ...directFiles];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewClaimCubit, NewClaimState>(
      listener: (context, state) {
        if (state is FileDeleted) {
          setState(() => _isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
           const  SnackBar(content: Text("Image Deleted Successfuly"), backgroundColor: Colors.green),
          );
        } else if (state is NewClaimError) {
          setState(() => _isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.msg), backgroundColor: Colors.red),
          );
        }
      },
      child: _isDeleting
          ? const Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'allFiles'.tr,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w600,
              fontColor: Theme.of(context).textTheme.bodySmall?.color,
            ),
            SizedBox(height: 8.h),
            if (_displayedFiles.isNotEmpty)
              SizedBox(
                height: 70.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _displayedFiles.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final file = _displayedFiles[index];
                    final fileUrl = file.fileUrl!;
                    final fileId = file.fileId!;

                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.fullScreenImage,
                              arguments: FullScreenImageArguments(image: fileUrl),
                            );
                          },
                          child: Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(fileUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        if (widget.ifUpdate)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.close, size: 18, color: Colors.red),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Delete Image'),
                                      content: const Text('Do you want to delete this image?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            setState(() => _isDeleting = true);
                                            context.read<NewClaimCubit>().deleteFile(widget.claimId, fileId.toString()).then((_) {
                                              setState(() {
                                                _displayedFiles.removeAt(index);
                                              });
                                            });
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
