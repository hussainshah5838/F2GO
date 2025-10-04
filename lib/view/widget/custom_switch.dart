import 'package:f2g/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_styling.dart';
import '../../controller/switch_controller.dart';

class CustomSwitch extends StatelessWidget {
  final CustomSwitchController controller = Get.put(CustomSwitchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.toggle,
        child: Container(
          height: h(context, 24),
          width: w(context, 42),
          padding: all(context, 1.55),
          decoration: BoxDecoration(
            color:
                controller.isOn.value ? ktoggleColor : const Color(0xffE0E0E0),
            borderRadius: BorderRadius.circular(h(context, 12.39)),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                margin: only(context, left: 8),
                width: w(context, 1.2),
                height: h(context, 7.74),
                color: kWhiteColor,
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment:
                    controller.isOn.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Container(
                  height: h(context, 20),
                  width: h(context, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
