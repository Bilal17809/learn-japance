import 'package:get/get.dart';
import 'package:learn_japan/presentation/Greeting/screen/greeting.dart';
import 'package:learn_japan/presentation/Translator/screen/translator.dart';

import '../../presentation/Starte_learning/learn_japance.dart';
import '../../presentation/Starte_learning/screen/start_learning.dart';
import '../../presentation/category/screen/category.dart';
import '../../presentation/cateory_type/screen/category_type.dart';
import '../../presentation/learn_japance/screen/learn_japanse.dart';

final List<MenuItem> menuItems = [
  MenuItem(
    image: Image.asset("images/3x/reading-book.png"),
    label: "Learn Japanese",
    targetScreen: StartLearning(),
  ),
  MenuItem(
    image: Image.asset("images/3x/dictionary.png"),
    label: "Japanese Dictionary",
    targetScreen: LearnJapanse(),
  ),
  MenuItem(
    image: Image.asset("images/3x/translation.png"),
    label: "Translator",
    targetScreen: Translator(),
  ),
  MenuItem(image: Image.asset("images/3x/linguistics.png"),
      label: "Grammar",
    targetScreen: Greeting()
  ),
  MenuItem(image: Image.asset("images/3x/left.png"), label: "Phrases",
    targetScreen:Category_screen(),),
  MenuItem(image: Image.asset("images/3x/dictionary.png"), label: "",
    targetScreen: StartLearning(),),
];

class MenuItem {
  final String label;
  final Widget image;
  final Widget targetScreen;

  MenuItem({
    required this.label,
    required this.image,
    required this.targetScreen,
  });
}

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kBodyHp),
      child: GridView.builder(
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return MenuItemCard(item: item);
        },
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => item.targetScreen);
      },
      child: Container(
        decoration: roundedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: roundedbgicondecotion,
              child: SizedBox(height: 28, width: 28, child: item.image),
            ),
            const SizedBox(height: 8),
            item.label.text.align(TextAlign.center).semiBold.size(14).make(),
          ],
        ),
      ),
    );
  }
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
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

Widget buildMenuItem(String imagePath, String label) {
  return VStack([
    VxBox(
      child: Image.asset(imagePath, width: 30),
    ).rounded.p16.color(Color(0xFFF5F7FA)).make(),
    8.heightBox,
    label.text.semiBold.size(14).make(),
  ]).onTap(() {
    // Handle tap action
  });
}

Widget lossonwordSentenco(int num, String label) {
  return VStack([
    num.text.semiBold.size(25).make().px2(),
    3.heightBox,
    label.text.semiBold.size(14).make(),
  ]).onTap(() {
    // Handle tap action
  });
}

final List<LearnjapItem> learnjapItems = [
  LearnjapItem(
    image: Image.asset("images/3x/hand-shake.png"),
    label: "Greetings",
  ),
  LearnjapItem(image: Image.asset("images/3x/chat.png"), label: "Conversation"),
  LearnjapItem(
    image: Image.asset("images/3x/calculator.png"),
    label: "Numbers",
  ),
  LearnjapItem(
    image: Image.asset("images/3x/calendar.png"),
    label: "Time & Date",
  ),
  LearnjapItem(
    image: Image.asset("images/3x/road-map.png"),
    label: "Direction",
  ),
  LearnjapItem(
    image: Image.asset("images/3x/delivery-truck.png"),
    label: "Transportation",
  ),

];

class LearnjapItem {
  final Image image;
  final String label;
  LearnjapItem({required this.image, required this.label});
}

class Learnjapance extends StatelessWidget {
  const Learnjapance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kBodyHp),
      child: GridView.builder(
        itemCount: learnjapItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = learnjapItems[index];
          return LearnjapanceCard(item: item);
        },
      ),
    );
  }
}

class LearnjapanceCard extends StatelessWidget {
  final LearnjapItem item;

  const LearnjapanceCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => StartLearning());
      },
      child: Container(
        decoration: roundedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: roundedbgicondecotion,
              child: SizedBox(height: 35, width: 35, child: item.image),
            ),
            const SizedBox(height: 8),
            item.label.text.align(TextAlign.center).semiBold.size(14).make(),
          ],
        ),
      ),
    );
  }
}
class Translatorcard extends StatelessWidget {
  final String mainText; // For the title
  final IconData leftIcon; // First icon in the bottom row
  final IconData centerIcon; // Second icon
  final IconData rightIcon; // Third icon
  final VoidCallback? onLeftPressed;
  final VoidCallback? onCenterPressed;
  final VoidCallback? onRightPressed;

