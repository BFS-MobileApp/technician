import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:technician/config/PrefHelper/helper.dart';
import 'package:technician/config/arguments/routes_arguments.dart';
import 'package:technician/config/routes/app_routes.dart';
import 'package:technician/core/utils/app_colors.dart';
import 'package:technician/core/utils/app_consts.dart';
import 'package:technician/core/utils/assets_manager.dart';
import 'package:technician/core/utils/size_utils.dart';
import 'package:technician/feature/claims/data/models/claims_model.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_cubit.dart';
import 'package:technician/feature/claims/presentation/cubit/claims_state.dart';
import 'package:technician/feature/claims/presentation/widgets/claim_card_item.dart';
import 'package:get/get.dart';
import 'package:technician/feature/claims/presentation/widgets/filter_item.dart';
import 'package:technician/widgets/app_headline_widget.dart';
import 'package:technician/widgets/back_button_widget.dart';
import 'package:technician/widgets/empty_data_widget.dart';
import 'package:technician/widgets/error_widget.dart';
import 'package:technician/widgets/svg_image_widget.dart';
import 'package:pdf/widgets.dart' as pw;

class ClaimScreen extends StatefulWidget {

  int screenId;
  ClaimScreen({super.key , required this.screenId});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {

  ClaimsModel? model;
  Map<String , dynamic> data = {};
  String startDate = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData(){
    switch (widget.screenId){
      case 0:
        data = {
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 1:
        data = {
          "status":"new",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 2:
        data = {
          "status":"assigned",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 3:
        data = {
          "status":"started",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 4:
        data = {
          "status":"completed",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 5:
        data = {
          "status":"cancelled",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
      case 6:
        data = {
          "status":"closed",
          "per_page":"200"
        };
        BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
    }
  }

  void filter(){
    if(data.containsKey('status')){
      String status = data['status'];
      data = {
        "status": status,
      };
    } else {
      data = {

      };
    }
    BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
  }

  Widget screenWidget(){
    return Column(
      children: [
        appHeader(),
        Expanded(
          child: ListView(
            children: [
              _claimsList()
            ],
          ),
        ),
      ],
    );
  }

  Widget _claimsList(){
    return ListView.builder(shrinkWrap: true , physics:  const ScrollPhysics() , padding: const EdgeInsets.all(8.0) , itemCount: model!.data.length , itemBuilder: (ctx , pos){
      return InkWell(
        onTap: (){
          if(AppConst.viewClaims){
            switchScreen(pos);
          }
        },
        child: ClaimCardItem(unitNo: model!.data[pos].unit.name , ctx: context , key: ValueKey(model!.data[pos].id),estimateTime: model!.data[pos].subCategory.estimationTime.toString() ,claimId: model!.data[pos].id.toString(), referenceId: model!.data[pos].referenceId,buildingName: model!.data[pos].unit.building , status: model!.data[pos].status,availableTime: Helper.getAvailableTime(model!.data[pos].availableTime),date: Helper.formatDateTime(model!.data[pos].createdAt),priority: model!.data[pos].priority,type: '${model!.data[pos].category.name}- ${model!.data[pos].subCategory.name} - ${model!.data[pos].type.name}',screenId: widget.screenId,),
      );
    });
  }

  String test(String item){
    String test = item.toString();
    return test;
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    final arabicFont = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoNaskhArabic-Medium.ttf'));
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => <pw.Widget>[
          pw.Wrap(
            children: List<pw.Widget>.generate(model!.data.length, (int pos) {
              return _buildClaimCardPdf(arabicFont, model!.data[pos].referenceId.toString(), model!.data[pos].unit.building, test(model!.data[pos].status), test(model!.data[pos].priority), '${model!.data[pos].category.name}- ${model!.data[pos].subCategory.name} - ${model!.data[pos].type.name}', Helper.formatDateTime(model!.data[pos].createdAt), Helper.getAvailableTime(model!.data[pos].availableTime));
            }),
          ),
        ],
      ),
    );

    // Print the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  pw.Widget _buildClaimCardPdf(
      pw.Font arabicFont,
      String id,
      String buildingName,
      String status,
      String priority,
      String type,
      String date,
      String availableTime,
      ) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColors.white,
          borderRadius: pw.BorderRadius.circular(12.0),
          boxShadow: const [
            pw.BoxShadow(
              color: PdfColors.grey300,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: pw.Padding(
          padding: pw.EdgeInsets.all(16.0.fSize),
          child: pw.Container(
            margin: pw.EdgeInsets.symmetric(horizontal: 5.w),
            child: pw.SizedBox(
              height: 180.h,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            id,
                            style: pw.TextStyle(
                              fontSize: 16.fSize,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3.h),
                          pw.Directionality(
                            textDirection: pw.TextDirection.rtl,
                            child: pw.Text(
                              buildingName,
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 12.fSize,
                                fontWeight: pw.FontWeight.normal,
                                color: PdfColors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text(
                          status,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 12.fSize,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 5.h),
                  pw.Divider(thickness: 1, color: PdfColors.grey),
                  pw.SizedBox(height: 8.h),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Priority:',
                        style: pw.TextStyle(
                          fontSize: 12.fSize,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Directionality(
                       textDirection: pw.TextDirection.rtl,
                        child: pw.Text(
                          priority,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 12.fSize,
                            color: PdfColors.red,
                          ),
                        )
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8.h),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Type:',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 12.fSize,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text(
                          type,
                          maxLines: 4,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 12.fSize,
                            color: PdfColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8.h),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Created Date:',
                        style: pw.TextStyle(
                          fontSize: 12.fSize,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        date,
                        style: pw.TextStyle(
                          fontSize: 12.fSize,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8.h),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Available Time:',
                        style: pw.TextStyle(
                          fontSize: 12.fSize,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text(
                          availableTime,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 12.fSize,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8.fSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget appHeader(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      child: Card(
        elevation: 1,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.adaptSize),
          child: Column(
            children: [
              Row(
                children: [
                  const BackButtonWidget(),
                  Container(
                    margin: EdgeInsets.only(top: 4.w),
                    child: AppHeadline(
                      title: Helper.returnScreenAppBarName(widget.screenId),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              Row(
                children: [
                  SizedBox(
                      height: 40.h,
                      width: 240.w,
                      child: TextField(
                        onChanged: ((value){
                          if(value.isEmpty || value == ''){
                            BlocProvider.of<ClaimsCubit>(context).getAllClaims(data);
                          } else {
                            search(value);
                          }
                        }),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search , color: Colors.black38,),
                          hintText: 'search'.tr,
                          contentPadding: EdgeInsets.only(top: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0), // Rounded corners
                            borderSide: BorderSide.none, // No border line
                          ),
                          filled: true, // Background color
                          fillColor: Colors.grey[200], // Light grey background
                        ),
                      )
                  ),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: _showFilterBottomSheet,
                    child: Card(
                      color: AppColors.whiteColor,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(5.adaptSize),
                        child: Center(
                          child: SVGImageWidget(image: AssetsManager.filter, width: 18.w, height: 18.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  InkWell(
                    onTap: generatePdf,
                    child: Card(
                      elevation: 2,
                      child: SVGImageWidget(image: AssetsManager.sort, width: 18.w, height: 18  .h),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void switchScreen(int index) async {
    final claimDetailsArgs = ClaimDetailsArguments(
      claimId: model!.data[index].id.toString(),
      referenceId: model!.data[index].referenceId,
    );
    switch (widget.screenId) {
      case 0:
        switchAllClaimScreen(index);
        break;
      case 1:
        final result = await Navigator.pushNamed(
          context,
          Routes.newClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 2:
        final result = await Navigator.pushNamed(
          context,
          Routes.assignedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 3:
        final result = await Navigator.pushNamed(
          context,
          Routes.startedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 4:
        final result = await Navigator.pushNamed(
          context,
          Routes.completedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 5:
        final result = await Navigator.pushNamed(
          context,
          Routes.cancelledClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 6:
        final result = await Navigator.pushNamed(
          context,
          Routes.closedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
    }
  }

  Future<void> switchAllClaimScreen(int index) async {
    final claimDetailsArgs = ClaimDetailsArguments(
      claimId: model!.data[index].id.toString(),
      referenceId: model!.data[index].referenceId,
    );

    switch (model!.data[index].status) {
      case 'تم اختيار فني':
      case 'Assigned':
        final result = await Navigator.pushNamed(
          context,
          Routes.assignedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 'جديد':
      case 'New':
        final result = await Navigator.pushNamed(
          context,
          Routes.newClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 'ملغي':
      case 'Cancelled':
        final result = await Navigator.pushNamed(
          context,
          Routes.cancelledClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 'مكتمل':
      case 'Completed':
        final result = await Navigator.pushNamed(
          context,
          Routes.completedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 'بدأت':
      case 'Started':
        final result = await Navigator.pushNamed(
          context,
          Routes.startedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      case 'مغلق':
      case 'Closed':
        final result = await Navigator.pushNamed(
          context,
          Routes.closedClaims,
          arguments: claimDetailsArgs,
        );
        if (result == true) {
          getData();
        }
        break;
      default:
        break;
    }
  }

  Widget _addNewClaim(){
    if(widget.screenId == 0 && AppConst.createClaims){
      return Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Ensuring it's circular
          ),
          backgroundColor: AppColors.mainColor,
          onPressed: (){
            Navigator.pushNamed(context, Routes.addNewClaim);
          },
          child: Icon(Icons.add , size: 30.adaptSize,color: AppColors.whiteColor,),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void search(String item) {
    setState(() {
      model!.data = model!.data
          .where((element) => element.referenceId.contains(item))
          .toList();
    });
  }

  void _showFilterBottomSheet() async{
    final filterData = await showModalBottomSheet<Map<String, dynamic>>(
      isScrollControlled:true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.96,
          child: FilterBottomSheetContent(menuName: 'filterBy'.tr , data: data,),
        );
      },
    );
  }

  Widget checkState(ClaimsState state){
    if(state is ClaimsIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is ClaimsError){
      return ErrorWidgetItem(onTap: ()=>getData());
    } else if(state is ClaimsLoaded) {
      if(state.model.data.isEmpty){
        return EmptyDataWidget();
      } else {
        model = state.model;
        return screenWidget();
      }
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsCubit , ClaimsState>(builder: (context , state){
      return WillPopScope(
        onWillPop: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.main,
                  (Route<dynamic> route) => false,
            );
          return true;
        },
        child: Scaffold(
            floatingActionButton: _addNewClaim(),
            body: checkState(state)
        ),
      );
    });
  }
}