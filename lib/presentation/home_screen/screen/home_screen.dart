
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