  const Translatorcard({
    super.key,
    required this.mainText,
    required this.leftIcon,
    required this.centerIcon,
    required this.rightIcon,
    this.onLeftPressed,
    this.onCenterPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Top row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mainText.text.size(15).make().px(20),
            IconButton(
              onPressed: () {}, // Remove button
              icon: const Icon(Icons.highlight_remove),
            ),
          ],
        ),
        const Spacer(),
        // Bottom icons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onLeftPressed,
              icon: Icon(leftIcon, color: blackTextColor, size: 28),
            ),
            IconButton(
              onPressed: onCenterPressed,
              icon: Icon(centerIcon, color: blackTextColor, size: 28),
            ),
            IconButton(
              onPressed: onRightPressed,
              icon: Icon(rightIcon, color: blackTextColor, size: 28),
            ),
          ],
        ).box.size(screenw * 1, screenh * 0.06).color(diconbdcolor).make(),
      ],
    ).box
        .color(boxbgcolor)
        .size(screenw * 0.8, screenh * 0.25)
        .make()
        .card
        .make()
        .centered();
  }
}

final List<CategoryItem> category = [
  CategoryItem(
    image: Image.asset("images/3x/noun.png"),
    label: "Noun Phrase",
  ),
  CategoryItem(image: Image.asset("images/3x/verb.png"), label: "Verb Phrase"),
  CategoryItem(
    image: Image.asset("images/3x/adjective.png"),
    label: "Adjective Phrase",
  ),
  CategoryItem(
    image: Image.asset("images/3x/adverb.png"),
    label: "Adverb Phrase",
  ),
  CategoryItem(
    image: Image.asset("images/3x/prepositional.png"),
    label: "Prepositional Phrase",
  ),
  CategoryItem(
    image: Image.asset("images/3x/infinity.png"),
    label: "Infinitive Phrase",
  ),
  CategoryItem(
    image: Image.asset("images/3x/pencil.png"),
    label: "Gerund Phrase",
  ),
  CategoryItem(
    image: Image.asset("images/3x/absolute.png"),
    label: "Absolute Phrase",
  ),
];
class CategoryItem {
  final Image image;
  final String label;
  CategoryItem({required this.image, required this.label});
}
class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kBodyHp),
      child: GridView.builder(
        itemCount: category.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = category[index];
          return CategoryCard(item: item);
        },
      ),
    );
  }
}
class CategoryCard extends StatelessWidget {
  final CategoryItem item;

  const CategoryCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CategoryType(item: item));
      },

      child: Container(
        decoration: roundedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: roundedbgicondecotion,
              child: SizedBox(height: 35, width: 35, child: item.image),
            ),
            const SizedBox(height: 8),
            item.label.text.align(TextAlign.center).semiBold.size(14).make(),
          ],
        ),
      ),
    );
  }
}
class ToolsScreen extends StatelessWidget {
  ToolsScreen({super.key});

  final tools = [
    {"iconPath": "images/3x/pdf-file.png", "label": "Merge PDF"},
    {"iconPath": "images/3x/split.png", "label": "Split PDF"},
    {"iconPath": "images/3x/delete.png", "label": "Delete Page"},
    {"iconPath": "images/3x/scissors.png", "label": "Extract Page"},
    {"iconPath": "images/3x/padlock.png", "label": "Lock PDF"},
    {"iconPath": "images/3x/unlocked.png", "label": "Unlock PDF"},
    {"iconPath": "images/3x/rotate-right.png", "label": "Rotate Page"},
    {"iconPath": "images/3x/drop.png", "label": "Add Watermark"},
  ];

  // Example placeholder styles (replace with your actual constants)



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: tools.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Container(
              decoration: listdecoration,
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: CircleAvatar(
                  backgroundColor: iconbdcolor,
                  radius: 22,
                  child: Image.asset(
                    tools[index]["iconPath"] as String,
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text(
                  tools[index]["label"] as String,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                onTap: () {
                  // Handle action for each tool
                  print("${tools[index]["label"]} tapped");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

