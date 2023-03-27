import 'package:flutter/material.dart';
import 'package:tesla_car_animation/constant.dart';
import 'package:tesla_car_animation/widgets/temp_btn.dart';

import '../controller/home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);
  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  svgSrc: "assets/icons/coolShape.svg",
                  title: "Cool",
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(width: defaultPadding),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: "assets/icons/heatShape.svg",
                  title: "Heat",
                  activeColor: redColor,
                  press: _controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_up, size: 48),
              ),
              const Text(
                "29" "\u2103",
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),
          const Spacer(),
          const Text("CURRENT TEMPERATURE"),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                  ),
                  Text(
                    "20" "\u2103",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "35" "\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white54),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
