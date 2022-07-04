import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_info.dart';
import 'package:fitween1/presenter/page/add_plan.dart';
import 'package:fitween1/presenter/page/chat.dart';
import 'package:fitween1/presenter/page/chatroom.dart';
import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/presenter/page/register.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalPresenter extends GetxController {
  int navIndex = 0;

  static final userPresenter = Get.find<UserPresenter>();

  void navigate(int index) {
    navIndex = index;
    Get.offAllNamed(
      ['/main/${userPresenter.user.role.name}', '/chat', '/my',][navIndex],
    );
    update();
  }

  static void profilePressed(FWUser user) {
    Get.dialog(
      AlertDialog(
        title: Container(
          child: ProfileImageCircle(user: user),
        ),
      ),
    );
  }

  static void initControllers() {
    Get.put(GlobalPresenter());
    Get.put(FWTheme());
    Get.put(UserPresenter());
    Get.put(PlanPresenter());
    Get.put(RegisterPresenter());
    Get.put(ChatPresenter());
    Get.put(ChatroomPresenter());
    Get.put(AddInfoPresenter());
    Get.put(AddPlanPresenter());
    Get.put(MyPresenter());
  }
}