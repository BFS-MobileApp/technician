import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/button_widget.dart';

import '../feature/claims/data/models/technician_model.dart';

class AssignMenu{

  final BuildContext context;
  final String time;
  final List<Datum> technicians;

  String selectedOption = '';
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  bool chooseStartDate = false;
  bool chooseEndDate = false;

  AssignMenu({required this.context , required this.time , required this.technicians});


  DateTime addTimeToSecondDate() {
    final parts = time.split(':');
    final int hours = int.parse(parts[0]);
    final int minutes = int.parse(parts[1]);

    // Add hours and minutes to the second date
    DateTime updatedSecondDate = DateTime.now().add(Duration(hours: hours, minutes: minutes));

    return updatedSecondDate;
  }

  void assignMenu2() {
    selectedOption = technicians[0].name;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0.adaptSize),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'selectOption'.tr,
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                    ),
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    items: technicians.map((Datum tech) {
                      return DropdownMenuItem<String>(
                        value: tech.name,
                        child: Text(tech.name),
                      );
                    }).toList(),
                  ),
                  // Remaining widgets here...
                ],
              ),
            );
          },
        );
      },
      isDismissible: false,
      enableDrag: false,
    );
  }
}