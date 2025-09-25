import '/data/models/models.dart';
import 'utils.dart';

class ItemsUtil {
  static final List<ItemsModel> homeItems = [
    ItemsModel(assetPath: Assets.readingBook, label: "Learn Japanese"),
    ItemsModel(assetPath: Assets.practice, label: "Practice"),
    ItemsModel(assetPath: Assets.dictionary, label: "Japanese Dictionary"),
    ItemsModel(assetPath: Assets.translation, label: "Translator"),
    // ItemsModel(assetPath: Assets.grammar, label: "Grammar"),
    ItemsModel(assetPath: Assets.conversation, label: "Dialogues"),
    ItemsModel(assetPath: Assets.quotes, label: "Phrases"),
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

  static final List<ItemsModel> learnItems = [
    ItemsModel(assetPath: Assets.greetings),
    ItemsModel(assetPath: Assets.generalConversation),
    ItemsModel(assetPath: Assets.numbers),
    ItemsModel(assetPath: Assets.timeNDate),
    ItemsModel(assetPath: Assets.direction),
    ItemsModel(assetPath: Assets.transportation),
    ItemsModel(assetPath: Assets.accommodation),
    ItemsModel(assetPath: Assets.eating),
    ItemsModel(assetPath: Assets.shopping),
    ItemsModel(assetPath: Assets.colours),
    ItemsModel(assetPath: Assets.regions),
    ItemsModel(assetPath: Assets.countries),
    ItemsModel(assetPath: Assets.tourism),
    ItemsModel(assetPath: Assets.family),
    ItemsModel(assetPath: Assets.dating),
    ItemsModel(assetPath: Assets.emergency),
    ItemsModel(assetPath: Assets.sickness),
    ItemsModel(assetPath: Assets.tongueTwist),
    ItemsModel(assetPath: Assets.occasion),
    ItemsModel(assetPath: Assets.body),
  ];
}
