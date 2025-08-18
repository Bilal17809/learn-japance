import '../../Starte_learning/learn_japance.dart';

class CategoryType extends StatelessWidget {
  final CategoryItem item;

  const CategoryType({super.key, required this.item});

  // All phrase data
  static final Map<String, Map<String, dynamic>> phraseData = {
    "Noun Phrase": {
      "definition": "A phrase where a noun is the main word.",
      "examples": [
        "The big house",
        "A beautiful garden",
        "My best friend",
        "The tall man"
      ],
    },
    "Verb Phrase": {
      "definition": "A phrase where a verb is the main word.",
      "examples": [
        "is playing cricket",
        "will be singing",
        "has been working hard",
        "should have gone"
      ],
    },
    "Adjective Phrase": {
      "definition": "A phrase that describes a noun.",
      "examples": [
        "full of energy",
        "happy to see you",
        "difficult to understand",
        "interested in music"
      ],
    },
    "Adverb Phrase": {
      "definition": "A phrase that describes a verb, adjective, or another adverb.",
      "examples": [
        "with great speed",
        "in the morning",
        "after the party",
        "very carefully"
      ],
    },
    "Prepositional Phrase": {
      "definition":
      "A phrase that starts with a preposition and ends with a noun/pronoun.",
      "examples": ["on the table", "under the bridge", "at the park", "with my family"],
    },
    "Infinitive Phrase": {
      "definition": "A phrase beginning with 'to + verb'.",
      "examples": [
        "to read a book",
        "to win the match",
        "to help others",
        "to learn Japanese"
      ],
    },
    "Gerund Phrase": {
      "definition": "A phrase where a verb ends with -ing and acts as a noun.",
      "examples": [
        "Running every morning",
        "Eating healthy food",
        "Swimming in the sea",
        "Reading novels daily"
      ],
    },
    "Absolute Phrase": {
      "definition": "A phrase that modifies the whole sentence (adds extra info).",
      "examples": [
        "The sun having set, we went home.",
        "His hands shaking, he opened the letter.",
        "Her voice trembling, she gave the speech.",
        "The work completed, they took a rest."
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final phrase = phraseData[item.label]!;

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
          backgroundColor: bgcolor,
          title: Text(item.label)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView( // in case content grows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Definition:", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(phrase["definition"], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Text("Examples:", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              ...List<String>.from(phrase["examples"]).map(
                    (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("• $e", style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}