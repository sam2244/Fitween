import 'dart:math' as math;
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/page/main/trainee.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//트레이니 페이지의 위젯 모음

//트레이니 메인 페이지 Body CarouselSlider Widget
class TraineeCarousel extends StatelessWidget {
  const TraineeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> carouselWidgets = [
      const TraineeAddPlanButton(),
      const TraineeCard(),
    ];

    final double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: carouselWidgets.length > 1,
        height: height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: carouselWidgets
          .map((widget) => Container(
                padding: EdgeInsets.zero,
                child: widget,
              ))
          .toList(),
    );
  }
}

//트레이니 플랜 추가 버튼
class TraineeAddPlanButton extends StatelessWidget {
  const TraineeAddPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/img/add_plan.svg',
            height: 300.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FWText(
              "현재 진행중인 플랜이 없습니다.",
              style: Theme.of(context).textTheme.bodyMedium,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          FWButton(
            width: 193.0,
            height: 52.0,
            onPressed: TraineePresenter.addPlanButtonPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.add),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: FWText(
                          '새 플랜 추가',
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//트레이니 메인 페이지 View
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TraineeWelcomeMessage(),
          TraineeToDoCard(),
          TraineeDietCardView(),
        ],
      ),
    );
  }
}

class TraineeWelcomeMessage extends StatelessWidget {
  const TraineeWelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Text.rich(
        style: Theme.of(context).textTheme.headlineMedium,
        TextSpan(
          text: "안녕하세요,",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          children: <TextSpan>[
            TextSpan(
              text: TraineePresenter.userPresenter.user.nickname!,
              style: TextStyle(
                color: FWTheme.primary[60],
              ),
            ),
            TextSpan(
                text: '님!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
            )
          ]

        )


      ),
    );
  }
}


//트레이니 ToDo 카드
class TraineeToDoCard extends StatelessWidget {
  const TraineeToDoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TraineeProfileButton(),
                      ToDoCardTitle(
                        title: '바프 가보자고',
                      ),
                      ToDoCardSubTitle(
                        subtitle: '운동',
                      ),
                    ],
                  ),
                  const TraineePercentGraphView(),
                ],
              ),
              const Divider(
                color: Colors.black,
                indent: 15.0,
                endIndent: 12.0,
              ),
              const TraineeCheckBoxList(),
            ],
          ),
        ),
      ),
    );
  }
}

//트레이니 퍼센테지 그래프
class TraineePercentGraphView extends StatelessWidget {
  const TraineePercentGraphView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 10.0, top: 15.0),
      child: TraineePercentGraph(),
    );
  }
}

//트레이니 메인 페이지 트레이니 Inner Text 위젯
class TraineePercentGraph extends StatelessWidget {
  const TraineePercentGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animation: true,
      radius: 40.0,
      lineWidth: 12.0,
      percent: 0.75,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(50),
          child: Center(
            child: FWText(
                '75%',
            ),
          ),// Image radius
        ),
      ),
      reverse: false,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xff01B5FF), Color(0xff0291FF)],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

/*
// 트레이니 메인 페이지 Trainee Information
class TraineeInfo extends StatelessWidget {
  const TraineeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TraineeName(name: '최복원'),
        TraineeMainPageDDay(dDay: 'D-Day'),
        TraineeMainPageGraph(total: 5, completed: 4),
      ],
    );
  }
}

//트레이니 이름 텍스트 스타일
class TraineeName extends StatelessWidget {


  const TraineeName({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: FWText(
        name,
        color: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

 */



//트레이니 페이지 트레이너 프로필 버튼
class TraineeProfileButton extends StatelessWidget {
  const TraineeProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
      child: FWButton(
        width: 98.0,
        height: 24.0,
        fontSize: 13.0,
        onPressed: () {
          //Get.toNamed('/main/trainer');
        },
        text: "트레이너 프로필",
        fill: false,
      ),
    );
  }
}

//트레이니 식단 카드 뷰
class TraineeDietCardView extends StatelessWidget {
  const TraineeDietCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            DietCardViewTitle(
              title: '식단',
            ),
              TraineeDietCardCarousel(),
          ],
      ),
        ),
    );
  }
}

