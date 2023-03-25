import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_animation/constant.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    super.key,
    required this.press,
    required this.isLocked,
  });

  final VoidCallback press;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLocked
            ? SvgPicture.asset(
                "assets/icons/door_lock.svg",
                key: const ValueKey("door_lock"),
              )
            : SvgPicture.asset(
                "assets/icons/door_unlock.svg",
                key: const ValueKey("door_unlock"),
              ),
      ),
    );
  }
}
