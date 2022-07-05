import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FWDialog extends StatelessWidget {
  FWDialog({
    Key? key,
    required this.child,
    this.leftLabel = '취소',
    this.rightLabel = '확인',
    this.leftPressed,
    required this.rightPressed,
    this.fixWidth = 300.0,
    this.fixHeight = 100.0,
  }) : super(key: key);

  final Widget child;
  final String leftLabel;
  final String rightLabel;
  VoidCallback? leftPressed;
  final VoidCallback rightPressed;
  final double fixWidth;
  final double fixHeight;

  @override
  Widget build(BuildContext context) {
    leftPressed ??= Get.back;

    BorderRadius bottomLeftRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(20.0),
    );
    BorderRadius bottomRightRadius = const BorderRadius.only(
      bottomRight: Radius.circular(20.0),
    );

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: fixWidth,
                maxHeight: fixHeight,
              ),
              child: child,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: FWTheme.surface[1],
                  borderRadius: bottomLeftRadius,
                  child: InkWell(
                    onTap: leftPressed,
                    borderRadius: bottomLeftRadius,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Center(
                        child: FWText(
                          leftLabel,
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: bottomRightRadius,
                  child: InkWell(
                    onTap: rightPressed,
                    borderRadius: bottomRightRadius,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Center(
                        child: FWText(
                          rightLabel,
                          style: Theme.of(context).textTheme.labelLarge,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}