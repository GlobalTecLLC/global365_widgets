import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/my_profile_controller.dart';
import 'package:global365_widgets/src/authentication/my_profile/profile_screen_widget_details.dart';
import 'package:global365_widgets/src/authentication/my_profile/profile_screen_widget_edit.dart';

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({super.key});

  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  MyProfileController myProfileController = (Get.isRegistered<MyProfileController>()) ? Get.find<MyProfileController>() : Get.put(MyProfileController());
  @override
  initState() {
    super.initState();
    myProfileController.isEditProfile.value = false;
    myProfileController.functionToClearProfileData();
    myProfileController.getProfileData();
    // myProfileController.isEditProfile.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), topRight: Radius.circular(6)),
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFC3D2D7)),
          right: BorderSide(width: 1, color: Color(0xFFC3D2D7)),
          bottom: BorderSide(color: Color(0xFFC3D2D7)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GTextHeading4('Account Profile'),
          const GSizeH(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Expanded(flex: 5, child: myProfileController.isEditProfile.isTrue ? ProfileScreenWidgetEdit() : ProfileScreenWidgetDetails())),
              const Expanded(flex: 5, child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
