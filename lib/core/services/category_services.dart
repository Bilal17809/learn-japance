
import '../../presentation/Starte_learning/learn_japance.dart';
final List<MenuItem> menuItems = [
  MenuItem(
    image: Image.asset(
      "images/3x/reading-book.png",

    ),
    label: "Learn Japanese",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/dictionary.png",

    ),
    label: "Japanese Dictionary",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/translation.png",

    ),
    label: "Translator",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/linguistics.png",

    ),
    label: "Grammar",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/left.png",

    ),
    label: "Phrases",
  ),
  MenuItem(
    image: Image.asset(
      "images/3x/dictionary.png",

    ),
    label: "",
  ),
];

class MenuItem {
  final Image image;
  final String label;
  MenuItem({required this.image, required this.label});
}


class MyProgressBar extends StatelessWidget {
  final double progress; // value between 0.0 and 1.0
  final Color backgroundColor;
  final Color progressColor;

  const MyProgressBar({
    super.key,
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: LinearProgressIndicator(
          value: progress, // e.g., 0.7 for 70%
          minHeight: 12,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
    );
  }
}



Widget buildMenuItem(IconData icon, String label) {
  return VStack([
    VxBox(child: Icon(icon, size: 30, color: Vx.gray800)).rounded.p16
        .color(Color(0xFFF5F7FA)) // light grey background
        .make(),
    8.heightBox,
    label.text.semiBold.size(14).make(),
  ]).onTap(() {
    // Handle tap action
  });
}

Widget LossonWOrdSentenco(int num, String label) {
  return VStack([
    num.text.semiBold.size(25).make().px2(),
    3.heightBox,
    label.text.semiBold.size(14).make(),
  ]).onTap(() {
    // Handle tap action
  });
}