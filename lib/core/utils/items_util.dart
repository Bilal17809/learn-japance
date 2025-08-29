import '/data/models/models.dart';
import 'utils.dart';

class ItemsUtil {
  static final List<ItemsModel> homeItems = [
    ItemsModel(assetPath: Assets.readingBook, label: "Learn Japanese"),
    ItemsModel(assetPath: Assets.dictionary, label: "Japanese Dictionary"),
    ItemsModel(assetPath: Assets.translation, label: "Translator"),
    ItemsModel(assetPath: Assets.grammar, label: "Grammar"),
    ItemsModel(assetPath: Assets.quotes, label: "Phrases"),
    ItemsModel(assetPath: Assets.practice, label: "Practice"),
    ItemsModel(assetPath: Assets.speaking, label: "Speaking"),
    ItemsModel(assetPath: Assets.quiz, label: "Quiz"),
    ItemsModel(assetPath: Assets.convo, label: "Dialog"),
  ];
  static final List<ItemsModel> grammarItems = [
    ItemsModel(assetPath: Assets.adverb),
    ItemsModel(assetPath: Assets.auxVerb),
    ItemsModel(assetPath: Assets.particle),
    ItemsModel(assetPath: Assets.verbConjugation),
    ItemsModel(assetPath: Assets.adjective),
    ItemsModel(assetPath: Assets.conjunction),
    ItemsModel(assetPath: Assets.honoraryLanguage),
    ItemsModel(assetPath: Assets.sentencePattern),
    ItemsModel(assetPath: Assets.questionWord),
    ItemsModel(assetPath: Assets.performance),
  ];
}
