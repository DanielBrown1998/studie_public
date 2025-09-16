import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lotties/loading.json",
            width: Get.width * .55,
            height: Get.width * .55,
            filterQuality: FilterQuality.medium,
          ),
        ],
      ),
    );
  }
}
