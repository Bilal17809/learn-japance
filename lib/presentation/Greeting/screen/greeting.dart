import 'package:flutter/material.dart';
import '/core/theme/theme.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/2x/four-circle.png"),
        title: const Text(
          "LEARN JAPANESE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600, // semiBold
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Greeting",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 10),

              PhraseCard(
                english: "Salam",
                japanese: "サラーム",
                screenw: screenw,
                screenh: screenh,
              ),

              const SizedBox(height: 15),

              PhraseCard(
                english: "How are you",
                japanese: "元気ですか",
                screenw: screenw,
                screenh: screenh,
              ),

              const SizedBox(height: 15),

              PhraseCard(
                english: "Good Morning",
                japanese: "おはよう",
                screenw: screenw,
                screenh: screenh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// PhraseCard widget (English + Japanese)
class PhraseCard extends StatelessWidget {
  final String english;
  final String japanese;
  final double screenw;
  final double screenh;

  const PhraseCard({
    super.key,
    required this.english,
    required this.japanese,
    required this.screenw,
    required this.screenh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EnglishCard(english: english, screenw: screenw, screenh: screenh),
        const SizedBox(height: 5),
        JapaneseCard(japanese: japanese, screenw: screenw, screenh: screenh),
      ],
    );
  }
}

/// English phrase container with icons
class EnglishCard extends StatelessWidget {
  final String english;
  final double screenw;
  final double screenh;

  const EnglishCard({
    super.key,
    required this.english,
    required this.screenw,
    required this.screenh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenw,
      height: screenh * 0.09,
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(english, style: const TextStyle(fontSize: 20)),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.volume_up_outlined),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Japanese phrase container
class JapaneseCard extends StatelessWidget {
  final String japanese;
  final double screenw;
  final double screenh;

  const JapaneseCard({
    super.key,
    required this.japanese,
    required this.screenw,
    required this.screenh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenw,
      height: screenh * 0.09,
      decoration: BoxDecoration(
        color: AppColors.primary(context).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 15, top: 20),
      child: Text(
        japanese,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
      ),
    );
  }
}
