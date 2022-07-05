import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/page/main/trainee.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../widget/container.dart';
import '../../../widget/text.dart';
import 'dart:math' as math;

import '../../add_plan/add_plan.dart';

//트레이니 페이지의 위젯 모음

//트레이니 페이지 Body CarouselSlider Widget
class TraineeCarousel extends StatelessWidget {
  const TraineeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardList = [const TraineeAddPlanButton()];

    final double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: cardList.length > 1,
        height: height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: cardList
          .map((item) => const Center(child: TraineeAddPlanButton()))
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FWText("현재 진행중인 플랜이 없습니다.",
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

//트레이니 카드
class TraineeCard extends StatelessWidget {
  const TraineeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
          child: FWCard(
              height: 600.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      TraineeProfile(),
                    ],
                  ),
                  const TraineeToDo(),
                ],
              )),
        ),
      ],
    );
  }
}

//트레이니 프로필
class TraineeProfile extends StatelessWidget {
  const TraineeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 120.0,
            width: 300.0,
            child: Row(
              children: const [
                TraineeProfileImage(),
                TraineeInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//트레이니 메인 페이지 트레이니 Image 위젯
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(50), // Image radius
          child: Image.network(
              'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
              fit: BoxFit.cover),
        ),
      ),
      reverse: true,
      backgroundColor: Colors.transparent,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

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
  final String name;

  const TraineeName({Key? key, required this.name}) : super(key: key);

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

//트레이니 ToDo 위젯
class TraineeToDo extends StatelessWidget {
  const TraineeToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430.0,
      child: Card(
        color: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1.0,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ToDoCardTitle(
                  title: '운동',
                ),
                const Divider(
                  color: Colors.black,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                const TraineeCheckBoxList(),
                const TraineeCheckBoxList(),
                const TraineeCheckBoxList(),
                const ToDoCardTitle(
                  title: '식단',
                ),
                const Divider(
                  color: Colors.black,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                Row(
                  children: const [
                    TraineePagePhotoWidget(),
                    TraineePagePhotoWidget(),
                    TraineePagePhotoWidget(),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

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

// 트레이니 메인 페이지 Graph
class TraineeMainPageGraph extends StatelessWidget {
  final int total;
  final int completed;

  const TraineeMainPageGraph(
      {Key? key, required this.completed, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 180.0,
      lineHeight: 15,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      barRadius: const Radius.circular(10.0),
      percent: completed / total,
    );
  }
}

// 트레이니 메인 페이지 -> ToDo 카드 위젯 title
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
        color: Theme.of(context).colorScheme.onSurface,
        style: Theme.of(context).textTheme.labelLarge,
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

//트레이니 체크박스 뷰
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
        'Running',
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
