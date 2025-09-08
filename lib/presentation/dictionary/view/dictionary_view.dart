import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/utils/utils.dart';
import 'package:lottie/lottie.dart';
import '/core/common_widgets/common_widgets.dart';
import '/presentation/dictionary/controller/dictionary_controller.dart';

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionaryController>();
    final searchController = TextEditingController();
    return Scaffold(
      appBar: TitleBar(title: 'Dictionary'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.getFilteredData();
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBodyHp,
                  vertical: kGap,
                ),
                child: SearchBarField(
                  controller: searchController,
                  onSearch: (val) => controller.searchQuery.value = val,
                ),
              ),
              Expanded(
                child:
                    data.isEmpty
                        ? Lottie.asset(
                          Assets.searchError,
                          width: context.screenWidth * 0.41,
                        )
                        : Padding(
                          padding: const EdgeInsets.all(kBodyHp),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(kBodyHp),
                                  decoration: AppDecorations.rounded(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.menu_book_rounded,
                                                color: AppColors.icon(context),
                                                size: secondaryIcon(context),
                                              ),
                                              const SizedBox(width: kGap),
                                              Text(
                                                'Word:',
                                                style: titleSmallStyle,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconActionButton(
                                                icon: Icons.volume_up,
                                                color: AppColors.icon(context),
                                              ),
                                              const SizedBox(width: kGap),
                                              Tooltip(
                                                message: 'Copy All',
                                                child: IconActionButton(
                                                  onTap: () {},
                                                  icon: Icons.copy,
                                                  color: AppColors.icon(
                                                    context,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: kGap),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'English:',
                                            style: titleSmallStyle,
                                          ),
                                          const SizedBox(width: kGap),
                                          Expanded(
                                            child: Text(
                                              'meaning',
                                              style: titleSmallStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: kGap),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Japanese:',
                                            style: titleSmallStyle,
                                          ),
                                          const SizedBox(width: kGap),
                                          Expanded(
                                            child: Text('selected word'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: kElementGap),
                              ],
                            ),
                          ),
                        ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
