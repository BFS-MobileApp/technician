import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_AR': {
      "welcome":"اهلا",
      "noData":"لا يوجد بيانات",
      "welcomePhase":"مرحبا بك في كلاميزر",
      "login":"تسجيل الدخول",
      "email":"البريد الالكتروني",
      "search":"بحث",
      "password":"كلمة المرور",
      "assignedClaims":"طلبات الصيانة لدى الفنيين",
      "startedClaims":"طلبات الصيانة تحت الإجراء",
      "completedClaims":"طلبات الصيانة المكتملة",
      "cancelledClaims":"طلبات الصيانة الملغاة",
      "closedClaims":"طلبات الصيانة المغلقة",
      "building":"مبني",
      "propertyUnit":"وحدة العقار",
      "createdDate":"تاريخ الانشاء",
      "claimCategory":"الفئة الرئيسية",
      "claimSubCategory":"الفئة الفرعية",
      "claimType":"نوع الطلب",
      "assignTo":"أسند الي",
      "status":"الحالة",
      "priority":"أولوية",
      "description":"الوصف",
      "name":"الاسم",
      "phone":"رقم الهاتف",
      "claimsScreen ":"الطلبات",
      "assign":"تعيين",
      'replies':"تعليقات",
      "submit":"أرسال",
      "statisticsForYourClaims":"إحصائيات طلبات الصيانة",
      "logOut":"تسجيل الخروج",
      "language":"اللغة",
      "emptyEmail":"من فضلك ادخل البريد الالكتروني",
      "emptyPassword":"من فضلك ادخل كلمه المرور",
      "profile":"الملف الشخصي",
      "help":"مساعدة",
      "support":"الدعم",
      "privacy":"سياسة الخصوصية",
      "allClaims":"طلبات الصيانة",
      "newClaims":"طلبات الصيانة الجديدة",
      "editProfile":"تعديل الملف الشخصي",
      "personalProfile":"الملف الشخصي",
      "saveChanges":"حفظ التغيرات",
      "basicInfo":"معلومات اساسية",
      "updatePassword":"تعديل كلمة المرور",
      "oldPassword":"كلمة المرور القديمة",
      "confirmPassword":"تأكيد كلمة المرور",
      "emailNotifications":"الاشعارات",
      "enable":"تمكين",
      "disable":"تعطيل",
      "claimsScreen":"الطلبات",
      "notification":"الاشعارات",
      "home":"الصفحة الرئيسية",
      "calendar":"المواعيد",
      "settings":"الاعدادات",
      "somethingWentWrong":"حدث خطأ ما",
      "pleaseTryAgain":"من فضلك و اعد المحاولة",
      "reloadScreen":"اعادة التحميل",
      "medium":"متوسط",
      "new":"جديد",
      "assigned":"تم اختيار فني",
      "anyTime":"أي وقت",
      "rememberThat":" إجراءات سريعة",
      "signerName":"اسم المُوَقِّع",
      "buildingId": "رقم المبنى",
      "takePhoto": "التقاط صورة",
      "uploadImageFrom": "رفع صورة من",
      "fromGallery": "من المعرض",
      "noImageSelected": "لم يتم تحديد صورة",
      "filterBy": "تصفية حسب",
      "date": "التاريخ",
      "claimFixer": "تطبيق فني الصيانة",
      "techniciansAndStaff": "الفنيين والموظفين",
      "capitalLogin": "تسجيل الدخول",
      "emailAddress": "عنوان البريد الإلكتروني",
      "rememberMe": "تذكرني",
      "forgotPassword": "نسيت كلمة المرور؟",
      "forgotPasswordWithoutMark": "نسيت كلمة المرور",
      "forgotPasswordPhase": "أدخل بريدك الإلكتروني وسيتم إرسال التعليمات إليك!",
      "sendRequestLink": "إرسال رابط الطلب",
      "type": "النوع",
      "availableTime": "الوقت المتاح",
      "uploadPhoto": "رفع صورة",
      "takeNewPhoto": "التقط صورة جديدة",
      "profilePhoto": "صورة الملف الشخصي",
      "addNewClaim": "إضافة طلب جديد",
      "selectBuilding": "اختر المبنى",
      "selectUnit": "اختر الوحدة",
      "selectClaimCategory": "اختر الفئة الرئيسية",
      "selectClaimSubCategory": "اختر الفئة الفرعية",
      "selectClaimType": "اختر نوع الطلب",
      "selectAvailableTime": "اختر الوقت المتاح",
      "uploadAnyFiles": "رفع أي ملفات",
      "confirm": "تأكيد",
      "yourBuilding": "المبنى الخاص بك",
      "yourUnit": "الوحدة الخاصة بك",
      "confirmationAndSave": "التأكيد والحفظ",
      "claimCode": "رمز الطلب",
      "back": "رجوع",
      "startDate": "تاريخ البدء",
      "endDate": "تاريخ الانتهاء",
      "complete": "مكتمل",
      "low": "منخفض",
      "addAttendance":"أضافة حضور",
      "myAttendance":"حضوري",
      "high": "مرتفع",
      "normal": "عادي",
      "urgent": "عاجل",
      "allFiles": "جميع الملفات",
      "createdBy": "تم الإنشاء بواسطة",
      "phoneNumber": "رقم الهاتف",
      "submitAsClosed": "إرسال ك مغلقٍ",
      "endWork":"أنهاء العمل",
      "startWork":"بدء العمل",
      "submitAsStarted": "إرسال ك بدأ",
      "submitAsCompleted": "إرسال ك مكتمل",
      "tenantSignature": "توقيع المستأجر",
      "showResult": "عرض النتيجة",
      "typeYourReplyHere": "اكتب ردك هنا",
      "drawTenantSignature": "ارسم توقيع المستأجر",
      "signatureSavedTo": "تم حفظ التوقيع في",
      "downloadSignature": "تحميل التوقيع",
      "errorSavingSignatureToGallery": "حدث خطأ أثناء حفظ التوقيع في المعرض",
      "SignaturePadStateIsNull": "حالة لوحة التوقيع فارغة",
      "SignatureSavedToGallery": "تم حفظ التوقيع في المعرض",
      "noResult": "لا توجد نتائج",
      "refresh": "تحديث",
      "pleaseChooseAvailableTimeFirst": "يرجى اختيار الوقت المتاح أولاً",
      "pleaseSelectBuildingFirst": "يرجى اختيار المبنى أولاً",
      "pleaseSelectUnitFirst": "يرجى اختيار الوحدة أولاً",
      "pleaseSelectCategoryFirst": "يرجى اختيار الفئة أولاً",
      "pleaseSelectSubCategoryFirst": "يرجى اختيار الفئة الفرعية أولاً",
      "pleaseSelectClaimTypeFirst": "يرجى اختيار نوع الطلب أولاً",
      "pleaseChooseAvailableDateFirst": "يرجى اختيار التاريخ المتاح أولاً",
      "newClaimSuccessMessage": "شكراً لإرسال طلبك. سيتم التواصل معك قريباً من قبل أحد ممثلي خدمة العملاء.",
      "backToHome": "العودة إلى الصفحة الرئيسية",
      "pleaseAddDescriptionFirst": "يرجى إضافة وصف أولاً",
      "youDontHavePermission": "ليس لديك الإذن للوصول إلى هذه الصفحة.",
      "accessDenied": "تم رفض الوصول",
      "submitAsNew": "إرسال ك جديد",
      "submitAsAssigned": "إرسال ك معيّن",
      "submitAsCancelled": "إرسال ك ملغى",
      "acceptByMe": "قبول من قبلي",
      "changePriority": "تغيير الأولوية",
      "completeButton": "إكمال الطلب",
      "selectTechnician": "اختر الفني",
      "typeYourComplaintsHere": "اكتب شكواك هنا",
      "pleaseChooseTechnician": "يرجى اختيار فني",
      "pleaseChooseStartDate": "يرجى اختيار تاريخ البدء",
      "pleaseChooseEndDate": "يرجى اختيار تاريخ الانتهاء",
      "startDateMustBeBeforeEndDate": "يجب أن يكون تاريخ البدء قبل تاريخ الانتهاء",
      "pleaseChooseThePriority": "يرجى اختيار الأولوية",
      "pleaseWriteYourOldPassword": "يرجى كتابة كلمة المرور القديمة",
      "pleaseWriteYourPassword": "يرجى كتابة كلمة المرور",
      "pleaseWriteYourConfirmPassword": "يرجى كتابة تأكيد كلمة المرور",
      "pleaseMakeSurePasswordAndConfirmPasswordAreTheSame": "يرجى التأكد من أن كلمة المرور وتأكيدها متطابقان",
      "pleaseWriteYourName": "يرجى كتابة اسمك",
      "pleaseWriteYourPhone": "يرجى كتابة رقم هاتفك",
      "pleaseAddSubscriber": "يرجى إضافة المشترك",
      "clear": "مسح",
      "pleaseAddReplyFirst": "يرجى إضافة رد أولاً",
      "createdAt": "تاريخ الإنشاء",
      "claimDetails": "تفاصيل الطلب",
      "closed":"مغلق",
      "started":"بدأت",
      "cancelled":"ملغي",
      "close":"إغلاق",
      "reassign":"إعادة تعيين",
      "ok":"موافق",
      "newClaimDialogClaim":"تم إضافة طلب الصيانة",
      "newClaimDialogCreatedSuccessfully":"بنجاح",
      "startAClaim":"إبدأ العمل على",
      "claim":"الطلب",
      "history" : "السجل",
      "staff" : "الطاقم",
      "workingHours" : "ساعات العمل",
      "timeline" : "الخطه الزمنية",
      "unit" : "الوحدة",
      "checkIn":"حضور",
      "checkOut":"أنصراف",
      "remarks":"ملاحظات",
      "typeYourRemarksHere":"اكتب ملاحظاتك هنا",
      "dateTime":"التاريخ/الوقت",
      "in":"حضور",
      "out":"انصراف",
      "attendanceType":"نوع الحضور",
      "Technician" : "فني",
      "all":"الكل",
      "January": "يناير",
      "February": "فبراير",
      "March": "مارس",
      "April": "ابريل",
      "May": "مايو",
      "June": "يونيو",
      "July": "يوليو",
      "August": "اغسطس",
      "September": "سبتمبر",
      "October": "اكتوبر",
      "November": "نوفمبر",
      "December": "ديسمبر",
      "Upload Image From" : "استيراد صورة",
      "Take Photo" : "التقاط صورة",
      "From Gallery" : "معرض الصور",
      "start":"بدء العمل",
      "end":"انتهاء العمل",
      "startOn":"وقت البدء",
      "endOn":"وقت الأنتهاء",
      "duration":"المده",
      "pleaseEnableLocationFirst":"من فضلك قم بتشغيل الموقع",
      "pleaseAddRemarksFirst":"من فضلك قم بأضافه ملاحظه",
      "sessionExpired": "مده صلاحيه الدخول انتهت",
      "pleaseSignInAgain": "من فضلك سجل الدخول مجددا",
    },
    'en_US': {
      "From Gallery" : "From Gallery",
      "pleaseSignInAgain": "Please sign in again to continue",
  "Upload Image From" : "Upload Image From",
      "Take Photo" : "Take Photo",
      "Technician" : "Technician",
      "welcome":"Welcome",
      "noData":"There is no data",
      "welcomePhase":"Welcome Back To ClaimFixer",
      "login":"Login",
      "email":"Email",
      "password":"Password",
      "allClaims":"All Claims",
      "newClaims":"New Claims",
      "assignedClaims":"Assigned Claims",
      "startedClaims":"Started Claims",
      "completedClaims":"Completed Claims",
      "cancelledClaims":"Cancelled Claims",
      "closedClaims":"Closed Claims",
      "buildingId":"Building ID",
      "building":"Building",
      "propertyUnit":"Property Unit",
      "createdDate":"Created At",
      "claimCategory":"Claim Category",
      "claimSubCategory":"Claim Sub Category",
      "claimType":"Claim Type",
      "assignTo":"Assign To",
      "status":"Status",
      "priority":"Priority",
      "description":"Description",
      "name":"Name",
      "phone":"Phone",
      "claimsScreen ":"Claims Screen2",
      "assign":"Assign",
      "close":"Close",
      "accept":"Accept",
      "selectOption":"Select Option",
      'replies':"Replies",
      "submit":"Submit",
      "reassign":"Re-assign",
      "statisticsForYourClaims":"Claims Dashboard",
      "logOut":"Log Out",
      "help":"Help",
      "language":"Language",
      "support":"Support",
      "privacy":"Privacy And Policy",
      "profile":"Profile",
      "personalProfile":"Personal Profile",
      "saveChanges":"Save Changes",
      "basicInfo":"Basic Info",
      "updatePassword":"Update Password",
      "oldPassword":"Old Password",
      "confirmPassword":"Confirm Password",
      "editProfile":"Edit Profile",
      "emailNotifications":"Email Notifications",
      "enable":"Enable",
      "disable":"Disable",
      "takePhoto":"Take Photo",
      "uploadImageFrom":"Upload Image From",
      "fromGallery":"From Gallery",
      "noImageSelected":"No image selected",
      "filterBy":"Filter",
      "date":"Date",
      "emptyEmail":"Please enter your email",
      "emptyPassword":"Please enter your password",
      "claimsScreen":"Claims Screen",
      "claimFixer":"Claim Fixer",
      "techniciansAndStaff":"Technicians & Staff",
      "capitalLogin":"LOG IN",
      "emailAddress":"Email Address",
      "rememberMe":"Remember Me",
      "forgotPassword":"Forgot Password ?",
      "forgotPasswordWithoutMark":"Forgot Password",
      "forgotPasswordPhase":"Enter your Email and instructions will be sent to you!",
      "sendRequestLink":"Send Request Link",
      "rememberThat":"Quick Actions",
      "home":"Home",
      "settings":"Settings",
      "calendar":"Calendar",
      "type":"Type",
      "availableTime":"Available Time",
      "notification":"Notification",
      "uploadPhoto":"Upload Photo",
      "takeNewPhoto":"Take a new photo",
      "profilePhoto":"Profile Photo",
      "addNewClaim":"Add New Claim",
      "selectBuilding":"Select Building",
      "selectUnit":"Select Unit",
      "selectClaimCategory":"Select Claim Category",
      "selectClaimSubCategory":"Select Claim Sub Category",
      "selectClaimType":"Select Claim Type",
      "selectAvailableTime":"Select Available Time",
      "uploadAnyFiles":"Upload Any Files",
      "confirm":"Confirm",
      "yourBuilding":"Your Building",
      "yourUnit":"Your Unit",
      "confirmationAndSave ":"Confirmation & Save ",
      "claimCode":"claim Code",
      "back":"Back",
      "startDate":"Start Date",
      "endDate":"End Date",
      "new":"New",
      "complete":"Completed",
      "assigned":"Assigned",
      "closed":"Closed",
      "started":"Started",
      "cancelled":"Cancelled",
      "low":"Low",
      "high":"High",
      "normal":"Normal",
      "urgent":"Urgent",
      "medium":"Medium",
      "allFiles":"All Files",
      "createdBy":"Created By",
      "phoneNumber":"Phone Number",
      "submitAsClosed":"Submit As Closed",
      "start":"Start Work",
      "end":"End Work",
      "submitAsStarted":"Submit As Started",
      "submitAsCompleted":"Submit As Completed",
      'tenantSignature':"Tenant Signature",
      "showResult":"Show Results",
      "somethingWentWrong":"Something Went Wrong",
      "sessionExpired": "Your session has expired",
      "pleaseTryAgain":"Please Try Again",
      "reloadScreen":"Reload Screen",
      "typeYourReplyHere":"Type Your Reply Here",
      "drawTenantSignature":"Draw Tenant Signature",
      "signatureSavedTo":"Signature Saved To ",
      "downloadSignature":"Signature",
      "errorSavingSignatureToGallery":"Error saving signature to Gallery",
      "SignaturePadStateIsNull":"Signature pad state is empty",
      "SignatureSavedToGallery":"Signature saved to Gallery",
      "anyTime":"Any Time",
      "noResult":"No Result",
      "refresh":"Refresh",
      "pleaseChooseAvailableTimeFirst":"Please choose available time first",
      "pleaseSelectBuildingFirst":"Please select building first",
      "pleaseSelectUnitFirst":"Please select unit first",
      "pleaseSelectCategoryFirst":"Please select category first",
      "pleaseSelectSubCategoryFirst":"Please select sub category first",
      "pleaseSelectClaimTypeFirst":"Please select claim type first",
      "pleaseChooseAvailableDateFirst":"Please choose available date first",
      "newClaimSuccessMessage":"Thank you for submitting your request.one of our customer services representatives will contact you shortly,",
      "backToHome":"Back To Home",
      "pleaseAddDescriptionFirst":"Please add description First",
      "youDontHavePermission":"You don't have permission to access this page. ",
      "accessDenied":"Access Denied",
      "submitAsNew":"Submit As New",
      "submitAsAssigned":"Submit As Assigned",
      "submitAsCancelled":"Submit As Cancelled",
      "acceptByMe":"Accept By Me",
      "changePriority":"Change Priority",
      "completeButton":"Complete",
      "selectTechnician":"Select Technician",
      "typeYourComplaintsHere":"Type your complaints here",
      "pleaseChooseTechnician":"please choose a technician",
      "pleaseChooseStartDate":"please choose start date",
      "pleaseChooseEndDate":"please choose end date",
      "startDateMustBeBeforeEndDate":"start date must be before end date",
      "pleaseChooseThePriority":"please choose the priority",
      "pleaseWriteYourOldPassword":"please write your old password",
      "pleaseWriteYourPassword":"please write your password",
      "pleaseWriteYourConfirmPassword":"please write your confirm password",
      "pleaseMakeSurePasswordAndConfirmPasswordAreTheSame":"please make sure password and confirm password are the same",
      "pleaseWriteYourName":"please write your name",
      "pleaseWriteYourPhone":"Please write your phone",
      "pleaseAddSubscriber":"Please add subscriber",
      "signerName":"Signer Name",
      "clear":"Clear",
      "pleaseAddReplyFirst":"Please add reply first",
      "createdAt":"Created At",
      "claimDetails":"Claim Details",
      "emailSentSuccessfully":"Email sent successfully",
      "resetPassword":"Reset Password",
      "pleaseEnterYourEmail":"Please enter your email",
      "notAssigned":"Not Assigned",
      "startOn":"Start on",
      "endOn":"End on",
      "duration":"Duration",
      "ok":"OK",
      "endWork":"End Work",
      "startWork":"Start Work",
      "newClaimDialogCreatedSuccessfully":"Created Successfully",
      "newClaimDialogClaim":"Claim",
      "attendanceType":"Attendance Type",
      "checkIn":"Check-In",
      "dateTime":"Date/Time",
      "remarks":"Remarks",
      "addAttendance":"Add Attendance",
      "checkOut":"Check-Out",
      "typeYourRemarksHere":"Type your remarks here",
      "myAttendance":"My Attendance",
      "search":"Search",
      "in":"IN",
      "out":"Out",
      "pleaseEnableLocationFirst":"Please enable location first",
      "pleaseAddRemarksFirst":"Please add remarks first",
      "actions":"Actions",
      "all":"All",
      "swipeRight":"Swipe Right To Check-in",
      "swipeLeft":"Swipe Left To Check-out",
      "startAClaim":"Start A Claim",
      "startYourClaim":"Start Your Claim",
      "from":"From",
      "beFalconSolutions":"Be Falcon Solutions",
      "claim":"Claim",
      "history" : "History",
      "staff" : "Staff",
      "workingHours" : "Working Hours",
      "timeline" : "Timeline",
      "unit" : "Unit",
      "January": "January",
      "February": "February",
      "March": "March",
      "April": "April",
      "May": "May",
      "June": "June",
      "July": "July",
      "August": "August",
      "September": "September",
      "October": "October",
      "November": "November",
      "December": "December",
    },
  };
}