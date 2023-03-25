import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_animation/controller/home_controller.dart';
import 'package:tesla_car_animation/widgets/door_lock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),

                      // Door Locks
                      Positioned(
                        right: constraints.maxWidth * 0.05,
                        child: DoorLock(
                          press: _controller.toggleRightDoorLock,
                          isLocked: _controller.isRightDoorLocked,
                        ),
                      ),

                      Positioned(
                        left: constraints.maxWidth * 0.05,
                        child: DoorLock(
                          press: _controller.toggleLeftDoorLock,
                          isLocked: _controller.isLeftDoorLocked,
                        ),
                      ),

                      Positioned(
                        top: constraints.maxHeight * 0.14,
                        child: DoorLock(
                          press: _controller.toggleBonnetDoorLock,
                          isLocked: _controller.isBonnetDoorLocked,
                        ),
                      ),

                      Positioned(
                        bottom: constraints.maxHeight * 0.18,
                        child: DoorLock(
                          press: _controller.toggleTrunkDoorLock,
                          isLocked: _controller.isTrunkDoorLocked,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });
  }
}
