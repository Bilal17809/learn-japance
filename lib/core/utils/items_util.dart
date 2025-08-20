import '/data/models/models.dart';
import 'utils.dart';

class ItemsUtil {
  static final List<ItemsModel> homeItems = [
    ItemsModel(assetPath: Assets.readingBook, label: "Learn Japanese"),
    ItemsModel(assetPath: Assets.dictionary, label: "Japanese Dictionary"),
    ItemsModel(assetPath: Assets.translation, label: "Translator"),
    ItemsModel(assetPath: Assets.linguistics, label: "Grammar"),
    ItemsModel(assetPath: Assets.quotes, label: "Phrases"),
    ItemsModel(assetPath: Assets.dictionary, label: ""),
  ];
}
