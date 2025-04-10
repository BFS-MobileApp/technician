import 'package:flutter/cupertino.dart';
import 'package:technician/core/utils/app_strings.dart';

import '../../../../config/PrefHelper/helper.dart';


abstract class AlignmentType{

  Alignment returnAlignment();

}

class AlignmentWidget extends AlignmentType{
  @override
   Alignment returnAlignment() {
    if(Helper.getCurrentLocal()==AppStrings.arCountryCode){
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

}