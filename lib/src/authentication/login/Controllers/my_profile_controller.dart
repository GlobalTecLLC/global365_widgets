import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/src/dropdown.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/progressDialog.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyProfileController extends GetxController {
  static MyProfileController get to => Get.find();
  RxBool isEditProfile = false.obs;
  // String profileIMagePath = "";
  TextEditingController tecFirstNameController = TextEditingController();
  TextEditingController tecMiddleNameController = TextEditingController();
  TextEditingController tecLastNameController = TextEditingController();
  TextEditingController tecEmail1Controller = TextEditingController();
  TextEditingController tecEmail2Controller = TextEditingController();
  TextEditingController tecJobTitleController = TextEditingController();
  TextEditingController tecPhoneNoController = TextEditingController();
  String partyIdForGender = "0";
  DropdownEditingController<dynamic> dropdownForGender = DropdownEditingController();
  // DropdownEditingController<dynamic> dropdownForCountry = DropdownEditingController();
  DropdownEditingController<dynamic> dropdownForTimezone = DropdownEditingController();

  // date for birthday
  DateTime selectedDateToForBirthday = DateTime.now();
  TextEditingController tecdateToControllerforBirthday = TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );
  DateTime selectedDateFromforBirthday = DateTime.now();

  TextEditingController tecDateFromControllerBirthday = TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );

  // date for aniversary
  DateTime selectedDateToForAniversary = DateTime.now();
  TextEditingController tecdateToControllerforAniversary = TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );
  DateTime selectedDateFromforAniversary = DateTime.now();

  TextEditingController tecDateFromControllerAniversary = TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );

  // for country/region dropdown
  String partyIdForCountryReigon = "0";
  DropdownEditingController<dynamic> countryRegionDropDown = DropdownEditingController();

  // for timezone dropdown
  String partyIdForTimeZone = "0";
  DropdownEditingController<dynamic> timezoneDropDown = DropdownEditingController();
  RxList emailList = [
    {"emailtextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false},
  ].obs;
  RxList phoneList = [
    {"phonetextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false},
  ].obs;
  // index of menu item
  RxInt activeMenuIndex = 0.obs;

  void functionToClearProfileData() {
    tecFirstNameController.text = '';
    tecMiddleNameController.clear();
    tecLastNameController.clear();
    tecEmail1Controller.clear();
    tecEmail2Controller.clear();
    tecJobTitleController.clear();
    tecPhoneNoController.clear();
    dropdownForGender.value = null;
    // dropdownForCountry.value = null;
    dropdownForTimezone.value = null;
    tecdateToControllerforBirthday.clear();
    tecDateFromControllerBirthday.clear();
    tecdateToControllerforAniversary.clear();
    tecDateFromControllerAniversary.clear();
    countryRegionDropDown.value = null;
    timezoneDropDown.value = null;
    profileImageOnProfilePage.value = "";
  }

  dynamic profileData = {};
  RxBool isProfileDataLoading = false.obs;
  getProfileData() async {
    isProfileDataLoading.value = true;
    //Get API
    ResponseModel response = await APIsCallGet.getData("Users/GetUserProfile?CompanyId=$companyId");
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.data);
      profileData = data["payload"];
      print("Profile Data: $profileData");
      // tecFirstNameController.text = profileData["firstName"];
      // tecMiddleNameController.text = profileData["middleName"];
      // tecLastNameController.text = profileData["lastName"];
      // tecEmail1Controller.text = profileData["email1"];
      // tecEmail2Controller.text = profileData["email2"];
      // tecJobTitleController.text = profileData["jobTitle"];
      // tecPhoneNoController.text = profileData["phoneNo"];
      // dropdownForGender.value = profile

      isProfileDataLoading.value = false;
    } else {
      isProfileDataLoading.value = false;
      GToast.error(response.data.toString(), Get.context!);
      gLogger("Error in getProfileData: ${response.data}");
    }
  }

  RxString selectedImagePath = ''.obs;
  int idOfuploadedImage = 0;
  List attachmentsList = [];
  List userRoleDropDownData = [];

  RxBool isUploadingImage = false.obs;
  void pickImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      uploadFile(result.files, context);
      // selectedImagePath.value = result.files.first.path!;
      // gLogger('Image selected: ${selectedImagePath.value}');
    } else {
      gLogger('No image selected');
    }
  }

  RxString profileImageOnProfilePage = "".obs;

  Future<void> uploadFile(List<dynamic> listOffilePathWithOutBase64, BuildContext context) async {
    print("Upload Function ${Uri.parse('${apiLink}UploadFile/UploadMultipleFiles_v1?CompanyId=$companyId')}");
    isUploadingImage.value = true;
    var headers = {'Authorization': '$tokenType $accessToken'};

    var request = http.MultipartRequest('POST', Uri.parse('${apiLink}UploadFile/UploadMultipleFiles_v1?CompanyId=$companyId'));

    if (kIsWeb) {
      for (int i = 0; i < listOffilePathWithOutBase64.length; i++) {
        PlatformFile file = listOffilePathWithOutBase64[i];
        request.files.add(http.MultipartFile.fromBytes('files', file.bytes!, filename: file.name));
      }
    } else {
      for (int i = 0; i < listOffilePathWithOutBase64.length; i++) {
        PlatformFile file = listOffilePathWithOutBase64[i];
        String name = file.name.toString();
        print("send request http");
        request.files.add(await http.MultipartFile.fromPath('files', file.path.toString()));
      }
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(await response.stream.bytesToString());
      print("jsonResponse $jsonResponse");
      List<dynamic> payloadData = jsonResponse['payload'];
      attachmentsList = payloadData;
      gLogger("Attachments list $attachmentsList");
      profileImageOnProfilePage.value = attachmentsList[0]['filePath'];
      idOfuploadedImage = attachmentsList[0]['uploadId'];
      gLogger("idOfuploadedImage $idOfuploadedImage");
      // setState(() {});
      isUploadingImage.value = false;

      // GToast.succss("Documents uploaded successfully", context); // Assuming GToast is a toast notification function
    } else {
      isUploadingImage.value = false;
      gLogger(response.reasonPhrase);
    }
  }

  RxBool isUpdatingDropdown = false.obs;
  updateProfileData(BuildContext context) async {
    List emailListforApi = [];
    for (int i = 0; i < emailList.length; i++) {
      if (emailList[i]["emailtextFieldController"].text.isEmpty) {
        continue;
      } else if (emailList[i]["emailtextFieldController"].text.isNotEmpty &&
          (isValidEmail(emailList[i]["emailtextFieldController"].text) == false)) {
        GToast.succss("Please Enter valid Email at ${i + 1} position", context);
        return;
      } else {
        emailListforApi.add(emailList[i]["emailtextFieldController"].text);
      }
    }

    List phoneListforApi = [];
    for (int i = 0; i < phoneList.length; i++) {
      if (phoneList[i]["phonetextFieldController"].text.isEmpty) {
        continue;
      } else if (phoneList[i]["phonetextFieldController"].text.isNotEmpty &&
          (isValidPhoneNumber(phoneList[i]["phonetextFieldController"].text) == false)) {
        GToast.error("Please Enter valid Phone No at ${i + 1} position", context);
        return;
      } else {
        phoneListforApi.add(phoneList[i]["phonetextFieldController"].text);
      }
    }

    dynamic data = {
      "firstName": tecFirstNameController.text.trim(),
      "fileId": idOfuploadedImage,
      "middleName": tecMiddleNameController.text.trim(),
      "lastName": tecLastNameController.text.trim(),
      "jobTitle": tecJobTitleController.text.trim(),
      "gender": dropdownForGender.value.toString() == "null" ? "" : dropdownForGender.value["name"],
      "birthday": formateDateToSendToApi(tecDateFromControllerBirthday.text.toString()),
      // "workAnniversary": formateDateToSendToApi(tecDateFromControllerAniversary.text.toString()),
      "workAnniversary": null,
      "countryId": countryRegionDropDown.value.toString() == "null" ? 0 : countryRegionDropDown.value["id"] ?? 0,
      "timeZoneId": dropdownForTimezone.value.toString() == "null" ? 0 : dropdownForTimezone.value["id"] ?? 0,
      "emails": emailListforApi,
      "phones": phoneListforApi,
    };
    gLogger("Data to send to api for updateProfileData $data");
    GProgressDialog(context).show();
    //  (S-3002)  UpdateUserProfile
    ResponseModel response = await APIsCallPut.updateRequestWithId("Users/UpdateUserProfile?CompanyId=$companyId", data);
    GProgressDialog(context).hide();
    gLogger("Response od update profile api  ${response.data}");
    gLogger(response.statusCode);
    if (response.statusCode == 200) {
      GToast.succss("Data Updated Successfully", context);
      profileImage.value = profileImageOnProfilePage.value;
      isEditProfile.value = false;
      getProfileData();
    } else {
      GToast.error(response.data.toString(), context);
    }
  }
}
