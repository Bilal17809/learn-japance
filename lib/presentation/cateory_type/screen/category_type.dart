import '../../Starte_learning/learn_japance.dart';

class CategoryType extends StatelessWidget {
  final CategoryItem item;

  const CategoryType({super.key, required this.item});


  @override
  Widget build(BuildContext context) {
    final phrase = PhraseData.phraseData[item.label]!;

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