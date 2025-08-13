import 'package:flutter/material.dart';
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

import '../../../core/theme/app_colors.dart';

class LearnJapanse extends StatelessWidget {
  const LearnJapanse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading:  Image.asset("images/2x/four-circle.png",),
        title: "LEARN JAPANESE".text.size(18).semiBold.make(),

      ),
      body:SafeArea(
          child: Column(
            children: [
              Image.asset(
                "images/3x/Group 1.png",


              ),
              20.heightBox,
            ],
          )) ,
    );
  }
}
