import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/app_colors.dart';
import '/presentation/filtered_test.dart';
import '../controller/phrases_controller.dart';

class PhrasesView extends StatelessWidget {
  PhrasesView({super.key});

  final PhrasesController controller = Get.put(PhrasesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Category'),
        backgroundColor: AppColors.primaryColorLight,
        foregroundColor: AppColors.kBlack,
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.splashController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.splashController.japaneseData;
        if (data == null || data.isEmpty) {
          return const Center(
            child: Text('No data available', style: TextStyle(fontSize: 18)),
          );
        }

        final categories = controller.getUniqueCategories(data);

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final itemCount = controller.getCategoryItemCount(data, category);

            return CategoryCard(
              category: category,
              translatedCategory: controller.categoryTranslations[category],
              isTranslating: controller.translatingStates[category] ?? false,
              itemCount: itemCount,
              // onTap: () => _navigateToFilteredData(context, category),
              onTap: () {
                Get.to(() => FilteredTestScreen(selectedCategory: category));
              },
            );
          },
        );
      }),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final String? translatedCategory;
  final bool isTranslating;
  final int itemCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.translatedCategory,
    required this.isTranslating,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Category icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.category,
                  color: AppColors.primaryColorLight,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Category info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // English translation or loading indicator
                    if (isTranslating)
                      Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryColorLight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Translating...",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    else if (translatedCategory != null)
                      Text(
                        translatedCategory!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      Text(
                        category, // Fallback to Japanese
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 4),

                    // Japanese original in smaller text
                    if (!isTranslating && translatedCategory != null)
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 2),

                    // Item count
                    Text(
                      '$itemCount items',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
