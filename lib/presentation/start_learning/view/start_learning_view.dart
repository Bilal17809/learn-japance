import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/constants/constants.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/theme/theme.dart';
import '/presentation/Translator/screen/translator.dart';

class StartLearningView extends StatelessWidget {
  const StartLearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Header row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Japanese",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.settings,
                      size: 30,
                      color: AppColors.primary(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: context.screenWidth * 0.85,
                  child: HorizontalProgress(currentStep: 34),
                ),
              ),

              const SizedBox(height: 2),

              // Goal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text("Today's goal:"),
                    const SizedBox(width: 6),
                    Text(
                      "10 XP",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Start learning",
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Hiragana card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  child: Container(
                    width: context.screenWidth * 0.9,
                    height: context.screenHeight * 0.37,
                    color: AppColors.secondary(context),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Image.asset(
                                "images/correct.png",
                                width: context.screenWidth * 0.035,
                              ),
                              const SizedBox(width: 13),
                              Text(
                                "Hiragana",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            "あ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 100,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.to(() => Translator()),
                          child: Container(
                            width: context.screenWidth * 0.6,
                            height: context.screenHeight * 0.075,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primary(context),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "CONTINUE",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Menu items
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildMenuItem("images/menu.png", "Lesson"),
                    buildMenuItem("images/mic.png", "Practice"),
                    buildMenuItem("images/pencil.png", "Speaking"),
                    buildMenuItem("images/question.png", "Quizzes"),
                  ],
                ),
              ),

              // Today progress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today Progress",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: context.screenWidth * 0.85,
                  child: HorizontalProgress(currentStep: 57),
                ),
              ),

              const SizedBox(height: 5),

              // Lessons, Words, Sentences
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  lossonwordSentenco(10, "Lessons"),
                  lossonwordSentenco(30, "Words"),
                  lossonwordSentenco(5, "Sentences"),
                ],
              ),

              const SizedBox(height: 5),

              // Streak
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Streak",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      "images/star.png",
                      width: context.screenWidth * 0.025,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "5 achievements",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/*
 widget???
*/
Widget buildMenuItem(String imagePath, String label) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(imagePath, width: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // semiBold
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Widget lossonwordSentenco(int num, String label) {
  return GestureDetector(
    onTap: () {
      // Handle tap action
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            num.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600, // semiBold
              fontSize: 25,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // semiBold
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
