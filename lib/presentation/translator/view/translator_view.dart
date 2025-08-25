import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/models.dart';
import '/presentation/translator/controller/translator_controller.dart';
import '/core/common_widgets/common_widgets.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';

class TranslatorView extends StatelessWidget {
  const TranslatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();

    return Scaffold(
      appBar: TitleBar(title: 'Translator'),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const SizedBox(height: 30),

              // Language selection row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _LanguageDropdown(
                    selected: controller.sourceLanguage.value,
                    languages: controller.allLanguages,
                    onChanged: (lang) => controller.setSource(lang),
                  ),
                  _LanguageDropdown(
                    selected: controller.targetLanguage.value,
                    languages: controller.allLanguages,
                    onChanged: (lang) => controller.setTarget(lang),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Translator cards
              _TranslatorCard(
                mainText: controller.sourceLanguage.value?.name ?? "Select",
                leftIcon: Icons.volume_up,
                centerIcon: Icons.mic,
                rightIcon: Icons.send,
                onLeftPressed: () {},
                onCenterPressed: () {},
                onRightPressed: () {},
              ),

              const SizedBox(height: 30),

              _TranslatorCard(
                mainText: controller.targetLanguage.value?.name ?? "Select",
                leftIcon: Icons.volume_up,
                centerIcon: Icons.copy,
                rightIcon: Icons.history,
                onLeftPressed: () {},
                onCenterPressed: () {},
                onRightPressed: () {},
              ),
            ],
          );
        }),
      ),
    );
  }
}

/// Dropdown widget for selecting languages
class _LanguageDropdown extends StatelessWidget {
  final LanguageModel? selected;
  final List<LanguageModel> languages;
  final ValueChanged<LanguageModel> onChanged;

  const _LanguageDropdown({
    required this.selected,
    required this.languages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.30,
      height: context.screenHeight * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LanguageModel>(
          isExpanded: true,
          value: selected,
          dropdownColor: AppColors.secondary(context),
          items:
              languages
                  .map(
                    (lang) => DropdownMenuItem(
                      value: lang,
                      child: Text(
                        lang.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlackColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (lang) {
            if (lang != null) onChanged(lang);
          },
        ),
      ),
    );
  }
}

class _TranslatorCard extends StatelessWidget {
  final String mainText;
  final IconData leftIcon;
  final IconData centerIcon;
  final IconData rightIcon;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onCenterPressed;
  final VoidCallback? onRightPressed;

  const _TranslatorCard({
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
                      onPressed: () {}, // TODO: clear/remove action
                      icon: const Icon(Icons.highlight_remove),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Bottom icons row
              Container(
                width: double.infinity,
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