//트레이니 식단 카드

class TraineeDietCard extends StatelessWidget {
  const TraineeDietCard(this.meal, {
    Key? key,
    this.menu,
  }
) : super(key: key);

  final String meal;
  final String? menu;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          width: 100.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xff01B5FF), Color(0xff0291FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText(
                  meal,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                FWText(
                  '$menu',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: 40.0,
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                        onPressed: () => GlobalPresenter.imageUpload(context,Theme.of(context)),
                      icon: const Icon(
                        Icons.add,
                      ),
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                )
            ],
        ),
          ),
      ),
    );
  }
}



//트레이니 식단 카라호셀
class TraineeDietCardCarousel extends StatelessWidget {
  const TraineeDietCardCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> carouselWidgets = [
      const TraineeDietCard('아침', menu: '식빵, 계란, 우유',),
      const TraineeDietCard('점심', menu: '닭가슴살 샐러드',),
      const TraineeDietCard('저녁', menu: '닭가슴살, 매실차',),
    ];

    return CarouselSlider(
      options: CarouselOptions(
        padEnds: false,
        height: 131.0,
        disableCenter: true,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        initialPage: 0,
        viewportFraction: 0.3,
        // autoPlay: false,
      ),
      items: carouselWidgets
          .map((widget) => Container(
        padding: EdgeInsets.zero,
        child: widget,
      ))
          .toList(),
    );
  }
}
/*
// 트레이니 메인 페이지 D-Day
class TraineeMainPageDDay extends StatelessWidget {
  final String dDay;

  const TraineeMainPageDDay({Key? key, required this.dDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: FWText(
        dDay,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

 */


// 트레이니 메인 페이지 -> ToDo 카드 위젯 title text
class ToDoCardTitle extends StatelessWidget {
  final String title;

  const ToDoCardTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
      ),
      child: FWText(
        title,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        style: Theme.of(context).textTheme.titleLarge,
        size: 24.0,
      ),
    );
  }
}

// 트레이니 메인 페이지 -> ToDo 카드 위젯 subtitle text
class ToDoCardSubTitle extends StatelessWidget {
  final String subtitle;

  const ToDoCardSubTitle({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
      ),
      child: FWText(
        subtitle,
        color: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.titleMedium,
        size: 18.0,
      ),
    );
  }
}

// 트레이니 메인 페이지 -> 식단 뷰 title
class DietCardViewTitle extends StatelessWidget {
  final String title;

  const DietCardViewTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
      ),
      child: FWText(
        title,
        color: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.titleMedium,
        size: 18.0,
      ),
    );
  }
}
//트레이니 FAB
/*class ExpandableTraineeFAB extends StatelessWidget {
  const ExpandableTraineeFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: () {
        print("Not ready yet!");
      },
      backgroundColor: FWTheme.darkScheme.onPrimary,
      child: const Icon(
        Icons.camera_enhance_rounded,
        color: FWTheme.light,
      ),
    );
  }
}

 */

//트레이니 Expanding FAB Structure
@override
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

//트레이니 Expanding FAB State

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override //initState
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  //닫기 버튼
  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 33.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: FWTheme.primary[40],
            onPressed: _toggle,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 280.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 1,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: FWTheme.primary[50],
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

//트레이니 체크박스
class TraineeCheckBoxList extends StatefulWidget {
  const TraineeCheckBoxList({Key? key}) : super(key: key);

  @override
  State<TraineeCheckBoxList> createState() => _TraineeCheckBoxListState();
}

//트레이니 체크박스 위젯
class _TraineeCheckBoxListState extends State<TraineeCheckBoxList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text(
        '조깅 3km',
      ),
      activeColor: FWTheme.primary[30],
      value: timeDilation != 1.0,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          timeDilation = value! ? 2.0 : 1.0;
        });
      },
    );
  }
}

//트레이니 페이지 식단 Photo Widget
class TraineePagePhotoWidget extends StatelessWidget {
  const TraineePagePhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(
          left: 15.0,
        ),
        color: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: FWTheme.grey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(28.5),
          child: Icon(
            Icons.camera_alt_outlined,
            color: FWTheme.grey,
          ),
        ));
  }
}
