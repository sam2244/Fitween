import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FWNumberPicker extends StatelessWidget {
  const FWNumberPicker({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.value,
    this.axis = Axis.vertical,
    this.itemCount = 5,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.step = 1.0,
    this.decimalPlace = 1,
    this.itemWidth = 50.0,
    this.itemHeight = 20.0,
  }) : super(key: key);

  final Axis axis;
  final int itemCount;
  final String label;
  final Function(int) onChanged;
  final double value;
  final double minValue;
  final double maxValue;
  final double step;
  final int decimalPlace;
  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    const double fadeHeight = 80.0;

    return Stack(
      children: [
        Row(
          children: [
            NumberPicker(
              axis: axis,
              itemCount: itemCount,
              haptics: true,
              onChanged: onChanged,
              value: value ~/ step,
              minValue: minValue ~/ step,
              maxValue: maxValue ~/ step,
              step: 1,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              textMapper: (value) => (int.parse(value) * step)
                  .toStringAsFixed(decimalPlace),
              textStyle: Theme.of(context).textTheme.labelLarge,
              selectedTextStyle: Theme.of(context).textTheme.labelLarge?.merge(
                const TextStyle(color: FWTheme.primary, fontWeight: FontWeight.w700),
              ),
            ),
            FWText(label, color: Theme.of(context).primaryColor),
          ],
        ),
        Positioned.fill(
          top: 0.0,
          bottom: fadeHeight,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: fadeHeight,
          bottom: 0.0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.surface.withOpacity(0),
                    Theme.of(context).colorScheme.surface,
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
}


class FWCard extends StatelessWidget {
  const FWCard({
    Key? key,
    this.title,
    required this.child,
    this.height = 115.0,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
              FWText(
                title!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}