import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/presentation/jlpt_kanji/controller/jlpt_kanji_controller.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import '/core/common_widgets/common_widgets.dart';
import '/data/models/kanji_model.dart';

class KanjiBox extends StatelessWidget {
  final KanjiModel item;
  const KanjiBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JlptKanjiController>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kGap),
      decoration: AppDecorations.rounded(
        context,
      ).copyWith(border: Border.all(color: AppColors.kBlack, width: 1)),
      child: ExpansionTile(
        shape: const Border(),
        title: Text(item.kanji, style: titleLargeStyle),
        subtitle: Text(item.meanings.join(', '), style: titleSmallStyle),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kBodyHp),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "On’yomi readings: ${item.onReadings.join(', ')}",
                    style: bodyLargeStyle,
                  ),
                  Text(
                    "Kun’yomi readings: ${item.kunReadings.join(', ')}",
                    style: bodyLargeStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconActionButton(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text:
                                  'Kanji: ${item.kanji}\nMeaning:${item.meanings.join(', ')}\nOn’yomi: ${item.onReadings.join(', ')}\nKun’yomi: ${item.kunReadings.join(', ')}',
                            ),
                          );
                        },
                        icon: Icons.copy,
                      ),
                      IconActionButton(
                        onTap: () {
                          controller.onSpeak(item.kunReadings.first);
                        },
                        icon: Icons.volume_up,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
