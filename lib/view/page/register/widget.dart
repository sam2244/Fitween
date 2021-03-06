import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/before_main/register.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';

// 회원가입 페이지 위젯 모음

// 회원가입 페이지 AppBar
class RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GetBuilder<RegisterPresenter>(
        builder: (controller) => IconButton(
          icon: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: controller.backPressed,
        ),
      ),
      title: FWText('기본 정보',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      elevation: 0.0,
    );
  }
}

// Carousel 뷰 위젯
class CarouselView extends StatelessWidget {
  const CarouselView({Key? key}) : super(key: key);

  // 회원가입 페이지 carousel 리스트
  static List<Widget> carouselWidgets() => const [
    UserInfoView(),
    WeightHeightView(),
    RoleView(),
  ];
  static int widgetCount = carouselWidgets().length;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool keyboardDisabled =
        WidgetsBinding.instance.window.viewInsets.bottom < 100.0;

    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 50.0),
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(minWidth: screenSize.width),
              child: CarouselSlider(
                carouselController: RegisterPresenter.carouselCont,
                items: carouselWidgets().map((widget) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: widget,
                )).toList(),
                options: CarouselOptions(
                  height: double.infinity,
                  initialPage: 0,
                  reverse: false,
                  enableInfiniteScroll: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1.0,
                  // onPageChanged: controller.pageChanged,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: keyboardDisabled ? 200.0 : 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Carousel 인디케이터
              CarouselIndicator(count: widgetCount),
              // Carousel 다음 버튼
              const CarouselNextButton(),
            ],
          ),
        ),
      ],
    );
  }
}

// 닉네임 입력 뷰
class UserInfoView extends StatelessWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText('닉네임을 입력하세요.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.0),
                ShakeWidget(
                  autoPlay: controller.invalids[0],
                  shakeConstant: ShakeHorizontalConstant2(),
                  child: FWInputField(
                    controller: RegisterPresenter.nicknameCont,
                    onSubmitted: (_) => controller.nextPressed(),
                    hintText: '별명',
                    invalid: controller.invalids[0],
                  ),
                ),
                const SizedBox(height: 8.0),
                FWText('한글, 영문, 숫자만 입력해주세요.',
                  style: Theme.of(context).textTheme.bodySmall,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
            Divider(
              height: 40.0,
              thickness: 2.0,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText('생년월일을 입력하세요.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.0),
                ShakeWidget(
                  autoPlay: controller.invalids[1],
                  shakeConstant: ShakeHorizontalConstant2(),
                  child: FWInputField(
                    controller: RegisterPresenter.dateOfBirthCont,
                    hintText: 'YYMMDD',
                  ),
                ),
              ],
            ),
            Divider(
              height: 40.0,
              thickness: 2.0,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText('성별을 선택하세요.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.0),
                ShakeWidget(
                  autoPlay: controller.invalids[2],
                  shakeConstant: ShakeHorizontalConstant2(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SexSelectionButton(sex: Sex.male),
                      SexSelectionButton(sex: Sex.female),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// 성별 선택 버튼
class SexSelectionButton extends StatelessWidget {
  const SexSelectionButton({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  @override
  Widget build(BuildContext context) {
    final registerCont = Get.find<RegisterPresenter>();

    const Map<Sex, String> texts = {
      Sex.male: '남자',
      Sex.female: '여자',
    };

    return GetBuilder<UserPresenter>(builder: (userCont) {
      return FWButton(
        text: texts[sex],
        width: 128.0,
        fill: sex == userCont.user.sex,
        onPressed: () => registerCont.sexSelected(sex),
      );
    });
  }
}

// 역할 선택 뷰
class RoleView extends StatelessWidget {
  const RoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserPresenter>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 100.0),
                  child: FWText('${controller.user.nickname}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              FWText(' 님은 무엇을 하고 싶으신가요?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const RoleSelectionButton(role: Role.trainer),
          const SizedBox(height: 15.0),
          const RoleSelectionButton(role: Role.trainee),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            child: FWText('TIP: 역할은 언제든지 바꿀 수 있어요!',
              color: Theme.of(context).colorScheme.outline,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// 역할 선택 버튼
class RoleSelectionButton extends StatelessWidget {
  const RoleSelectionButton({
    Key? key,
    required this.role,
  }) : super(key: key);

  final Role role;

  @override
  Widget build(BuildContext context) {
    final registerCont = Get.find<RegisterPresenter>();

    const Map<Role, String> texts = {
      Role.trainer: '트레이너로 참여하기',
      Role.trainee: '피트위너로 도전하기'
    };

    return GetBuilder<UserPresenter>(builder: (userCont) {
      return FWButton(
        text: texts[role],
        width: double.infinity,
        fill: role == userCont.user.role,
        onPressed: () => registerCont.roleSelected(role),
      );
    });
  }
}

// 체중 신장 선택 뷰
class WeightHeightView extends StatelessWidget {
  const WeightHeightView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> contents = {
      '체중': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<RegisterPresenter>(
            builder: (controller) {
              return FWNumberPicker(
                itemCount: 5,
                onChanged: (value) => controller.weightChanged(value * .1),
                value: RegisterPresenter.userPresenter.currentWeight,
                minValue: FWUser.weightRange.start,
                maxValue: FWUser.weightRange.end,
                step: .1,
              );
            },
          ),
          FWText(
            'kg',
            style: Theme.of(context).textTheme.labelLarge,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      '신장': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<RegisterPresenter>(
            builder: (controller) {
              return FWNumberPicker(
                itemCount: 5,
                onChanged: (value) => controller.heightChanged(value * .1),
                value: RegisterPresenter.userPresenter.user.height,
                minValue: FWUser.heightRange.start,
                maxValue: FWUser.heightRange.end,
                step: .1,
              );
            },
          ),
          FWText(
            'cm',
            style: Theme.of(context).textTheme.labelLarge,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    };

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contents.length,
      itemBuilder: (context, index) => FWCard(
        title: contents.keys.toList()[index],
        child: contents[contents.keys.toList()[index]]!,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
    );
  }
}

// Carousel 인디케이터 위젯
class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        return SizedBox(
          height: 100.0,
          child: DotsIndicator(
            dotsCount: count,
            position: controller.pageIndex.toDouble(),
            decorator: DotsDecorator(
              color: Theme.of(context).colorScheme.primaryContainer,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}

// Carousel 다음 버튼
class CarouselNextButton extends StatelessWidget {
  const CarouselNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPresenter>(
      builder: (controller) {
        bool lastPage = controller.pageIndex == CarouselView.widgetCount - 1;

        return FWButton(
          onPressed: () {
            controller.nextPressed();
            FocusScope.of(context).unfocus();
          },
          width: 120.0,
          height: 45.0,
          text: lastPage ? '완료' : '다음',
        );
      }
    );
  }
}
