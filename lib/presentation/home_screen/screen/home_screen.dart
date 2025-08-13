
import '../home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw=MediaQuery.of(context).size.width;
    final screenh=MediaQuery.of(context).size.height;
      return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading:  Image.asset("images/2x/four-circle.png",),
        title: "LEARN JAPANESE".text.size(18).semiBold.make(),

      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "images/3x/men.png",
              // width: 250,
              height: 250,

            ),
             20.heightBox,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kBodyHp),
                child: MenuGrid()
              ),
            ),
            // SizedBox(height: 15,),
            // 15.heightBox,
            "ADD/".text.semiBold.size(15).make().centered().box.color(bgadd).size(screenw*1, screenh*0.09).make(),
            45.heightBox,
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
    return InkWell(
      onTap: () {
        Get.to(()=>StartLearning());
      },
      child: Container(
        decoration: roundedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: roundedbgicondecotion,
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
      ),
    );
  }
}
