import 'package:flutter/material.dart';
import '/core/theme/theme.dart';

class Translator extends StatelessWidget {
  const Translator({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary(context),
        leading: Image.asset("images/2x/four-circle.png"),
        title: Text(
          "Translator",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Language selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screenw * 0.30,
                  height: screenh * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.primary(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "English",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: screenw * 0.30,
                  height: screenh * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.primary(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Japanese",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textBlackColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Translator cards
            TranslatorCard(
              mainText: "English",
              leftIcon: Icons.volume_up,
              centerIcon: Icons.mic,
              rightIcon: Icons.camera_alt_outlined,
              onLeftPressed: () {},
              onCenterPressed: () {},
              onRightPressed: () {},
            ),

            const SizedBox(height: 30),

            TranslatorCard(
              mainText: "Japanese",
              leftIcon: Icons.volume_up,
              centerIcon: Icons.copy,
              rightIcon: Icons.history,
              onLeftPressed: () {},
              onCenterPressed: () {},
              onRightPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TranslatorCard extends StatelessWidget {
  final String mainText; // For the title
  final IconData leftIcon; // First icon in the bottom row
  final IconData centerIcon; // Second icon
  final IconData rightIcon; // Third icon
  final VoidCallback? onLeftPressed;
  final VoidCallback? onCenterPressed;
  final VoidCallback? onRightPressed;

  const TranslatorCard({
    super.key,
    required this.mainText,
    required this.leftIcon,
    required this.centerIcon,
    required this.rightIcon,
    this.onLeftPressed,
    this.onCenterPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;

    return Center(
      child: Card(
        child: Container(
          width: screenw * 0.8,
          height: screenh * 0.25,
          color: AppColors.secondary(context),
          child: Column(
            children: [
              // Top row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mainText, style: const TextStyle(fontSize: 15)),
                    IconButton(
                      onPressed: () {}, // Remove button
                      icon: const Icon(Icons.highlight_remove),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Bottom icons row
              Container(
                width:
                    screenw *
                    1, // This will take full width of its parent (Column)
                // which is screenw * 0.8 due to the parent Container.
                // If you want it to be full screen width, this setup needs rethinking.
                height: screenh * 0.06,
                color: AppColors.primary(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onLeftPressed,
                      icon: Icon(
                        leftIcon,
                        color: AppColors.textBlackColor,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: onCenterPressed,
                      icon: Icon(
                        centerIcon,
                        color: AppColors.textBlackColor,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: onRightPressed,
                      icon: Icon(
                        rightIcon,
                        color: AppColors.textBlackColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
