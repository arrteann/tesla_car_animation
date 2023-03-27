import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_animation/constant.dart';
import 'package:tesla_car_animation/controller/home_controller.dart';
import 'package:tesla_car_animation/widgets/app_bottom_navigation.dart';
import 'package:tesla_car_animation/widgets/battery_status.dart';
import 'package:tesla_car_animation/widgets/door_lock.dart';
import 'package:tesla_car_animation/widgets/temp_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late AnimationController _tempAnimationController;
  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationTempGlow;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _batteryAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0, 0.5),
    );

    _batteryStatusAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );

    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );

    _animationTempGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: AppBottomNavigation(
            onTap: (index) {
              if (index == 1) {
                _batteryAnimationController.forward();
              } else if (_controller.selectedTab == 1 && index != 1) {
                _batteryAnimationController.reverse(from: 0.7);
              }

              if (index == 2) {
                _tempAnimationController.forward();
              } else if (_controller.selectedTab == 2 && index != 2) {
                _tempAnimationController.reverse(from: 0.4);
              }

              _controller.changeTab(index);
            },
            selectedTab: _controller.selectedTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                    AnimatedPositioned(
                      left:
                          (constraints.maxWidth / 2) * _animationCarShift.value,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      duration: defaultDuration,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),
                    ),

                    // Door Locks
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedTab == 0
                          ? constraints.maxWidth * 0.05
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedTab == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.toggleRightDoorLock,
                          isLocked: _controller.isRightDoorLocked,
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedTab == 0
                          ? constraints.maxWidth * 0.05
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedTab == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.toggleLeftDoorLock,
                          isLocked: _controller.isLeftDoorLocked,
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedTab == 0
                          ? constraints.maxHeight * 0.14
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedTab == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.toggleBonnetDoorLock,
                          isLocked: _controller.isBonnetDoorLocked,
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      bottom: _controller.selectedTab == 0
                          ? constraints.maxHeight * 0.18
                          : constraints.maxHeight / 2,
                      duration: defaultDuration,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedTab == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.toggleTrunkDoorLock,
                          isLocked: _controller.isTrunkDoorLocked,
                        ),
                      ),
                    ),

                    // Battery
                    Opacity(
                      opacity: _batteryAnimation.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constraints.maxWidth * 0.45,
                      ),
                    ),

                    Visibility(
                      visible: _controller.selectedTab == 1,
                      child: Positioned(
                        top: 50 * (1 - _batteryStatusAnimation.value),
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Opacity(
                          opacity: _batteryStatusAnimation.value,
                          child: BatteryStatus(constraints: constraints),
                        ),
                      ),
                    ),

                    // Temp
                    Positioned(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(
                          controller: _controller,
                        ),
                      ),
                    ),

                    Positioned(
                      right: -180 * (1 - _animationTempGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                "assets/images/Cool_glow_2.png",
                                key: UniqueKey(),
                                width: 200,
                              )
                            : Image.asset(
                                "assets/images/Hot_glow_4.png",
                                key: UniqueKey(),
                                width: 200,
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
