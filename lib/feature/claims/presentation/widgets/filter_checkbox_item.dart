import 'package:flutter/material.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:technician/widgets/text_widget.dart';

class FilterCheckboxItem extends StatefulWidget {

  String image;
  String text;
  final ValueChanged<bool> onChanged;
  FilterCheckboxItem({super.key , required this.image , required this.text ,required this.onChanged});

  @override
  State<FilterCheckboxItem> createState() => _FilterCheckboxItemState();
}

class _FilterCheckboxItemState extends State<FilterCheckboxItem> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
              widget.onChanged(value);
            });
          },
        ),
        SVGImageWidget(image: widget.image, width: 24.w, height: 24.h),
        SizedBox(width: 5.w,),
        TextWidget(text: widget.text, fontSize: 17.fSize , fontWeight: FontWeight.w700, fontColor: Theme.of(context).textTheme.bodySmall!.color,)
      ],
    ));
  }
}
