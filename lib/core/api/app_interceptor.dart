  import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:technician/config/PrefHelper/prefs.dart';
import 'package:technician/core/utils/app_strings.dart';

import '../../config/PrefHelper/helper.dart';

class AppInterceptor extends Interceptor{


  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    Map<String , dynamic> headers = {};
    headers = getHeaders();
    options.headers = headers;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }

  Map<String , dynamic> getHeaders(){
    String token = '';
    String local = '';

    if(Prefs.isContain(AppStrings.token)){
      token = Prefs.getString(AppStrings.token);
    }

    print("Retrieved Token: $token");  // Debugging step

    if(Helper.getCurrentLocal() == 'US'){
      local = 'en';
    } else {
      local = 'ar';
    }

    Map<String , dynamic> header = {
      "Accept":"application/json",
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'lang': local
    };

    print("Request Headers: $header");  // Debugging step
    return header;
  }

}