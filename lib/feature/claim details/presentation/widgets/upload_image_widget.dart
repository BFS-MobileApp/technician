import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/claim_details_model.dart';
import '../cubit/claim_details_cubit.dart';
class UploadImageWidget extends StatefulWidget {
  String claimId;
   UploadImageWidget({super.key , required this.claimId});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}


class _UploadImageWidgetState extends State<UploadImageWidget> {
  ClaimDetailsModel? claimDetailsModel;
  Future<void> _pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.files.map((file) => File(file.path!)).toList();

      for (File file in files) {
        _uploadFile(context, file);
      }
    }
  }

  void _uploadFile(BuildContext context, File file) {
    final cubit = context.read<ClaimDetailsCubit>();
    cubit.addComment(widget.claimId, "Uploaded a file", claimDetailsModel!.data.status).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File uploaded successfully: ${file.path}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload file: ${file.path}")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickFiles(context),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text("Upload Any Files", style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
