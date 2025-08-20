import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_japan/core/theme/app_colors.dart';
import '/data/models/models.dart';
import '/core/services/services.dart';
import '/presentation/splash/controller/splash_controller.dart';
import '/core/theme/theme.dart';

class FilteredTestScreen extends StatefulWidget {
  final String selectedCategory;

  const FilteredTestScreen({super.key, required this.selectedCategory});

  @override
  State<FilteredTestScreen> createState() => _FilteredTestScreenState();
}

class _FilteredTestScreenState extends State<FilteredTestScreen> {
  final SplashController splashController = Get.find<SplashController>();
  final TranslationService translationService = TranslationService();

  // Translation cache to avoid repeated API calls
  final Map<String, String> translationCache = {};

  // Loading states for individual items
  final Map<String, bool> translatingStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedCategory),
        backgroundColor: AppColors.primaryColorLight,
        foregroundColor: AppColors.kBlack,
        elevation: 2,
      ),
      body: Obx(() {
        if (splashController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (splashController.japaneseData == null ||
            splashController.japaneseData!.isEmpty) {
          return const Center(
            child: Text('No data available', style: TextStyle(fontSize: 18)),
          );
        }

        // Filter data by selected category
        final filteredData =
            splashController.japaneseData!
                .where((item) => item.category == widget.selectedCategory)
                .toList();

        if (filteredData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No items found in "${widget.selectedCategory}" category',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Category info header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.primaryColorLight.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Icon(Icons.category, color: AppColors.primaryColorLight),
                  const SizedBox(width: 8),
                  Text(
                    '${filteredData.length} items in "${widget.selectedCategory}"',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // Filtered list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return JapaneseDataCard(
                    item: item,
                    translationService: translationService,
                    translationCache: translationCache,
                    translatingStates: translatingStates,
                    onTranslationStateChanged: () => setState(() {}),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

// You'll need to import or copy your existing JapaneseDataCard class here
// or make it available by moving it to a separate file and importing it
class JapaneseDataCard extends StatelessWidget {
  final GrammarModel item;
  final TranslationService translationService;
  final Map<String, String> translationCache;
  final Map<String, bool> translatingStates;
  final VoidCallback onTranslationStateChanged;

  const JapaneseDataCard({
    super.key,
    required this.item,
    required this.translationService,
    required this.translationCache,
    required this.translatingStates,
    required this.onTranslationStateChanged,
  });

  Future<void> _translateText(String key, String text) async {
    if (translationCache.containsKey(key)) return;

    translatingStates[key] = true;
    onTranslationStateChanged();

    try {
      final translation = await translationService.translateText(text);
      translationCache[key] = translation;
    } catch (e) {
      translationCache[key] = "Translation failed";
    } finally {
      translatingStates[key] = false;
      onTranslationStateChanged();
    }
  }

  Future<void> _translateExamples(List<String> examples) async {
    for (int i = 0; i < examples.length; i++) {
      final key = "${item.id}_example_$i";
      await _translateText(key, examples[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with ID and Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorLight.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.id.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Category
            _buildSectionWithTranslation(
              "Category",
              "カテゴリー",
              item.category,
              "${item.id}_category",
              Icons.category,
            ),
            const SizedBox(height: 12),

            // Description
            _buildSectionWithTranslation(
              "Description",
              "説明",
              item.description,
              "${item.id}_description",
              Icons.description,
            ),
            const SizedBox(height: 12),

            // Examples
            _buildExamplesSection(),
            const SizedBox(height: 16),

            // Translate All Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _translateAll(),
                icon: const Icon(Icons.translate),
                label: const Text('Translate All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColorLight,
                  foregroundColor: AppColors.kBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionWithTranslation(
    String englishLabel,
    String japaneseLabel,
    String text,
    String cacheKey,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                "$englishLabel ($japaneseLabel)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Original Japanese text
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          // Translation section
          Row(
            children: [
              Expanded(
                child:
                    translatingStates[cacheKey] == true
                        ? Row(
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
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                        : translationCache[cacheKey] != null
                        ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorLight.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            translationCache[cacheKey]!,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
              if (translationCache[cacheKey] == null &&
                  translatingStates[cacheKey] != true)
                IconButton(
                  onPressed: () => _translateText(cacheKey, text),
                  icon: const Icon(Icons.translate, size: 18),
                  tooltip: "Translate",
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, size: 16, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                "Examples (例文)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...item.examples.asMap().entries.map((entry) {
            final index = entry.key;
            final example = entry.value;
            final cacheKey = "${item.id}_example_$index";

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          example,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (translatingStates[cacheKey] == true) ...[
                    const SizedBox(height: 8),
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
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ] else if (translationCache[cacheKey] != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              translationCache[cacheKey]!,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.green.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _translateAll() async {
    // Translate category
    await _translateText("${item.id}_category", item.category);
    // Translate description
    await _translateText("${item.id}_description", item.description);
    // Translate examples
    await _translateExamples(item.examples);
  }
}
