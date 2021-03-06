import 'package:fitween1/presenter/page/my/setting.dart';
import 'package:fitween1/view/page/my/edit_height/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 신장 수정 페이지
class EditHeightPage extends StatelessWidget {
  const EditHeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const EditHeightAppBar(),
          body: Center(
            child: Column(
              children: const [
                HeightTextField(),
              ],
            ),
          ),
        );
      }
    );
  }
}
