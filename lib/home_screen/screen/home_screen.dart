import 'package:learn_japan/home_screen/home_screen.dart';

import '/core/constant/constant.dart';
import '../../core/services/category_services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteFA,
      appBar: AppBar(
        backgroundColor: kWhiteFA,
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.apps)),
            "LEARN JAPANESE".text.size(18).semiBold.make(),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "images/3x/men.png",
              width:55,
              height:55,
            ),
             20.heightBox,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kBodyHp),
                child: MenuGrid()
              ),
            ),
            // SizedBox(height: 15,),
            30.heightBox,
          ],
        ),
      ),
    );
  }
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
    return Container(
      decoration: roundedDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: roundedDecoration,
            child: SizedBox(
              height: 28,
              width: 28,
              child: item.image,
            ),
          ),
          const SizedBox(height: 8),
          item.label.text.align(TextAlign.center).semiBold.size(14).make(),
        ],
      ),
    );
  }
}
